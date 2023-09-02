local jester = require("jester")
jester.setup({
    path_to_jest_run = 'node_modules/.bin/jest',
})

vim.keymap.set("n", "<C-S-r>", jester.run)
vim.keymap.set("n", "<leader>r", jester.run_last)