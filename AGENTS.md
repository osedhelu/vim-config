# AGENTS.md — AstroNvim v4 Configuration

This is an **AstroNvim v4** Neovim configuration repository (template-based). Focus on the points below that differ from defaults.

## Project Structure

```
init.lua                  # Entry point: loads lazy, then lazy_setup, then polish
lua/
  lazy_setup.lua         # Lazy.nvim config; imports AstroNvim v4, community, plugins
  community.lua          # AstroCommunity packs: lua, typescript, telescope-nvchad-theme
  polish.lua             # Post-setup hooks (disabled by default)
  config/
    diagnostic_ui.lua    # Custom diagnostic display tuning (piped to astrocore opts)
  plugins/
    astrocore.lua        # AstroNvim core options, mappings, diagnostics
    astrolsp.lua         # LSP configuration, eslint workaround
    astroui.lua          # UI/theme tweaks
    {mason,none-ls,treesitter}.lua  # Language tooling
    {neo-tree,which-key,flutter-tools,vim-easymotion}.lua  # Plugins
    _astrocore_mappings.lua, _astrolsp_mappings.lua  # Extra keybinds
lua/plugins/
  user.lua               # Custom user plugins (if any)
scripts/
  nvim-doctor.sh         # Health check, tree-sitter repair, diagnostics
.stylua.toml             # Lua formatter config (120 col, spaces=2)
selene.toml              # Lua linter config
.neoconf.json            # Neovim LSP workspace hints
lazy-lock.json           # Pinned plugin versions
README.md                # User-facing docs (Spanish); keybinds, setup
```

## Key Points for Agents

### 1. Entry Flow
- `nvim` starts → `init.lua` → bootstrap lazy.nvim
- Lazy loads `lazy_setup.lua` → imports AstroNvim v4, community packs, plugins from `lua/plugins/`
- AstroNvim provides base keybinds, LSP config, UI framework
- `polish.lua` runs last (currently disabled—remove line 1 to activate)
- Diagnostics fed through `config/diagnostic_ui.lua` to avoid flooding the buffer

### 2. Configuration Language
- **Lua only.** No VIML scripts in this repo.
- Formatter: **stylua** (120 cols, 2-space indents, auto-prefer double quotes)
- Linter: **selene** (catches common Lua mistakes)
- Code style in plugins follows AstroNvim conventions: LazySpec annotations, opts tables

### 3. Lazy.nvim & Plugin Loading
- All plugins declared in `lua/plugins/*.lua`
- Each file returns `LazySpec` table (annotated with `---@type LazySpec`)
- Lazy-loads plugins via `import "plugins"` in `lazy_setup.lua`
- **Note:** AstroNvim v4 pins plugins by default (unless `pin_plugins = nil`). Version tracking is on.

### 4. LSP & Diagnostics
- **LSP server install:** Use `:Mason` inside nvim (installs via mason-lspconfig)
- **Common servers:** `lua_ls`, `vtsls` (TypeScript/JavaScript), `pyright`, `jsonls`
- **ESLint as LSP:** Enabled via `astrocommunity.pack.typescript`. If it fails with error `-32603`:
  - Inside the project repo: run `npm ci && npx eslint .` to verify ESLint is healthy
  - Fallback in `init.lua` line 15: uncomment `vim.g.disable_eslint_lsp = true`
  - See README.md **ESLint in JS/TS** section for full details
- **Diagnostic display:** Tuned in `lua/config/diagnostic_ui.lua` to avoid virtual text flood (Pyright issues)

### 5. Community Packs
From `lua/community.lua`:
- `astrocommunity.pack.lua` — Lua language support (syntax, lsp config)
- `astrocommunity.pack.typescript` — TypeScript/JS (includes vtsls, eslint, prettier)
- `astrocommunity.recipes.telescope-nvchad-theme` — Telescope theme

### 6. Flutter Support
- `flutter-tools.nvim` is included (`lua/plugins/flutter-tools.lua`)
- Requires Flutter SDK in system PATH (`flutter --version` must work)
- Install via Homebrew (macOS) or Flutter official docs

### 7. Tree-sitter Compilation
- **Required:** C compiler (build-essential on Linux, Xcode CLT on macOS)
- **Troubleshooting:**
  ```bash
  ./scripts/nvim-doctor.sh check          # Run health checks
  ./scripts/nvim-doctor.sh fix-treesitter # Clean broken tmp files
  ./scripts/nvim-doctor.sh repair         # Clean + :TSUpdateSync all
  ```
- Or inside nvim: `:TSUpdateSync all`

### 8. Keybinds Architecture
- **Leader key:** Space (configured in `lazy_setup.lua`)
- **Local leader:** `,` (complementary binds)
- Base keybinds from AstroNvim core + community packs
- Extras in `lua/plugins/_astrocore_mappings.lua` and `_astrolsp_mappings.lua`
- View all: `:WhichKey` in nvim or press Space and wait for menu
- Keybind tables in `lua/plugins/astrocore.lua` use AstroCore mapping DSL (`desc`, `function`, modes)

### 9. Code Formatting & Linting
- **Lua:** stylua (see `.stylua.toml`)
- **JS/TS:** prettier (from typescript pack, via none-ls)
- **General:** none-ls.nvim integrates external tools as LSP client
- Format command: `ga` (normal) or `<Leader>ga` (visual) — triggers LSP format

### 10. First-Run Setup
1. Clone repo to `~/.config/nvim`
2. `nvim` → Lazy installs plugins (may take time, requires network)
3. `:Mason` → Install language servers you need
4. `:TSUpdateSync all` if Tree-sitter fails
5. `:checkhealth` to verify setup
6. Run `./scripts/nvim-doctor.sh check` for system dependency validation

### 11. Configuration Editing Workflow
- Add new plugins: create `lua/plugins/my-plugin.lua` (return LazySpec), Lazy auto-loads
- Modify options: edit `lua/plugins/astrocore.lua` (opts table) or create new plugin file
- Test changes: `:Lazy sync` then `:e init.lua` (forces reload)
- If plugins fail to load: `:checkhealth` + `./scripts/nvim-doctor.sh check`

### 12. Disabled Features
- `polish.lua` is disabled (line 1: `if true then return end`). Remove this guard to enable custom filetype setup.
- Default disabled plugins in Lazy config (gzip, netrw, tarPlugin, tohtml, zipPlugin) — adjust in `lazy_setup.lua` if needed

### 13. Diagnostic Mode & Performance
- **Diagnostic mode:** 3 (on, full UI) by default in `astrocore.lua`
  - 0 = off, 1 = no signs/virtual text, 2 = no virtual text
  - Pyright can be verbose; see `config/diagnostic_ui.lua` for filtering
- **Large file handling:** Files >256MB or >10,000 lines disable Tree-sitter, completion, etc.
- **Neovim version:** AstroNvim v4 requires 0.9.4+; recommend 0.10+ for best experience

## Common Commands for Agents

| Task | Command |
|------|---------|
| Health check | `./scripts/nvim-doctor.sh check` or `:checkhealth` in nvim |
| Diagnose Tree-sitter | `./scripts/nvim-doctor.sh fix-treesitter` then `:TSUpdateSync all` |
| View keybinds | `:WhichKey` or press Space + wait |
| Install LSP | `:Mason` (search + i to install) |
| Sync plugins | `:Lazy sync` |
| Format code | `ga` (normal) or `<Leader>ga` (visual) |
| Lint/format Lua | stylua + selene (integrated via none-ls or Mason) |

## External Dependencies
- **Neovim:** 0.9.4+ (tested on 0.10+)
- **Git:** Required (Lazy clones plugins)
- **C compiler + make:** Required for Tree-sitter & fzf-native
- **Node.js:** Recommended for TypeScript/JavaScript tooling
- **Nerd Font:** Recommended (icons in UI)
- **curl, ripgrep, fd:** Used by plugins for performance

See README.md **Requisitos del sistema** for full install steps (macOS / Linux).

## Spanish Docs
README.md is in Spanish and covers:
- Keybind tables (all modes & actions)
- Neo-tree navigation
- EasyMotion usage
- Vim fold commands
- Full system requirements & installation
- ESLint troubleshooting
- First-run checklist
