return {
    {
        "nvimtools/none-ls.nvim",
        version = false,
        event = "BufRead",
        dependencies = {
            "ThePrimeagen/refactoring.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.ktlint,
                    null_ls.builtins.formatting.rustywind,
                    null_ls.builtins.formatting.ocamlformat,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.goimports_reviser,
                    null_ls.builtins.formatting.golines,
                    null_ls.builtins.code_actions.refactoring,
                    null_ls.builtins.code_actions.impl,
                    null_ls.builtins.code_actions.gomodifytags,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, async = false })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
