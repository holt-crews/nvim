local wk = require("which-key")

local oil = require("oil")

wk.register({
  ["<leader>pv"] = { oil.open, "Open Netrw" },
  ["-"] = { oil.open_float, "Open Float Netrw" },
  ["<leader>hh"] = { ":lua vim.diagnostic.open_float()<CR>", "Diagnostic [hh]elp" },
})

wk.register({
  ["<leader>p"] = { [["_dP]], "Paste, no copy" },
}, { mode = "x" })

-- buffer navigate
wk.register({
  ["<C-n>"] = { "<cmd>bn<CR>", "Next Buffer" },
  ["<C-p>"] = { "<cmd>bp<CR>", "Previous Buffer" },
  ["<leader>dd"] = { "<cmd>bd<CR>", "Delete Buffer" },
  ["<leader>bd"] = { '<cmd> %bdelete|edit #|normal `" <CR>', "[b]uffer [d]elete all" },
})

-- Telescope mapppings
wk.register({
  ["<leader>f"] = {
    name = "+file",
    f = { "<cmd>Telescope find_files<CR>", "[f]ind [f]ile" },
    a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[f]ind [a]ll files" },
    g = { "<cmd>Telescope git_files<CR>", "[f]ind [g]it Files" },
    w = { "<cmd>Telescope live_grep<CR>", "[f]ind [w]ord" },
    b = { "<cmd>Telescope buffers<CR>", "[f]ind [b]uffer" },
    o = { "<cmd>Telescope oldfiles<CR>", "[f]ind [o]ldfiles" },
    c = { "<cmd>Telescope treesitter<CR>", "[f]ind [c]ode" },
  },
  ["<leader>g"] = {
    name = "+file",
    s = { "<cmd>Telescope git_status<CR>", "[g]it [s]tatus" },
    c = { "<cmd> Telescope git_commits<CR>", "[g]it [c]ommits" },
  },
  ["<leader>h"] = {
    name = "+file",
    t = { "<cmd>Telescope help_tags<CR>", "[h]elp [t]ags" },
  },
})

-- TODO: figure out vim fugitive (Git)
-- vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- vim tmux navigator
wk.register({
  ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>" },
  ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>" },
  ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>" },
  ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>" },
})

vim.keymap.set("n", "<Cr>", "o<Esc>")
-- vim.keymap.set('n', '<S-Cr>', 'O<Esc>')

-- formatting
wk.register({
  ["<leader>fm"] = {
    function()
      vim.lsp.buf.format({ async = true })
    end,
    "[f]or[m]at",
  },
})

-- folke/trouble.nvim mappings
wk.register({
  ["<leader>x"] = {
    name = "+file",
    x = { "<cmd>TroubleToggle<CR>", "Open Trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "[x]Trouble [w]orkspace diagnostics" },
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "[x]Trouble [d]ocument diagnostics" },
    l = { "<cmd>TroubleToggle loclist<CR>", "[x]Trouble [l]oclist" },
    q = { "<cmd>TroubleToggle quickfix<CR>", "[x]Trouble [q]uickfix" },
    r = { "<cmd>TroubleRefresh<CR>", "[x]Trouble [r]efresh" },
  },
  ["g"] = {
    name = "+file",
    R = { "<cmd>TroubleToggle lsp_references<CR>", "Trouble References" },
  },
})

wk.register({
  ["[c"] = {
    function()
      require("treesitter-context").go_to_context()
    end,
    "jump to [c]ontext",
  },
})

wk.register({
  ["<leader>rcu"] = {
    function()
      require("crates").upgrade_all_crates()
    end,
    "[r]ust [c]rates [u]update",
  },
})

-- debugger
wk.register({
  ["<leader>d"] = {
    b = {
      "<cmd> DapToggleBreakpoint <CR>",
      "[d]ebugger [b]reakpoint",
    },
    us = {
      function()
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "[d]ebugger sidebar",
    },
  },
})

-- fugitive
wk.register({
  ["<leader>g"] = {
    g = { "<cmd>below vert Git<CR>", "Open vim-fugitive" },
  },
})

-- swenv
wk.register({
  ["<leader>pe"] = {
    function()
      require('swenv.api').pick_venv()
    end,
    "Pick [p]ython [e]nvironment"
  }
})
