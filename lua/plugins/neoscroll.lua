return {
  "karb94/neoscroll.nvim",
  opts = {
    stop_eof = true,
    hide_cursor = true,
  },
  keys = {
    {
      "<C-d>",
      function()
        require("neoscroll").ctrl_d({ duration = 150 })
        vim.cmd("normal! zz")
      end,
      mode = { "n", "v", "x" },
      desc = "Scroll down and center",
    },
    {
      "<C-u>",
      function()
        require("neoscroll").ctrl_u({ duration = 150 })
        vim.cmd("normal! zz")
      end,
      mode = { "n", "v", "x" },
      desc = "Scroll up and center",
    },
  },
}
