require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
            Text = '󰉿',
            Method = '󰊕',
            Function = '󰊕',
            Constructor = '󰒓',

            Field = '󰜢',
            Variable = '󰆦',
            Property = '󰖷',

            Class = '󱡠',
            Interface = '󱡠',
            Struct = '󱡠',
            Module = '󰅩',

            Unit = '󰪚',
            Value = '󰦨',
            Enum = '󰦨',
            EnumMember = '󰦨',

            Keyword = '󰻾',
            Constant = '󰏿',

            Snippet = '󱄽',
            Color = '󰏘',
            File = '󰈔',
            Reference = '󰬲',
            Folder = '󰉋',
            Event = '󱐋',
            Operator = '󰪚',
            TypeParameter = '󰬛',
        },
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
            window = {
                border = "rounded",
                winhighlight =
                "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
            },
        },
        menu = {
            border = "rounded",
            draw = { gap = 2 },
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})
