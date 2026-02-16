return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    window = {
      position = "right",
      width = 0.33, -- Slightly wider to see C++ implementations clearly
    },
  },
  keys = {
    -- Toggle the main Claude sidebar
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },

    -- Visual Mode: Select code and press <leader>as to send it for explanation or editing
    {
      "<leader>as",
      ":ClaudeCodeSend<cr>",
      mode = "v",
      desc = "Send selection to Claude",
    },

    -- Resume the last session (useful if SSH connection drops)
    { "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "Resume Claude Session" },
  },
}
