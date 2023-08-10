local wk = require("which-key")

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

wk.register({
  ["<leader>pv"] = { vim.cmd.Ex, "Open Netrw" },
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
require("telescope").load_extension("fzf")
require("telescope").load_extension("emoji")
local builtin = require("telescope.builtin")

wk.register({
  ["<leader>f"] = {
    name = "+file",
    f = { builtin.find_files, "[f]ind [f]ile" },
    a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[f]ind [a]ll files" },
    g = { builtin.git_files, "[f]ind [g]it Files" },
    w = { builtin.live_grep, "[f]ind [w]ord" },
    b = { builtin.buffers, "[f]ind [b]uffer" },
    o = { builtin.oldfiles, "[f]ind [o]ldfiles" },
    c = { builtin.treesitter, "[f]ind [c]ode" },
  },
  ["<leader>g"] = {
    name = "+file",
    s = { builtin.git_status, "[g]it [s]tatus" },
    c = { builtin.git_commits, "[g]it [c]ommits" },
  },
  ["<leader>h"] = {
    name = "+file",
    t = { builtin.help_tags, "[h]elp [t]ags" },
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
    "[F]or[m]at",
  },
})

-- folke/trouble.nvim mappings
local trouble = require("trouble")

wk.register({
  ["<leader>x"] = {
    name = "+file",
    x = {
      function()
        trouble.toggle()
      end,
      "Open Trouble",
    },
    w = {
      function()
        trouble.toggle("workspace_diagnostics")
      end,
      "[x]Trouble [w]orkspace diagnostics",
    },
    d = {
      function()
        trouble.toggle("document_diagnostics")
      end,
      "[x]Trouble [d]ocument diagnostics",
    },
    l = {
      function()
        trouble.toggle("loclist")
      end,
      "[x]Trouble [l]oclist",
    },
    q = {
      function()
        trouble.toggle("quickfix")
      end,
      "[x]Trouble [q]uickfix",
    },
  },
  ["g"] = {
    name = "+file",
    R = {
      function()
        trouble.toggle("lsp_references")
      end,
      "Trouble References",
    },
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
