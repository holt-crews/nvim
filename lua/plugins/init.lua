return {
  "tpope/vim-sleuth",
  { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPost" },
  -- { "tpope/vim-fugitive",                      cmd = { "G", "Git" } },
  { "tpope/vim-surround", event = "BufReadPost" },
  { "folke/which-key.nvim", keys = { "<leader>", '"', "`", "c", "v", "g" }, opts = {} },
  {
    "folke/trouble.nvim",
    opts = { icons = false },
    cmd = { "Trouble", "TroubleToggle" },
  },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox-material",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            on_click = function()
              vim.cmd("TroubleToggle document_diagnostics")
            end,
          },
        },
        lualine_c = { { "buffers", icons_enabled = false } },
        lualine_x = { "fileformat" },
        lualine_y = { { "filetype", icons_enabled = false } },
        lualine_z = { "location" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
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
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = { enabled = true },
    },
  },
  {
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
