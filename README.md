# Ansible playbook for setting up a MacBook for development

## Quick links

- [dotfiles](roles/dotfiles/files)
- [NVIM](roles/dotfiles/files/.config/nvim)
- [homebrew](roles/homebrew/vars/main.yml)

## Installation

- Install [Homebrew](https://brew.sh/)
- Run the following commands:

```bash
brew install ansible
ansible-playbook -i inventory main.yml --ask-become-pass
```

## Available tags

Run only specific part of the playbook by using tags:

```bash
ansible-playbook -i inventory main.yml --ask-become-pass --t "dotfiles"
```

Available tags:

- dotfiles
- homebrew
- nvim
- oh-my-zsh
- git-repos
- configure-osx
