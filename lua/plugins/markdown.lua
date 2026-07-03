return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, {
        markdown = {},
        ["markdown.mdx"] = {},
      })
      opts.linters["markdownlint-cli2"] = vim.tbl_deep_extend("force", opts.linters["markdownlint-cli2"] or {}, {
        args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint-cli2.yaml", "-" },
      })
    end,
  },
}
