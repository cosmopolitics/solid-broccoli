return {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function ()
        require("luasnip.loaders.from_vscode")
    end
}
