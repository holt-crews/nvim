return {
    n = {
        ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "[F]ind [F]iles" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "[F]ind [A]ll" },
        ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live Grep" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "[F]ind [O]ldfiles" },
        ["<leader>fg"] = { "<cmd> Telescope git_files <CR>", "[F]ind [G]it Files" },

        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "[G]it [C]ommits" },
        ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "[G]it [S]tatus" },
    }
}
