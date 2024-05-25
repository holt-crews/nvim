return {
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",
  { "tpope/vim-surround",   event = "BufReadPost" },
  { "folke/which-key.nvim", keys = { "<leader>", '"', "`", "c", "v", "g" }, opts = {} },
  {
    "folke/trouble.nvim",
    opts = { icons = false },
    cmd = { "Trouble", "TroubleToggle" },
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
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      colors = {
        -- can reference these in the linting.lua file
        error = { "LspDiagnosticsSignError", "ErrorMsg", "#DC2626" },
        warning = { "LspDiagnosticsSignWarn", "WarningMsg", "#FBBF24" },
        info = { "LspDiagnosticsSignInformation", "#2563EB" },
        hint = { "LspDiagnosticsSignHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)]],
      }
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      global_settings = {
        mark_branch = true,
      },
    },
    config = function()
      local mark = require("harpoon.mark")
      local hui = require("harpoon.ui")

      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          a = { mark.add_file, "Mark File (harpoon)" },
          r = { mark.rm_file, "Remove File (harpoon)" },
          R = { mark.clear_all, "Remove All Files (harpoon)" },
        },
        ["<C-e>"] = { hui.toggle_quick_menu, "Toggle Quick Menu (harpoon)" },
        ["<C-b>"] = {
          function()
            hui.nav_next()
          end,
          "Navigate next mark (harpoon)",
        },
        ["<C-y>"] = {
          function()
            hui.nav_prev()
          end,
          "Navigate previous mark (harpoon)",
        },
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    ft = {
      "go",
      "python",
      "typescript",
      "javascript"
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()

      local wk = require("which-key")
      wk.register({ ["<leader>r"] = { name = "refactoring.nvim" } })
      wk.register({
        ["<leader>r"] = {
          e = { "<cmd> Refactor extract <CR>", "[r]efactor [e]xtract" },
          f = { "<cmd> Refactor extract_to_file <CR>", "[r]efactor extract to [f]ile" },
          v = { "<cmd> Refactor extract_var <CR>", "[r]efactor extract [v]ariable" },
          i = { "<cmd> Refactor inline_var<CR>", "[r]efactor [i]nline variable" },
          I = { "<cmd> Refactor infline_func<CR>", "[r]efactor [I]nline func" },
          b = { "<cmd> Refactor extract_block<CR>", "[r]efactor [b]lock" },
          bf = { "<cmd> Refactor extract_block_to_file<CR>", "[r]efactor [b]lock to [f]ile" },
        },
      }, { mode = "x" })

      wk.register({
        ["<leader>r"] = {
          i = { "<cmd> Refactor inline_var <CR>", "[r]efactor [i]nline variable" },
        },
      }, { mode = { "x", "n" } })

      wk.register({
        ["<leader>r"] = {
          I = { "<cmd> Refactor infline_func <CR>", "[r]efactor [I]nline func" },
          b = { "<cmd> Refactor extract_block <CR>", "[r]efactor [b]lock" },
          bf = { "<cmd> Refactor extract_block_to_file <CR>", "[r]efactor [b]lock to [f]ile" },
        },
      }, { mode = { "n" } })
    end,
  },
}
