-- https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
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
}

-- used for format on save
require("null-ls").setup({
  sources = lSsources,
})
