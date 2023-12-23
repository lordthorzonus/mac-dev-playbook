return {
    {
        'nvim-telescope/telescope.nvim',
        branch = "0.1.x",
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-ui-select.nvim',
                dependencies = {
                    "MunifTanjim/nui.nvim",
                    "rcarriga/nvim-notify",
                }
            }
        },
        config = function()
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

            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    }
                }
            }

            require('telescope').load_extension('ui-select')
        end
    }
}
