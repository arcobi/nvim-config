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
  callback = function()
    hide_tabline()
    vim.g.autoformat = false
  end,
})

local function disable_auto_line_formatting()
  vim.b.autoformat = false
  vim.opt_local.textwidth = 0
  vim.opt_local.formatoptions:remove({ "t", "c", "r", "o" })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = disable_auto_line_formatting,
})
