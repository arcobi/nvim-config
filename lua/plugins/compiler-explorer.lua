return {
  {
    "krady21/compiler-explorer.nvim",
    cmd = {
      "CEAddLibrary",
      "CECompile",
      "CECompileLive",
      "CEDeleteCache",
      "CEFormat",
      "CEGotoLabel",
      "CELoadExample",
      "CEOpenWebsite",
      "CEShowTooltip",
    },
    opts = {
      url = "https://godbolt.org",
      infer_lang = true,
      line_match = {
        highlight = true,
        jump = false,
      },
      open_qflist = true,
      split = "vsplit",
      compiler_flags = "-O2",
    },
    keys = {
      { "<leader>ce", "<cmd>CECompile<cr>", mode = { "n", "v" }, desc = "Compiler Explorer" },
      { "<leader>cE", "<cmd>CECompile!<cr>", mode = { "n", "v" }, desc = "Compiler Explorer Split" },
      { "<leader>cl", "<cmd>CECompileLive<cr>", desc = "Compiler Explorer Live" },
      { "<leader>cW", "<cmd>CEOpenWebsite<cr>", desc = "Compiler Explorer Website" },
    },
  },
}
