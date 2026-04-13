local uv = vim.uv or vim.loop

local function path_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function has_any(root, paths)
  for _, path in ipairs(paths) do
    if path_exists(root .. "/" .. path) then
      return true
    end
  end
  return false
end

local function get_compile_commands_dir(root)
  if path_exists(root .. "/compile_commands.json") then
    return "."
  end

  if path_exists(root .. "/build/compile_commands.json") then
    return "build"
  end
end

local function is_platformio_project(root)
  return has_any(root, { "platformio.ini", ".pio" })
end

local function is_ros2_project(root)
  return has_any(root, { "package.xml", "colcon.pkg", "ament_cmake_environment_hooks" })
end

local function build_clangd_cmd(root)
  local cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
  }

  local compile_commands_dir = get_compile_commands_dir(root)
  if compile_commands_dir then
    table.insert(cmd, "--compile-commands-dir=" .. compile_commands_dir)
  end

  if is_platformio_project(root) then
    vim.list_extend(cmd, {
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
      "--query-driver=/home/vivi/.platformio/packages/toolchain-*/bin/*",
    })
  elseif is_ros2_project(root) then
    table.insert(cmd, "--query-driver=/usr/bin/ros-*-linux-gnu-g++,/usr/bin/g++")
  end

  return cmd
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
            },
          },
        },
      }

      opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
        cmd = build_clangd_cmd(vim.fn.getcwd()),
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd = build_clangd_cmd(new_root_dir)
        end,
      })
    end,
  },
}
