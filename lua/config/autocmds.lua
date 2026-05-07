vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl_groups = {
      "NormalFloat",
      "FloatBorder",
      "LazyNormal",
      "MasonNormal",
    }
    for _, group in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})

local function hide_tabline()
  vim.opt.showtabline = 0
  vim.opt.tabline = ""
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = hide_tabline,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = hide_tabline,
})
