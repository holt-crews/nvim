-- https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
local root_has_file = function(files)
  return function(utils)
    return utils.root_has_file(files)
  end
end

-- Here is the formatting config
local null_ls = require("null-ls")
local lSsources = {
  null_ls.builtins.formatting.prettierd.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "md",
      "txt",
    },
  }),
  null_ls.builtins.formatting.eslint_d.with({
    filetypes = {
      "javascript",
      "typescript",
    },
    -- ensures that eslint_d is only used as formatter when no prettier config is setup
    condition = function(utils)
      local has_eslint = root_has_file(eslint_root_files)(utils)
      local has_prettier = root_has_file(prettier_root_files)(utils)
      return has_eslint and not has_prettier
    end,
  }),

  null_ls.builtins.formatting.stylua.with({
    filetypes = {
      "lua",
    },
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),

  -- might require some additional setup/installation: https://github.com/disrupted/blackd-client
  null_ls.builtins.formatting.blackd.with({
    filetypes = {
      "python",
    },
  }),
  -- null_ls.builtins.diagnostics.mypy,

  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.goimports_reviser,
  null_ls.builtins.formatting.golines,
}

require("null-ls").setup({
  sources = lSsources,
})
