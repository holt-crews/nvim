return {
    'tpope/vim-sleuth',
    { 'folke/which-key.nvim',  keys = { "<leader>", '"', "`", "c", "v", "g" }, opts = {} },
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            -- TODO: probably change these
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

            vim.keymap.set("n", "<A-Tab>", function() ui.nav_next() end)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        module = 'telescope',
        opts = {
            defaults = {
                layout_config = {
                    preview_cutoff = 1
                }
            },
            extensions = {
                -- :Telescope harpoon marks
                harpoon = {}
            },
        },
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                theme = 'gruvbox-material',
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'buffers' },
                lualine_x = { 'fileformat' },
                lualine_y = { 'filetype' },
                lualine_z = { 'location' }
            }
        },
    },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "󰍵" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "│" },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },
    {
        -- comment commands
        'numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = '<leader>/',
                block = '<leader>bc',
            },
            opleader = {
                line = '<leader>/',
                block = '<leader>bc',
            }
        }
    },
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" }
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end
            }
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
            'onsails/lspkind.nvim',
            {
                'rust-lang/rust.vim',
                ft = 'rust',
                init = function()
                    vim.g.rustfmt_autosave = 1
                end
            }
        },
    },
    'NvChad/nvim-colorizer.lua',
    {
        "m4xshen/hardtime.nvim",
        opts = {}
    },
    { import = 'plugins.plugs' }
}
