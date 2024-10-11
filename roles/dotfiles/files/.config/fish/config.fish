#!/usr/bin/env fish

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block 

starship init fish | source

# Make it easy to switch to commonly-used directories
zoxide init fish | source

set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by `rbenv init` on Mon Sep  9 15:54:52 EEST 2024
status --is-interactive; and rbenv init - --no-rehash fish | source

fish_add_path ~/bin
