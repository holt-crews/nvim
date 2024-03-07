return {
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      require("plugins.configs.lsp")
    end,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim",       opts = {} }, -- tag = "legacy",

      -- Additional lua configuration, makes nvim stuff amazing!
      { "folke/neodev.nvim",       opts = {} },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.cmp")
    end,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",

      -- Adds completion for buffers
      "hrsh7th/cmp-buffer",
      -- Adds completion for commands
      "hrsh7th/cmp-cmdline",

      "hrsh7th/cmp-path",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
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
    opts = {},
    ft = "typescript",
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    -- dependencies
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "mfussenegger/nvim-dap",
    ft = "rust", -- just debugging with rust for now
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
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
        -- lua = { 'stylua' },
        go = { "goimports-reviser", "gofumpt", "golines" },
        markdown = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" }
      },
    },
  }
}
