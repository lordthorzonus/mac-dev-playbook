# Ansible playbook for setting up a macbook for development

## Installation

- Install [homebrew](https://brew.sh/)
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
