#!/usr/bin/env bash

set -u

cpu_state_file="/tmp/tmux_cpu_${UID}.dat"
cpu_cap=2000

tmux_color() {
  printf '#[fg=%s]%s#[default]' "$1" "$2"
}

util_color() {
  local pct=$1
  if (( pct > 90 )); then
    printf '%s' "colour196"
  elif (( pct > 70 )); then
    printf '%s' "colour208"
  else
    printf '%s' "black"
  fi
}

format_gb_tenths() {
  local mib=$1
  local whole tenths
  whole=$((mib / 1024))
  tenths=$(( ((mib % 1024) * 10 + 512) / 1024 ))
  if (( tenths == 10 )); then
    whole=$((whole + 1))
    tenths=0
  fi
  printf "%s.%sGB" "$whole" "$tenths"
}

read_cpu_sample() {
  awk '/^cpu / {print $2, $3, $4, $5, $6, $7, $8, $9}' /proc/stat
}

cpu_util() {
  local user nice system idle iowait irq softirq steal
  read -r user nice system idle iowait irq softirq steal < <(read_cpu_sample)

  local idle_all total
  idle_all=$((idle + iowait))
  total=$((user + nice + system + idle + iowait + irq + softirq + steal))

  if [[ -r "$cpu_state_file" ]]; then
    local prev_total prev_idle total_delta idle_delta busy_delta usage scaled_pct color
    read -r prev_total prev_idle < "$cpu_state_file"
    echo "$total $idle_all" > "$cpu_state_file"

    total_delta=$((total - prev_total))
    idle_delta=$((idle_all - prev_idle))

    if (( total_delta > 0 )); then
      busy_delta=$((total_delta - idle_delta))
      usage=$(( (cpu_cap * busy_delta + total_delta / 2) / total_delta ))
      if (( usage < 0 )); then
        usage=0
      elif (( usage > cpu_cap )); then
        usage=$cpu_cap
      fi

      scaled_pct=$(( (100 * usage + cpu_cap / 2) / cpu_cap ))
      color=$(util_color "$scaled_pct")
      tmux_color "$color" "CPU ${usage}%"
      return
    fi
  else
    echo "$total $idle_all" > "$cpu_state_file"
  fi

  tmux_color "colour244" "CPU --"
}

ram_util() {
  local total avail used pct
  total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
  avail=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

  if [[ -n "$total" && -n "$avail" && "$total" != "0" ]]; then
    used=$((total - avail))
    pct=$(( (100 * used + total / 2) / total ))
    tmux_color "$(util_color "$pct")" "RAM $(format_gb_tenths $((used / 1024)))"
  else
    tmux_color "colour244" "RAM --"
  fi
}

gpu_metrics() {
  if ! command -v nvidia-smi >/dev/null 2>&1; then
    printf "%s | %s" \
      "$(tmux_color "colour244" "VRAM --/--GB")" \
      "$(tmux_color "colour244" "GPU --W")"
    return
  fi

  local mem_used mem_total power_draw vram_pct watts
  IFS=, read -r mem_used mem_total power_draw < <(
    nvidia-smi --query-gpu=memory.used,memory.total,power.draw --format=csv,noheader,nounits 2>/dev/null | head -n1
  )

  mem_used=${mem_used//[[:space:]]/}
  mem_total=${mem_total//[[:space:]]/}
  power_draw=${power_draw//[[:space:]]/}
  watts=${power_draw%.*}
  if [[ -z "$watts" || "$watts" == "$power_draw" && ! "$watts" =~ ^[0-9]+$ ]]; then
    watts="--"
  fi

  if [[ -n "$mem_used" && -n "$mem_total" && "$mem_total" != "0" ]]; then
    vram_pct=$(( (100 * mem_used + mem_total / 2) / mem_total ))
    printf "%s | %s" \
      "$(tmux_color "$(util_color "$vram_pct")" "VRAM $(format_gb_tenths "$mem_used")")" \
      "$(tmux_color "$(util_color "$vram_pct")" "GPU ${watts}W")"
  else
    printf "%s | %s" \
      "$(tmux_color "colour244" "VRAM --")" \
      "$(tmux_color "colour244" "GPU ${watts}W")"
  fi
}

printf "%s | %s | %s" "$(cpu_util)" "$(ram_util)" "$(gpu_metrics)"
