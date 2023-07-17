vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope mapppings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})

vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})

vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})

-- Undotree
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>bd", '<cmd> %bdelete|edit #|normal `" <CR>')
-- TODO: figure out vim fugitive (Git)
-- vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set("n", "<Cr>", "o<Esc>")
-- vim.keymap.set('n', '<S-Cr>', 'O<Esc>')

-- formatting
vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end)
