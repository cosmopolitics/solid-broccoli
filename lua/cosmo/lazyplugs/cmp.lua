return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            config = function()
                local types = require 'luasnip.util.types'

                require('luasnip.loaders.from_vscode')
                require('luasnip').setup {
                    history = true,
                    delete_check_events = 'TextChanged',
                    -- Display a cursor-like placeholder in unvisited nodes
                    -- of the snippet.
                }
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
        local select_opts = {behavior = cmp.SelectBehavior.Select}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp', keyword_length = 1},
                {name = 'buffer', keyword_length = 3},
                {name = 'luasnip', keyword_length = 2},
            },
            window = {
                documentation = cmp.config.window.bordered()
            },
            formatting = {
                fields = {'menu', 'abbr', 'kind'},
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '/-',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
            }),
        }
    end
}
