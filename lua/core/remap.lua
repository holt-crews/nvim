local wk = require("which-key")

wk.add({
  -- general
  { "-", function() require("oil").open() end, desc = "Open parent directory (oil)" },
  { "<leader>p", [["_dP]], mode = "x", desc = "Paste, no copy" },
  { "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd.Undotree()
  end, desc = "Toggle undotree" },
  { "[c", function() require("treesitter-context").go_to_context() end, desc = "Jump to context" },

  -- buffers
  { "<leader>b", group = "buffer" },
  { "<leader>bb", "<cmd>b#<CR>", desc = "Back buffer" },
  { "<leader>bd", "<cmd>%bdelete|edit #|normal `\" <CR>", desc = "Delete all buffers" },
  { "<leader>bx", "<cmd>bdelete<CR>", desc = "Delete buffer" },
  { "<C-n>", "<cmd>bnext<CR>", desc = "Next buffer" },
  { "<C-p>", "<cmd>bprevious<CR>", desc = "Previous buffer" },

  -- find (telescope)
  { "<leader>f", group = "find" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find all files" },
  { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files" },
  { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find word" },
  { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffer" },
  { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Find oldfiles" },
  { "<leader>fc", "<cmd>Telescope treesitter<CR>", desc = "Find code" },
  { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find todo" },
  { "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "Find jump" },
  { "<leader>fx", "<cmd>Telescope commands<CR>", desc = "Find command" },
  { "<leader>fr", "<cmd>Telescope registers<CR>", desc = "Find registers" },
  { "<leader>fs", "<cmd>Telescope spell_suggest<CR>", desc = "Find spelling" },
  { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
  { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in buffer" },
  { "<leader>fm", "<cmd>Format<CR>", desc = "Format buffer" },

  -- help / diagnostics
  { "<leader>h", group = "help" },
  { "<leader>ht", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
  { "<leader>hh", vim.diagnostic.open_float, desc = "Diagnostic float" },

  -- code
  { "<leader>/", "gcc", remap = true, desc = "Toggle comment line" },
  { "<leader>/", "gc", mode = "x", remap = true, desc = "Toggle comment" },

  -- trouble
  { "<leader>x", group = "trouble" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (workspace)" },
  { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (buffer)" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
  { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
  { "<leader>xr", "<cmd>Trouble lsp toggle focus=true<CR>", desc = "LSP references" },
  { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo" },

  -- git
  { "<leader>g", group = "git" },
  { "<leader>gf", "<cmd>below vert Git<CR>", desc = "Open vim-fugitive" },
  { "<leader>gt", group = "telescope" },
  { "<leader>gts", "<cmd>Telescope git_status<CR>", desc = "Git status" },
  { "<leader>gtt", "<cmd>Telescope git_stash<CR>", desc = "Git stash" },
  { "<leader>gtc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
  { "<leader>gtb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },

  -- debugger
  { "<leader>d", group = "debug" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: ")) end, desc = "Conditional breakpoint" },
  { "<leader>dui", function() require("dapui").toggle() end, desc = "Toggle UI" },
  { "<leader>duf", function() require("dapui").float_element() end, desc = "Float UI element" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  { "<leader>dq", function() require("dap").terminate() end, desc = "Quit" },
  { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
  { "<leader>dv", function() require("dap").step_over() end, desc = "Step over" },
  { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
  { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go test" },
  { "<leader>dgl", function() require("dap-go").debug_last() end, desc = "Debug last Go test" },

  -- tmux navigator
  { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
  { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
  { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
  { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
})

vim.keymap.set("n", "<CR>", function()
  return vim.bo.buftype == "" and "o<Esc>" or "<CR>"
end, { expr = true, desc = "Insert line below" })
