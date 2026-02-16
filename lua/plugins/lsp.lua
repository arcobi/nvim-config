return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never", -- STOP THE AUTO-INCLUDES
            "--compile-commands-dir=build",
          },
        },
      },
    },
  },
}
