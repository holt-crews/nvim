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
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = lSsources,
  on_attach = function(client, bufnr)
    -- this chunk formats on save
    -- if client.supports_method("textDocument/formatting") then
    --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   group = augroup,
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.format({
    --       bufnr = bufnr,
    --       filter = function(client)
    --         return client.name == "null-ls"
    --       end,
    --     })
    --   end,
    -- })
    -- end
  end,
})
