return {
    { "savq/melange-nvim" },   -- The golden theme
    { "cocopon/iceberg.vim" }, -- The blue theme
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim", -- optional - Diff integration
        },
        config = true
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     build = ":TSUpdate",
    --     branch = "main",
    -- },
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        config = function()
            require("tree-sitter-manager").setup({
                -- Default Options
                -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
                -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
                -- auto_install = false, -- if enabled, install missing parsers when editing a new file
                -- highlight = true, -- treesitter highlighting is enabled by default
                -- languages = {}, -- override or add new parser sources
                -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
                -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
            })
        end
    },
    {
        "mason-org/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig",
        },
    },
    { "neovim/nvim-lspconfig" },
    { "rsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                always_show_bufferline = false,
                mode = "tabs",
                separator_style = "thin",
                indicator = {
                    style = 'underline',
                },
            }
        }
    },
    {
        "nvim-lualine/lualine.nvim"
    },
    {
        "szw/vim-maximizer",
        keys = {
            { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/Minimize a split" },
        }
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" }
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },
    {
        "gbprod/substitute.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "theprimeagen/harpoon"
    },
    {
        "sindrets/diffview.nvim"
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-nvim-lsp"
        },
        version = '1.*'
    },
    {
        'litvinof/nvim-http',
        branch = 'fix/macos-symlink',
    },
}
