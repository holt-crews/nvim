return {
  "tpope/vim-sleuth",
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
      },
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        FUTURE = { icon = " ", color = "warning" },
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
}
