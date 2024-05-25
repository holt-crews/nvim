return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", event = "VeryLazy" }
    },
    event = "VimEnter",
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
