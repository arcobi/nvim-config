return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false, -- Do not automatically highlight the first item
          auto_insert = false,
        },
      },
    },
    keymap = {
      preset = "none", -- Clear presets to avoid conflicts
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      -- Add other mappings as needed
    },
  },
}
