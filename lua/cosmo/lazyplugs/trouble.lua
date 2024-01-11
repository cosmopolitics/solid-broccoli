return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
            vim.keymap.set("n", "<leader>d", function()
                require("trouble").next({skip_groups = true, jump = true})
            end)
            vim.keymap.set("n", "<leader>dp", function()
                require("trouble").previous({skip_groups = true, jump = true})
            end)
            
        end
    },
}  
