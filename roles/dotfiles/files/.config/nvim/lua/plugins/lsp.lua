-- Workaround for truncating long TypeScript inlay hints.
-- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
local max_inlay_hint_length = 30
vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client and client.name == "typescript-tools" then
        result = vim.iter(result)
            :map(function(hint)
                local label = hint.label ---@type string
                if label:len() >= max_inlay_hint_length then
                    label = label:sub(1, max_inlay_hint_length - 1) .. "..."
                end
                hint.label = label
                return hint
            end)
            :totable()
    end

    inlay_hint_handler(err, result, ctx, config)
end

return {
    {
        "neovim/nvim-lspconfig",
        version = false,
        dependencies = {
            {
                "williamboman/mason.nvim",
                version = false,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                version = false,
                dependecies = {
                    "hrsh7th/cmp-nvim-lsp",
                },
            },
            {
                "hrsh7th/nvim-cmp",
                version = false,
            },
            {
                "L3MON4D3/LuaSnip",
            },
            {
                "folke/neodev.nvim",
                version = false,
                opts = {},
            },
        },
        config = function()
            require("neodev").setup({})

            local lspconfig = require("lspconfig")
            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            lsp_capabilities =
                vim.tbl_deep_extend("force", lsp_capabilities, require("cmp_nvim_lsp").default_capabilities())

            local default_setup = function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- "tsserver",
                    "eslint",
                    "rust_analyzer",
                    "ansiblels",
                    "lua_ls",
                    "gopls",
                    "spectral",
                    "dockerls",
                    "docker_compose_language_service",
                    "kotlin_language_server",
                    "marksman",
                    "sqlls",
                    "tailwindcss",
                    "tflint",
                    "yamlls",
                    "jsonls",
                    "vimls",
                },
                handlers = {
                    default_setup,
                },
            })

            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    },
                },
            })

            -- lspconfig.tsserver.setup({
            -- 	capabilities = lsp_capabilities,
            -- 	settings = {
            -- 		typescript = {
            -- 			inlayHints = {
            -- 				includeInlayParameterNameHints = "all",
            -- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            -- 				includeInlayFunctionParameterTypeHints = false,
            -- 				includeInlayVariableTypeHints = true,
            -- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            -- 				includeInlayPropertyDeclarationTypeHints = true,
            -- 				includeInlayFunctionLikeReturnTypeHints = true,
            -- 				includeInlayEnumMemberValueHints = true,
            -- 			},
            -- 		},
            -- 		javascript = {
            -- 			inlayHints = {
            -- 				includeInlayParameterNameHints = "all",
            -- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            -- 				includeInlayFunctionParameterTypeHints = true,
            -- 				includeInlayVariableTypeHints = true,
            -- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            -- 				includeInlayPropertyDeclarationTypeHints = true,
            -- 				includeInlayFunctionLikeReturnTypeHints = true,
            -- 				includeInlayEnumMemberValueHints = true,
            -- 			},
            -- 		},
            -- 	},
            -- })

            lspconfig.gopls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        completeUnimported = true,
                        usePlaceholders = false,
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_kinds = {
                Text = "  ",
                Method = "  ",
                Function = "  ",
                Constructor = "  ",
                Field = "  ",
                Variable = "  ",
                Class = "  ",
                Interface = "  ",
                Module = "  ",
                Property = "  ",
                Unit = "  ",
                Value = "  ",
                Enum = "  ",
                Keyword = "  ",
                Snippet = "  ",
                Color = "  ",
                File = "  ",
                Reference = "  ",
                Folder = "  ",
                EnumMember = "  ",
                Constant = "  ",
                Struct = "  ",
                Event = "  ",
                Operator = "  ",
                TypeParameter = "  ",
            }

            local luasnip = require("luasnip")

            cmp.setup({
                window = {
                    border = "single",
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
                formatting = {
                    format = function(_, vim_item)
                        vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
                        return vim_item
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    -- Enter key confirms completion item
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-Tab>"] = nil,
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    -- Ctrl + space triggers completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })

            vim.diagnostic.config({
                signs = true,
                virtual_text = {
                    source = "if_many",
                },
                severity_sort = true,
                underline = true,
                update_in_insert = true,
                float = {
                    focuasable = false,
                    border = "single",
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf, remap = false }
                    local telescope = require("telescope.builtin")
                    vim.keymap.set("n", "gd", function()
                        telescope.lsp_definitions()
                    end, opts)
                    vim.keymap.set("n", "gD", function()
                        telescope.lsp_declarations()
                    end, opts)
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
                    end, opts)
                    vim.keymap.set("n", "<leader>vws", function()
                        telescope.lsp_workspace_symbols()
                    end, opts)
                    vim.keymap.set("n", "<leader>vd", function()
                        vim.diagnostic.open_float()
                    end, opts)
                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.goto_next()
                    end, opts)
                    vim.keymap.set({ "n", "v" }, "<C-Enter>", function()
                        vim.lsp.buf.code_action()
                    end, { buffer = event.buf, remap = true })
                    vim.keymap.set("n", "]d", function()
                        vim.diagnostic.goto_prev()
                    end, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", function()
                        vim.lsp.buf.code_action()
                    end, opts)
                    vim.keymap.set("n", "<leader>vrr", function()
                        telescope.lsp_references()
                    end, opts)
                    vim.keymap.set("n", "gr", function()
                        telescope.lsp_references()
                    end, opts)
                    vim.keymap.set("i", "<C-h>", function()
                        vim.lsp.buf.signature_help()
                    end, opts)
                    vim.keymap.set("n", "<C-h>", function()
                        vim.diagnostic.open_float()
                    end, { buffer = event.buf, remap = true })
                    vim.keymap.set("n", "<leader>vd", function()
                        vim.diagnostic.open_float()
                    end, opts)
                    vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>")
                    vim.keymap.set("n", "gi", function()
                        telescope.lsp_implementations()
                    end, opts)
                    vim.keymap.set("n", "<leader>ic", function()
                        telescope.lsp_incoming_calls()
                    end)

                    vim.keymap.set("n", "<leader>oc", function()
                        telescope.lsp_outgoing_calls()
                    end)

                    vim.keymap.set("n", "<leader>vrn", function()
                        vim.lsp.buf.rename()
                    end)
                end,
            })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        enable = false,
        opts = {
            breadcrumbs = {
                enable = false,
            },
            outline = {
                layout = "float",
                keys = {
                    jump = "e",
                    toggle_or_jump = "<cr>",
                    quit = "<esc>",
                },
                detail = false,
            },
            lightbulb = {
                enable = false,
                sign = false,
                enable_in_insert = false,
            },
            callhierarchy = {
                keys = {
                    quit = "<esc>",
                },
            },
            symbol_in_winbar = {
                enable = false,
            },
            rename = {
                enable = true,
                keymaps = {
                    quit = "<esc>",
                },
            },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function(_, opts)
            local lspsaga = require("lspsaga")
            lspsaga.setup(opts)

            vim.keymap.set("n", "<leader>vrn", function()
                vim.cmd("Lspsaga rename")
            end)
        end,
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup({
                commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
                autocmd = { enable = false }, -- Enable the inlay hints on `LspAttach` event
            })

            vim.keymap.set("n", "<leader>th", function()
                vim.cmd("InlayHintsToggle")
            end)
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
                on_attach =
                    function(client, bufnr)
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end,
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHints = true,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
    },
}
