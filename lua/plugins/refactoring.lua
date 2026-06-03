local function ensure_iter_unique()
  local iter = vim.iter({})
  local iter_methods = getmetatable(iter).__index
  if iter_methods.unique then
    return
  end

  iter_methods.unique = function(self, key)
    local seen = {}
    return self:filter(function(item)
      local value = key and key(item) or item
      if seen[value] then
        return false
      end
      seen[value] = true
      return true
    end)
  end
end

return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    init = ensure_iter_unique,
    config = function(_, opts)
      ensure_iter_unique()
      require("refactoring").setup(opts)
    end,
    keys = {
      {
        "<leader>rs",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor",
      },
      {
        "<leader>ri",
        function()
          return require("refactoring").inline_var()
        end,
        mode = { "n", "x" },
        desc = "Inline Variable",
        expr = true,
      },
      {
        "<leader>rf",
        function()
          return require("refactoring").extract_func()
        end,
        mode = { "n", "x" },
        desc = "Extract Function",
        expr = true,
      },
      {
        "<leader>rF",
        function()
          return require("refactoring").extract_func_to_file()
        end,
        mode = { "n", "x" },
        desc = "Extract Function To File",
        expr = true,
      },
      {
        "<leader>rx",
        function()
          return require("refactoring").extract_var()
        end,
        mode = { "n", "x" },
        desc = "Extract Variable",
        expr = true,
      },
      {
        "<leader>rP",
        function()
          return require("refactoring.debug").print_loc({ output_location = "above" })
        end,
        mode = "n",
        desc = "Debug Print",
        expr = true,
      },
      {
        "<leader>rp",
        function()
          return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
        end,
        mode = "n",
        desc = "Debug Print Variable",
        expr = true,
      },
      {
        "<leader>rp",
        function()
          return require("refactoring.debug").print_var({ output_location = "below" })
        end,
        mode = "x",
        desc = "Debug Print Variable",
        expr = true,
      },
      {
        "<leader>rc",
        function()
          return require("refactoring.debug").cleanup({ restore_view = true })
        end,
        mode = { "n", "x" },
        desc = "Debug Cleanup",
        expr = true,
        remap = true,
      },
    },
  },
}
