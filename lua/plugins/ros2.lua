return {
  -- Adds support for .msg, .srv, and .action files
  {
    "ErickKramer/nvim-ros2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },

  -- Configure clangd to look for your ROS 2 compile commands
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--compile-commands-dir=.", -- Search for the symlink in project root
            "--query-driver=/usr/bin/ros-*-linux-gnu-g++,/usr/bin/g++", -- Critical for ROS headers
          },
        },
      },
    },
  },
}
