return {
    {
        "mbbill/undotree",
        version = false,
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    }
}
