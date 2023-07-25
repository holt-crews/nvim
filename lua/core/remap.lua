vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("x", "<leader>p", [["_dP]])

local wk = require("which-key")

wk.register({
  ["<leader>hh"] = { ":lua vim.diagnostic.open_float()<CR>", "Diagnostic [hh]elp" },
})

-- Telescope mapppings
require("telescope").load_extension("fzf")
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

wk.register({
  ["<leader>bd"] = { '<cmd> %bdelete|edit #|normal `" <CR>', "[b]uffer [d]elete all" },
})
-- vim.keymap.set("n", "<leader>bd", '<cmd> %bdelete|edit #|normal `" <CR>')
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

-- vim.keymap.set("n", "<leader>fm", function()
--   vim.lsp.buf.format({ async = true })
-- end)

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
