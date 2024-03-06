-- some eslint and prettier stuff: https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
-- I need to look into nvim-lint+conform, check out kickstart.nvim for details

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

  -- mypy config for conda
  -- null_ls.builtins.diagnostics.mypy.with({
  --   extra_args = function()
  --     local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
  --     return { "--python-executable", virtual .. "/bin/python3" }
  --   end,
  -- }),
  --
  null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
  null_ls.builtins.diagnostics.yamllint,

  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.goimports_reviser,
  null_ls.builtins.formatting.golines,
}

require("null-ls").setup({
  sources = lSsources,
})
