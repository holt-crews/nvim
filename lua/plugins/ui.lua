local function trunc_git_branch()
  return function(str)
    local trunc_len = vim.fn.winwidth(0) / 10

    if #str > trunc_len then
      return str:sub(1, trunc_len)
    end
    return str
  end
end

local function trunc_buf_name()
  return function(str)
    local trunc_len = vim.fn.winwidth(0) / 8

    if #str > trunc_len + 2 then
      return str:sub(1, trunc_len / 2) .. ".." .. str:sub(string.len(str) - (trunc_len / 2) - 2, string.len(str))
    end
    return str
  end
end

return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
    init = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_better_performance = true
      vim.g.gruvbox_material_cursor = "green"
      vim.g.gruvbox_material_background = "medium"
    end,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "stevearc/oil.nvim",
    config = function()
      require("nvim-web-devicons").set_default_icon("", "#d4be98", 65)
      require("nvim-web-devicons").setup({
        color_icons = false,
        override = {
          graphqls = {
            icon = "󰡷",
            name = "Graphql"
          },
          mod = {
            icon = "",
            name = "go.mod"
          },
          sum = {
            icon = "",
            name = "go.sum"
          },
          yaml = {
            icon = "",
            name = "Yaml"
          },
          yml = {
            icon = "",
            name = "Yaml"
          },
        }
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
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", fmt = trunc_git_branch() },
          "diff",
          {
            "diagnostics",
            on_click = function()
              vim.cmd("TroubleToggle document_diagnostics")
            end,
          },
        },
        lualine_c = { { "buffers", icons_enabled = false, fmt = trunc_buf_name() } },
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
}
