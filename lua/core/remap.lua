local wk = require("which-key")

local oil = require("oil")

wk.register({
  ["-"] = { oil.open, "Open Float Netrw" },
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
  ["<leader>bb"] = { '<cmd>b#<CR>', "[b]ack [b]uffer" },
})

-- Telescope mapppings
wk.register({
  ["<leader>f"] = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files<CR>", "[f]ind [f]ile" },
    a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[f]ind [a]ll files" },
    g = { "<cmd>Telescope git_files<CR>", "[f]ind [g]it Files" },
    w = { "<cmd>Telescope live_grep<CR>", "[f]ind [w]ord" },
    b = { "<cmd>Telescope buffers<CR>", "[f]ind [b]uffer" },
    o = { "<cmd>Telescope oldfiles<CR>", "[f]ind [o]ldfiles" },
    c = { "<cmd>Telescope treesitter<CR>", "[f]ind [c]ode" },
    t = { "<cmd>TodoTelescope<CR>", "[f]ind [t]odo" },
    j = { "<cmd>Telescope jumplist<CR>", "[f]ind [j]ump" },
    x = { "<cmd>Telescope commands<CR>", "[f]ind [x]command" },
    r = { "<cmd>Telescope registers<CR>", "[f]ind [r]egisters" },
    s = { "<cmd>Telescope spell_suggest<CR>", "[f]ind [s]pelling" },
    k = { "<cmd>Telescope keymaps<CR>", "[f]ind normal mode [k]eymaps" },
    z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "[f]ind current buffer fu[z]zy" },
    h = { "<cmd>Telescope harpoon marks<CR>", "[f]ind [h]arpoon marks" }
  },
  ["<leader>h"] = {
    name = "Help Telescope",
    t = { "<cmd>Telescope help_tags<CR>", "[h]elp [t]ags" },
  },
})

-- vim tmux navigator
wk.register({
  ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>" },
  ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>" },
  ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>" },
  ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>" },
})

vim.keymap.set("n", "<Cr>", "o<Esc>")

-- formatting
wk.register({
  ["<leader>fm"] = { "<cmd>Format<CR>", "[f]or[m]at" },
})

-- folke/trouble.nvim mappings
wk.register({
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>Trouble diagnostics toggle<CR>", "Open Trouble" },
    w = { "<cmd>Trouble workspace_diagnostics toggle<CR>", "[x]Trouble [w]orkspace diagnostics" },
    d = { "<cmd>Trouble document_diagnostics toggle<CR>", "[x]Trouble [d]ocument diagnostics" },
    l = { "<cmd>Trouble loclist toggle<CR>", "[x]Trouble [l]oclist" },
    q = { "<cmd>Trouble quickfix toggle<CR>", "[x]Trouble [q]uickfix" },
    r = { "<cmd>TroubleRefresh<CR>", "[x]Trouble [r]efresh" },
    t = { "<cmd>TodoQuickFix<CR>", "[x]Trouble [t]odo" },
  },
  ["g"] = {
    r = { "<cmd>Trouble lsp toggle focus=true<CR>", "Trouble References" },
  },
})

wk.register({
  ["[c"] = { function() require("treesitter-context").go_to_context() end, "jump to [c]ontext" },
})

-- debugger
wk.register({
  ["<leader>d"] = {
    name = "Debugger",
    b = { "<cmd> DapToggleBreakpoint <CR>", "[d]ebugger [b]reakpoint" },
    B = { function() require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end, "[d]ebugger conditional [B]reakpoint", },
    ui = { function() require("dapui").toggle() end, "[d]ebugger toggle [u]i" },
    ---@diagnostic disable-next-line: missing-parameter
    uf = { function() require("dapui").float_element() end, "[d]ebugger [f]loat [u]i" },
    c = { function() require("dap").continue() end, "[d]ebugger [c]ontinue" },
    q = { function() require("dap").terminate() end, "[d]ebugger [q]uit" },
    i = { function() require("dap").step_into() end, "[d]ebugger step [i]nto" },
    v = { function() require("dap").step_over() end, "[d]ebugger step o[v]er" },
    o = { function() require("dap").step_out() end, "[d]ebugger step [o]ut" },
  },
})

-- git fugitive
wk.register({
  ["<leader>g"] = {
    name = "+Git",
    t = {
      name = "+Telescope",
      s = { "<cmd>Telescope git_status<CR>", "[g]it [s]tatus" },
      t = { "<cmd>Telescope git_stash<CR>", "[g]it s[t]ash" },
      c = { "<cmd> Telescope git_commits<CR>", "[g]it [c]ommits" },
      b = { "<cmd> Telescope git_branches<CR>", "[g]it [b]ranches" },
    },
    f = { "<cmd>below vert Git<CR>", "Open vim-fugitive" },
  },
})

-- undotree
wk.register({
  ["<C-U>"] = { "<cmd>UndotreeToggle<CR>", "[u]ndotree" },
})
