return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gotpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {   -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    gopls = {
      templateExtensions = { "gotmpl", "gotpl", "tpl" },
      completeUnimported = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        unusedvariable = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
        functionTypeParameters = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true
      }
    },
  },
}
