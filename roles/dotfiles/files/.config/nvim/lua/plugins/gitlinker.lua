return {
    {
        "ruifm/gitlinker.nvim",
        version = false,
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>gy",
            })
        end,
    },
}
