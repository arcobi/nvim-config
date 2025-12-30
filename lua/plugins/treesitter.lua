return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- This function merges our config with the default one
    --vim.list_extend(opts.parsers.c.install_info.compile.compile_cmds, {
    --"clang",
    --})

    -- Or, to completely override the compiler search list:
    require("nvim-treesitter.install").compilers = { "clang", "gcc", "cc" }
  end,
}
