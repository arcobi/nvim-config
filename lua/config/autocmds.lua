vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Init", {}),
  callback = function()
    Snacks.picker.files()
  end,
})
