return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            cmd = "git status --short",
            height = 5,
            padding = 1,
            ttl = 5 * 60, -- Refresh every 5 mins
          },
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
