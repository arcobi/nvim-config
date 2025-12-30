return {
  -- The name of the plugin must match the one used by LazyVim
  "folke/noice.nvim",

  -- Use the opts function to override default settings
  opts = function(_, opts)
    -- Ensure the tables exist before assigning to them
    opts.cmdline = opts.cmdline or {}
    opts.cmdline.view = "cmdline"

    opts.messages = opts.messages or {}
    opts.messages.view = "cmdline"
  end,
}
