local cmp_kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
}

return {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    local types = require 'luasnip.util.types'

                    require('luasnip.loaders.from_vscode').lazy_load()

                    require('luasnip').setup {}
                end,
            },

            {
                'Saecki/crates.nvim',
                event = 'BufRead Cargo.toml',
                config = true,
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        event = 'InsertEnter',
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            -- Inside a snippet, use backspace to remove the placeholder.
            vim.keymap.set('s', '<BS>', '<C-O>s', { silent = true })

            cmp.setup {
                -- Add icons to the completion menu.
                formatting = {
                    format = function(_, vim_item)
                        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    -- Make the completion menu bordered.
                    completion = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp", group_index = 1, priority = 10 },
                    { name = "codeium", max_item_count = 5, group_index = 1 },
                    { name = "copilot", group_index = 1 },
                    { name = "async_path", max_item_count = 5, group_index = 1 },
                    { name = "luasnip", max_item_count = 5, group_index = 1 },
                    { name = "buffer", keyword_length = 3, group_index = 2 },
                    { name = "fish", group_index = 2 },
                    {
                        name = "fonts",
                        option = { space_filter = "-" },
                        group_index = 2,
                        trigger_characters = { "-" },
                    },
                },
            }
        end,

}
