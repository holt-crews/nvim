-- vim.opt.nocompatible = true -- disable compatibility to old-time vi
vim.opt.showmatch = true                               --  show matching brackets.
vim.opt.ignorecase = true                              -- needed for smartcase to take effect
vim.opt.smartcase = true                               -- case insensitive matching
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- where undos are stored
vim.opt.undofile = true                                -- not sure what this does
vim.opt.hidden = false                                 -- does something with buffer files, seems confusing so keeping default

vim.opt.smartindent = true
vim.opt.tabstop = 4      -- using strategy 2, check man page for more details about tab combos
vim.opt.softtabstop = 4  -- see tabstop man page
vim.opt.shiftwidth = 4   -- see tabstop man page
vim.opt.expandtab = true -- see tabstop man page

vim.opt.number = true    -- in combo with relative gives a floating absolute number
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes" -- column on the left side where things like git changes are shown
vim.opt.wrap = false

vim.opt.hlsearch = false -- highlight previous search results, might not want actually

vim.opt.scrolloff = 8

vim.opt.updatetime = 250 -- CursorHold delay (LSP highlights, swap writes)

vim.opt.colorcolumn = "88"

vim.opt.whichwrap:append("<>[]")
