-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    filters = {
        dotfiles = false,
    },
})

vim.keymap.set("n", "<leader>s", ":NvimTreeFindFileToggle!<CR>", { silent = true })
