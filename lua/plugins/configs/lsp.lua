-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  -- NOTE: conflicts with tmux navigator
  -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")
end

local servers = {
  marksman = {},
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gotpl" },
    root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
    settings = { -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      gopls = {
        templateExtensions = { "gotmpl", "gotpl", "tpl" },
        completeUnimported = true,
        analyses = {
          unusedparams = true,
          fieldalignment = true,
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
  },
  ruff = {
    init_options = {
      settings = {
        -- args = { "--ignore F405,E402" }, -- "--ignore-noqa" }, -- allows for sys.path before import and for * imports
      },
    },
    commands = {
      RuffAutofix = {
        function()
          vim.lsp.buf.execute_command({
            command = "ruff.applyAutofix",
            arguments = {
              { uri = vim.uri_from_bufnr(0) },
            },
          })
        end,
        description = "Ruff: Fix all auto-fixable problems",
      },
      RuffOrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "ruff.applyOrganizeImports",
            arguments = {
              { uri = vim.uri_from_bufnr(0) },
            },
          })
        end,
        description = "Ruff: Format imports",
      },
    },
  },
  bashls = {
    filetypes = { "sh", "zsh", "bash" },
    root_dir = require("lspconfig/util").root_pattern(".git", ".bashrc", ".zshrc"),
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        telemetry = { enable = false },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  config.on_attach = on_attach
  require("lspconfig")[server].setup(config)
end

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_test = false,
  float = {
    show_header = true,
    source = "if_many",
    border = "rounded",
    focusable = false,
  },
  update_in_insert = false,
  severity_sort = true,
})
