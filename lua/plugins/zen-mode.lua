return {
  "folke/zen-mode.nvim",
  -- Set this to ensure the plugin is loaded
  enabled = true,
  opts = {
    window = {
      -- Width/Height is relative to the editor area
      width = 0.7, -- Use 70% of the screen width
      height = 0.9, -- Use 90% of the screen height

      -- Optional: Center the content vertically
      -- zenith = 80,
    },
    -- Optional: If you use the 'twosun' colorscheme, for example
    -- colorscheme = "twosun",
  },
  -- Define the keymap to toggle Zen Mode (already done by LazyVim, but ensures config)
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
}
