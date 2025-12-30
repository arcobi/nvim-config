return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          -- We must override the command to add --query-driver
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            -- IMPORTANT: This path allows clangd to talk to the PIO compiler
            "--query-driver=/home/vivi/.platformio/packages/toolchain-*/bin/*",
          },
        },
      },
    },
  },
}
