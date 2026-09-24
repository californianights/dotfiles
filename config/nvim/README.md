# Neovim Config

Active configuration lives in `lua/config`.

## Structure

- `init.lua`: entrypoint.
- `lua/config/settings.lua`: simple toggles and high-level preferences.
- `lua/config/options.lua`: editor options.
- `lua/config/keymaps.lua`: global keymaps.
- `lua/config/autocmds.lua`: generic automation.
- `lua/config/lsp.lua`: LSP servers, LSP keymaps, diagnostics.
- `lua/config/plugins/init.lua`: plugin registry that combines all plugin groups.
- `lua/config/plugins/*.lua`: plugin setup grouped by responsibility.
- `after/ftplugin/*.lua`: filetype-specific editor behavior.

## Where To Change What

- Change leader key, theme, explorer width, diagnostics, inlay hints: `lua/config/settings.lua`.
- Change editing defaults like numbers, splits, clipboard, search behavior: `lua/config/options.lua`.
- Change your personal hotkeys: `lua/config/keymaps.lua`.
- Add or remove plugins: add or edit a file in `lua/config/plugins`, then include it in `lua/config/plugins/init.lua`.
- Add a new language server: edit `lua/config/lsp.lua`.
- Add filetype-specific indentation or behavior: create a file in `after/ftplugin`.

## Included By Default

- Go support with `gopls`, `goimports`, `gofumpt`.
- YAML, JSON, TOML, Dockerfile, Bash, Markdown support.
- Tree explorer with `nvim-tree`.
- File tabs with `bufferline`.
- Git signs and `:Git` via fugitive.
- Search with Telescope.
- Completion with `nvim-cmp` and snippets.
- Formatting with `conform.nvim`.
- AI chat / inline features with `copilot.lua` and `codecompanion.nvim`

## First Start

Open Neovim and wait for plugins and Mason tools to install.

Useful commands:

- `:Lazy` to inspect plugins.
- `:Mason` to inspect LSP servers and external tools.
- `:checkhealth` to inspect environment problems.

## Core Keys

- `<Space>e`: toggle file tree.
- `<Space>ff`: find files.
- `<Space>fg`: search in project.
- `<Space>fb`: list open buffers.
- `<Space>gg`: git status.
- `<Space>w`: save.
- `<Space>bd`: close current buffer.
- `Shift-h` / `Shift-l`: previous or next buffer.
- `gd`: definition.
- `gr`: references.
- `K`: hover documentation.
- `<Space>ca`: code actions.
- `<Space>cr`: rename symbol.
- `<Space>cf`: format file.

## Recommended External Tools

- `git`
- `go`
- `ripgrep`
- `fd` (optional but useful)