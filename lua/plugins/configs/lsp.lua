-- Setup neovim lua configuration
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")
end

-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = false, lsp_fallback = "always", range = range })
end, { range = true, desc = "Format current buffer with Conform" })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  marksman = {},
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gotpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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
        -- inlayHints aren't available in neovim until v0.10.0
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
  ruff_lsp = {
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
  -- pyright = {
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         useLibraryCodeForTypes = true,
  --         diagnosticSeverityOverrides = {
  --           reportUnusedVariable = "warning", -- or anything
  --           reportImportCycles = "warning",
  --           reportUnknownMemberType = "warning",
  --           reportUnknownLambdaType = "warning",
  --           reportUnknownArgumentType = "warning",
  --           reportUnknownParameterType = "warning",
  --           reportUnknownVariableType = "warning",
  --           reportMissingTypeArgument = "warning",
  --           -- reportGeneralTypeIssues = "warning",
  --         },
  --         typeCheckingMode = "strict", -- use mypy
  --       },
  --     },
  --   },
  --   capabilities = (function()
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
  --     return capabilities
  --   end)(),
  -- },
  -- https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
  -- black formatting is not working with this for some reason
  -- pylsp = {
  --   plugins = {
  --     -- formatter options
  --     black = { enabled = true },
  --     autopep8 = { enabled = false },
  --     yapf = { enabled = false },
  --     -- linter options
  --     pylint = { enabled = true, executable = "pylint" },
  --     pyflakes = { enabled = false },
  --     pycodestyle = { enabled = false },
  --     -- type checker
  --     pylsp_mypy = { enabled = true },
  --     -- auto-completion options
  --     jedi_completion = { fuzzy = true },
  --     -- import sorting
  --     -- pyls_isort = { enabled = true },
  --   },
  -- },
  bashls = {
    filetypes = { "sh", "zsh", "bash" },
    root_dir = util.root_pattern(".git", ".bashrc", ".zshrc"),
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

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

local default_config = {
  capabilities = capabilities,
  on_attach = on_attach,
}

mason_lspconfig.setup_handlers({
  function(server_name)
    -- this merges "default_config" and the custom config for the server
    lspconfig[server_name].setup(vim.tbl_deep_extend("force", default_config, servers[server_name] or {}))
  end,
})

return default_config
