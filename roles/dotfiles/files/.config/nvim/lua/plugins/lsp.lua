return {
    {
        'neovim/nvim-lspconfig',
        version = false,
        dependecies = {
            {
                'williamboman/mason.nvim',
                version = false,
            },
            {
                'williamboman/mason-lspconfig.nvim',
                version = false,
                dependecies = {
                    'hrsh7th/cmp-nvim-lsp'
                },
            },
            {
                'hrsh7th/nvim-cmp',
                version = false,
            },
            {
               'L3MON4D3/LuaSnip'
            }
        },
        config = function()
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local default_setup = function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'tsserver',
                    'eslint',
                    'rust_analyzer',
                    'ansiblels',
                    'lua_ls',
                    'spectral',
                    'dockerls',
                    'docker_compose_language_service',
                    'kotlin_language_server',
                    'marksman',
                    'sqlls',
                    'tailwindcss',
                    'tflint',
                    'yamlls',
                    'jsonls',
                    'vimls',
                },
                handlers = {
                    default_setup,
                },
            })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Enter key confirms completion item
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<S-Tab>'] = nil,
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    -- Ctrl + space triggers completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })

           require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end
    },
}
