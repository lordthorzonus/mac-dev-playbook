require('me.remap')
require('me.lazy')
require('me.set')

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argv(0) == "" or vim.fn.argv(0) == "." then
            require("telescope.builtin").git_files()
        end
    end,
})

local function augroup(name)
    return vim.api.nvim_create_augroup("save_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost", "CursorHold" }, {
    callback = function()
        local curbuf = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_buf_get_option(curbuf, "modified") or vim.fn.getbufvar(curbuf, "&modifiable") == 0 then
            return
        end

        vim.cmd([[silent! update]])
    end,
    pattern = "*",
    group = augroup("autosave"),
})
