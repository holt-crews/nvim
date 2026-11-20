return {
  { "AndrewRadev/splitjoin.vim", event = "BufReadPost" }, -- gS and gJ are the keymaps
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  "tpope/vim-fugitive",
  { "tpope/vim-surround",   event = "BufReadPost" },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = { "Trouble" },
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix", "TodoLocList" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
