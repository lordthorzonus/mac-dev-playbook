require('copilot').setup({
    suggestion = {
        enabled = true,
        debounce = 75,
        auto_trigger = true,
        keymap = {
            accept = "§",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-]>",
        },
    },

    filetypes = {
        ["*"] = true,
    },
});
