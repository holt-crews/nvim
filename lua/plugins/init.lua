return {
  "tpope/vim-sleuth",
  {"nvim-treesitter/nvim-treesitter-context", event = "BufReadPost"},
  { "tpope/vim-fugitive", cmd = { "G", "Git" } },
  { "tpope/vim-surround", event = "BufReadPost" },
  { "folke/which-key.nvim", keys = { "<leader>", '"', "`", "c", "v", "g" }, opts = {} },
  { "folke/trouble.nvim", opts = { icons = false }, cmd = {"Trouble", "TroubleToggle"} },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "stevearc/oil.nvim",
    config = function()
      require("nvim-web-devicons").set_default_icon("", "#d4be98", 65)
      require("nvim-web-devicons").setup({
        color_icons = false,
      })
      require("oil").setup({
        columns = {
          { "icon", add_padding = false },
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = "gruvbox-material",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "buffers", icons_enabled = false } },
        lualine_x = { "fileformat" },
        lualine_y = { { "filetype", icons_enabled = false } },
        lualine_z = { "location" },
      },
    },
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          "n",
          "<leader>gp",
          require("gitsigns").prev_hunk,
          { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gn",
          require("gitsigns").next_hunk,
          { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>ph",
          require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "[P]review [H]unk" }
        )
      end,
    },
  },
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },
  {
    -- comment commands
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = {
      toggler = {
        line = "<leader>/",
        block = "<leader>bc",
      },
      opleader = {
        line = "<leader>/",
        block = "<leader>bc",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
  },
}
