local wk = require("which-key")

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
