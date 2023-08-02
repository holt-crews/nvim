return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      global_settings = {
        mark_branch = true,
      },
    },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<leader>r", mark.rm_file)
      vim.keymap.set("n", "<leader>R", mark.clear_all)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-n>", function()
        ui.nav_next()
      end)
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "xiyaowong/telescope-emoji.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    lazy = false,
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
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  },
}
