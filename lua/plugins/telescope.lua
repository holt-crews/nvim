return {
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
      local ui = require("harpoon.ui")

      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          a = { mark.add_file, "Mark File (harpoon)" },
          r = { mark.rm_file, "Remove File (harpoon)" },
          R = { mark.clear_all, "Remove All Files (harpoon)" },
        },
        ["<C-e>"] = { ui.toggle_quick_menu, "Toggle Quick Menu (harpoon)" },
        ["<C-i>"] = {
          function()
            ui.nav_next()
          end,
          "Navigate next mark (harpoon)",
        },
      })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cmd = "Telescope" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = "Telescope",
    module = "telescope",
    opts = {
      defaults = {
        color_devicons = false,
        layout_strategy = "flex",
        layout_config = {
          preview_cutoff = 1,
        },
      },
      extensions = {
        -- :Telescope harpoon marks
        harpoon = {},
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  },
}
