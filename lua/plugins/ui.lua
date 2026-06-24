return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status({ cwd = LazyVim.root.git() })
        end,
        desc = "Git Status",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff({ cwd = LazyVim.root.git() })
        end,
        desc = "Git Diff",
      },
    },
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            function()
              local cwd = LazyVim.root.git()
              local status = vim.fn.systemlist({ "git", "-C", cwd, "status", "--short", "--branch" })
              if vim.v.shell_error ~= 0 then
                return nil
              end

              local lines = vim.tbl_filter(function(line)
                return line:match("%S")
              end, status)
              local text = #lines > 1 and table.concat(lines, "\n") or (lines[1] or "## clean")
              local open_status = function()
                Snacks.picker.git_status({ cwd = cwd })
              end

              return {
                icon = " ",
                title = "Git Status",
                action = open_status,
                key = "S",
                { text = text, padding = 1, action = open_status },
              }
            end,
          },
          { section = "startup" },
        },
        preset = {
          -- Customize the ASCII art here
          header = [[
                                       █████      ███ 
                                      ░░███      ░░░  
  ██████   ████████   ██████   ██████  ░███████  ████ 
 ░░░░░███ ░░███░░███ ███░░███ ███░░███ ░███░░███░░███ 
  ███████  ░███ ░░░ ░███ ░░░ ░███ ░███ ░███ ░███ ░███ 
 ███░░███  ░███     ░███  ███░███ ░███ ░███ ░███ ░███ 
░░████████ █████    ░░██████ ░░██████  ████████  █████
 ░░░░░░░░ ░░░░░      ░░░░░░   ░░░░░░  ░░░░░░░░  ░░░░░ 
                                                      
                                                      
                                                      
          ]],
        },
      },
    },
  },
}
