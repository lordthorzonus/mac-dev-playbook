return {
    {
         'hrsh7th/nvim-cmp',
          version = false,
            dependencies = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'David-Kunz/cmp-npm',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',
                'windwp/nvim-autopairs',
            },

        config = function()
            local cmp = require("cmp")
            local cmpNpm = require('cmp-npm')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmpNpm.setup()

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                        { name = 'buffer' },
                    })
            })

            cmp.setup.filetype('json', {
                sources = {
                    { name = 'npm', priority = 100 },
                    { name = 'json' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                }
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    })
            })
        end
    }
}
