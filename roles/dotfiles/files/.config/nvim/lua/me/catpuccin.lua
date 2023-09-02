local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
    return
end
vim.g.catppuccin_flavour = "mocha"
catppuccin.setup()
vim.cmd [[colorscheme catppuccin]]

