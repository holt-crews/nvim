return {
  "AndrewRadev/splitjoin.vim",
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {}
  },
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
    "github/copilot.vim",
    cmd = { "Copilot" },
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>cp"] = {
          name = "copilot",
          s = { "<cmd> Copilot setup <CR>", "[C]o[p]ilot [s]etup" },
          e = { "<cmd> Copilot enable <CR>", "[C]o[p]ilot [e]nable" },
          d = { "<cmd> Copilot disable <CR>", "[C]o[p]ilot [d]isable" },
        }
      })
      vim.keymap.set("i", "<C-R>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat" },
    branch = "main",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    build = "Make tiktoken",
    opts = {
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        show_info = {
          normal = 'gp',
        },
        show_context = {
          normal = 'gs',
        },
      },
    }
  }
}
