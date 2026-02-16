# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A declarative Neovim configuration built with **NixVim** (nix-community/nixvim). All configuration is written in Nix, not Lua — though Lua appears inline via `extraConfigLua` blocks and keymap action strings.

## Commands

```bash
# Run the base (no language-specific tooling) configuration
nix run .#

# Run language-specific configurations
nix run .#rust
nix run .#python
nix run .#golang
nix run .#csharp
nix run .#javascript

# Validate configuration integrity
nix flake check .

# Update flake dependencies
nix flake update
```

There are no tests, linters, or build steps beyond `nix flake check .`.

## Architecture

### Flake Structure

`flake.nix` defines 6 package outputs, each composing the base config with optional language modules:

- **default** — `./config` only (editors, UI, base LSP for Nix/JSON/YAML/Markdown/TOML)
- **rust/python/golang/csharp/javascript** — `./config` + `./config/{language}/`

Each output uses `nixvim.makeNixvimWithModule` to produce a standalone Neovim binary with all plugins and tools bundled via Nix.

### Config Module System

`config/default.nix` auto-imports every `.nix` file in `config/` (excluding itself). Language subdirectories (`config/rust/`, `config/python/`, etc.) use the same pattern. This means:

- **Adding a new `.nix` file to `config/` automatically includes it** — no manual import needed.
- **Language directories are NOT auto-imported by the base config.** They are explicitly imported in `flake.nix` per-output.

### Key Config Files

| File | What it configures |
|---|---|
| `config/keys.nix` | All keymaps (~150 bindings) via which-key groups. Largest file. |
| `config/language.nix` | nvim-cmp completion, base LSP servers, conform-nvim formatters, diagnostics |
| `config/debugging.nix` | DAP base setup, breakpoint signs, UI listeners |
| `config/sets.nix` | Plugin enablement flags (treesitter, nvim-tree, bufferline, lualine, etc.) |
| `config/options.nix` | Core editor options (tabs, clipboard, search, undo) |
| `config/find.nix` | FZF-Lua and Telescope configuration |
| `config/dashboard.nix` | Alpha startup dashboard |
| `config/themes.nix` | Colorscheme (onedark) |
| `config/plugins.nix` | Extra plugins (vim-dadbod for databases) |

### Language Module Pattern

Each language directory contains:
- `language.nix` — LSP server, formatter, and language-specific plugin config
- `debugging.nix` — DAP adapter configuration

### Inline Lua

Lua code is embedded in Nix via:
- `extraConfigLua` — top-level Lua blocks executed at init
- Keymap `action` fields — `lua` attribute with inline Lua function strings
- `extraOptions` — raw Vim/Lua option passthrough

When editing keymaps or plugin config, pay attention to whether the action is a Vim command string or a Lua function string (indicated by the `lua = true` attribute on the keymap).
