return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
    keys = {
      {
        "<C-y>",
        'copilot#Accept("\\<CR>")',
        mode = "i",
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot Suggestion",
      },
      { "<leader>ap", "<cmd>Copilot panel<cr>", desc = "Copilot Panel" },
      { "<leader>aP", "<cmd>Copilot status<cr>", desc = "Copilot Status" },
    },
  },
}
