return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "folke/zen-mode.nvim",
        },
        enabled = true,
        config = function()
            local zen_mode = require("zen-mode")
            local zen_mode_view = require("zen-mode.view")
            --
            -- disable netrw at the very start of your init.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            local HEIGHT_RATIO = 0.8
            local WIDTH_RATIO = 0.5

            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set("n", "<ESC>", function()
                    api.tree.close()
                end, opts("Close"))
            end

            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                on_attach = my_on_attach,
                view = {
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                            vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function()
                        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                    end,
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

            vim.keymap.set("n", "<leader>s", function()
                if zen_mode_view.is_open() then
                    zen_mode.close()
                end

                vim.cmd(":NvimTreeFindFileToggle!<CR>")
            end, { silent = true })
        end,
    },
}
