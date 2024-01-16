
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function()
        require("mason").setup{
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
        }
        require("mason-lspconfig").setup{
            ensure_installed = {
                'tsserver',
                'cssls',
                'html',
                'lua_ls',
                'rust_analyzer',
            },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            }
        }
        require("lspconfig").emmet_ls.setup{
            capabilities = capabilities,
            filetypes = {"html", "css", "scss"},
            init_options = {
                html = {
                    options = {
                        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                        ["bem.enabled"] = true,
                    },
                },
            }
        }
    end,
}


--[[
        local cmp = require'cmp'
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })
--]]
