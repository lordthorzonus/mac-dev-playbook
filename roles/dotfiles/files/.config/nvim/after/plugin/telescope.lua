local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    local input_string = vim.fn.input("Search For > ")
    if (input_string == '') then
        return
    end
    builtin.grep_string({
        search = input_string,
    })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
