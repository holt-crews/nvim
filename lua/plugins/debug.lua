return {
  { "mfussenegger/nvim-dap", event = "VeryLazy" },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies =
    { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = {
        -- {
        --   elements = { {
        --     id = "breakpoints",
        --     size = 0.33
        --   }, {
        --     id = "stacks",
        --     size = 0.33
        --   }, {
        --     id = "watches",
        --     size = 0.33
        --   }
        --   },
        --   position = "left",
        --   size = 20
        -- },
        {
          elements = { {
            id = "scopes",
            size = 1
          } },
          position = "right",
          size = 60
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      }
    },
    config = function(_, opts)
      require("dapui").setup(opts)
      require("plugins.configs.dapui")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    opts = {},
    config = function(_, opts)
      require("dap-go").setup(opts)
      local wk = require("which-key")

      wk.register({
        ["<leader>d"] = {
          gt = {
            function()
              require('dap-go').debug_test()
            end,
            "[d]ebug [g]o [t]est"
          },
          gl = {
            function()
              require('dap-go').debug_last()
            end,
            "[d]ebug [g]o [l]ast test"
          }
        },
      })
    end
  },
}
