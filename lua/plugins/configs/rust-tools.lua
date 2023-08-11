return {
  server = {
    on_attach = require("plugins.configs.lsp").on_attach,
    capabilities = require("plugins.configs.lsp").capabilities,
  }
}
