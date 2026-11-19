return {
  { "RRethy/vim-illuminate",     event = "BufReadPost" },
  { "romainl/vim-cool",          event = "BufReadPost" },
  { "AndrewRadev/splitjoin.vim", event = "BufReadPost" }, -- gS and gJ are the keymaps
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "tpope/vim-sleuth",     ft = { "lua" } }, -- can't get this to be disabled for bogie
  "tpope/vim-fugitive",
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  { "tpope/vim-surround",   event = "BufReadPost" },
  { "folke/which-key.nvim", version = "2",        keys = { "<leader>", '"', "`", "c", "v", "g" }, opts = {} },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = { "Trouble" },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}