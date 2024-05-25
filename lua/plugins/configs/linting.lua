local lint = require("lint")

-- add linters here
lint.linters_by_ft = {
  yaml = { "yamllint" },
  dockerfile = { "hadolint" }
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- add diagnostic symbols
local function lspSymbol(name, icon)
  vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = "LspDiagnosticsSign" .. name })
end
lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "󰌵")
lspSymbol("Info", "")
lspSymbol("Warning", "")
lspSymbol("Warn", "")
