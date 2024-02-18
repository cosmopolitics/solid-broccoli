
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
                'emmet_ls',
                'cssls',
                'html',
                'lua_ls',
                'rust_analyzer',
                'gopls',
                'zk',
                'ocamllsp',
                'pylyzer',
                'svelte',
                'taplo',
            },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup({})
                end,
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
