vim.keymap.set("i", "§", "copilot#Accept('<CR>')",
    { noremap = true, silent = true, expr = true, replace_keycodes = false })
