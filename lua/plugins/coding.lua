vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", function() require("telescope.builtin").lsp_definitions() end, "[G]oto [D]efinition")
    nmap("<leader>gr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")
    nmap("<leader>gi", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementations")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, "[L]ist [S]ymbols")
    nmap("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
      "[W]orkspace [S]ymbols")

    -- NOTE: conflicts with tmux navigator
    -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    if client and client:supports_method("textDocument/documentHighlight") then
      local group = vim.api.nvim_create_augroup("lsp_highlight_" .. ev.buf, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  update_in_insert = false, -- default to false
  severity_sort = true,     -- default to false
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
    linehl = {},
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  }
})

return {
  { "j-hui/fidget.nvim", event = "VeryLazy", opts = {} },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    event = "BufReadPost",
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      -- experimental signature help support
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
  {
    "mfussenegger/nvim-lint",
    ft = { "yaml", "dockerfile" },
    cmd = "LintInfo",
    config = function()
      local lint = require("lint")

      -- Show linters for the current buffer's file type
      vim.api.nvim_create_user_command("LintInfo", function()
        local filetype = vim.bo.filetype
        local linters = require("lint").linters_by_ft[filetype]

        if linters then
          print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
        else
          print("No linters configured for filetype: " .. filetype)
        end
      end, {})


      -- add linters here
      lint.linters_by_ft = {
        -- go = { "golangcilint" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
        -- json = { "jsonlint" }
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
      lint.try_lint()
    end,
  },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {
      display_package = true,
      highlight = "GoImplements"
    },
  },
  {
    'stevearc/conform.nvim',
    cmd = "Format",
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        go = { "gci" },
        markdown = { "deno_fmt", "injected" },
        sh = { "shfmt" },
        json = { "jq" },
        jsonc = { "jq" },
        yaml = { "prettierd" },
        graphql = { "prettierd" },
      },
      formatters = {
        prettierd = {
          ft_parsers = {
            yaml = "yaml",
            graphql = "graphql",
          },
        },
        gci = {
          args = { "write", "$FILENAME", "-s", "standard", "-s", "default", "-s", "localmodule" }
        }
      }
    },
    config = function(_, opts)
      require("conform").setup(opts)
      require("conform").formatters.jq = { prepend_args = { "--tab" } }

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
    end,
  },
}
