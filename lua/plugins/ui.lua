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
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_better_performance = true
      vim.g.gruvbox_material_cursor = "green"
      vim.g.gruvbox_material_background = "medium"
    end,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").set_default_icon("", "#d4be98", 65)
      require("nvim-web-devicons").setup({
        color_icons = false,
        override = {
          graphqls = {
            icon = "󰡷",
            name = "Graphql"
          },
          mod = {
            icon = "",
            name = "go.mod"
          },
          sum = {
            icon = "",
            name = "go.sum"
          },
          yaml = {
            icon = "",
            name = "Yaml"
          },
          yml = {
            icon = "",
            name = "Yaml"
          },
          make = {
            icon = "",
            name = "Makefile"
          },
        }
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = {
        { "icon", add_padding = false },
      },
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = false,
    opts = {
      highlight = true,
      lsp = { auto_attach = true },
    },
    config = function(_, opts)
      require("nvim-navic").setup(opts)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.is_available() ? v:lua.require'nvim-navic'.get_location() : ''%}"
    end,
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
          {
            "branch",
            fmt = trunc_git_branch(),
            on_click = function() vim.cmd("Telescope git_branches") end,
          },
          {
            "diff",
            on_click = function() vim.cmd("Gitsigns toggle_linehl") end,
          },
          {
            "diagnostics",
            on_click = function() vim.cmd("Trouble diagnostics toggle filter.buf=0") end,
          },
        },
        lualine_c = { { "buffers", icons_enabled = false, max_length = 10000, fmt = trunc_buf_name() } },
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
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      numhl = true,
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
}
