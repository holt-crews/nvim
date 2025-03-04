return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.lsp")
    end,
    dependencies = {
      "saghen/blink.cmp",
      { "williamboman/mason.nvim", config = true },
      { "j-hui/fidget.nvim",       opts = {} }
    },
  },
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
      }
    }
  },
  {
    "saghen/blink.cmp",
    event = "BufReadPost",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions a priority
            score_offset = 100,
          }
        }
      },
      -- experimental signature help support
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
    config = function(_, _)
      local config = require("plugins.configs.lsp")
      require("rust-tools").setup(config)

      require("which-key").register({
        ["<leader>rcu"] = {
          function()
            require("crates").upgrade_all_crates()
          end,
          "[r]ust [c]rates [u]update",
        },
      })
    end
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = "typescript",
    config = function(_, _)
      local util = require("lspconfig/util")
      local config = require("plugins.configs.lsp")
      require("typescript-tools").setup({
        on_attach = config["on_attach"],
        -- capabilities = config["capabilities"],
        root_dir = util.root_pattern(".git")
      })
    end,
  },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {
      display_package = true,
      highlight = "GoImplements",
    }
  },
  {
    "mfussenegger/nvim-lint",
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      require("plugins.configs.linting")
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        go = { "gci" },
        markdown = { "deno_fmt", "injected" },
        sh = { "shfmt" },
        json = { "jq" },
        yaml = { "prettierd" },
        graphql = { "prettierd" },
      },
      formatters = {
        prettierd = {
          ft_parsers = {
            yaml = "yaml",
            graphql = "graphql",
          }
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
