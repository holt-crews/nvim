return {
  'sainnhe/gruvbox-material',
  priority = 1000,
  lazy = false,
  init = function()
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_better_performance = true
    vim.g.gruvbox_material_cursor = 'green'
    vim.g.gruvbox_material_background = 'medium'
  end,
  config = function()
    vim.cmd([[colorscheme gruvbox-material]])
  end

}
