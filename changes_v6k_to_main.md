# Changes in `lua/plugins`: `v6k` → `main`

Generated from `git diff v6k..main -- lua/plugins/` and `git log`.

Two focal areas:

- **[MH]** — changes authored by Micah Halter
- **[CLI]** — changes that affect the Neovim command line (cmdline UI, command mappings, completion, statusline)

---

## Summary of all changed files

| File                                           | Status             | MH  | CLI |
| ---------------------------------------------- | ------------------ | :-: | :-: |
| `astrocore.lua`                                | modified           |  ✓  |  ✓  |
| `astrolsp.lua`                                 | modified           |  ✓  |     |
| `astrolspX.lua`                                | new                |     |     |
| `auto-save-nvim.lua` → `auto-save-nvimX.lua`   | renamed            |     |     |
| `autocmds.lua` → `autocmdsX.lua`               | renamed/modified   |     |     |
| `avante.lua` → `avanteL.luaX`                  | renamed (disabled) |  ✓  |     |
| `blink.lua`                                    | modified           |  ✓  |  ✓  |
| `blinkX.lua`                                   | new                |     |  ✓  |
| `cache-colorscheme.lua`                        | new                |     |     |
| `catppuccin.lua`                               | modified           |  ✓  |     |
| `codecompanion.lua`                            | modified           |     |     |
| `codediff.lua`                                 | new                |  ✓  |     |
| `codeium.lua`                                  | modified           |     |     |
| `codesettings.lua`                             | new                |  ✓  |     |
| `conform.lua`                                  | modified           |     |     |
| `copilot-lua-cmp.lua` → `copilot-lua-cmpX.lua` | renamed            |     |     |
| `dap.lua` → `dapX.lua`                         | renamed            |     |     |
| `diagnostics.lua` → `diagnosticsX.lua`         | renamed            |     |     |
| `diffview.lua`                                 | deleted            |  ✓  |     |
| `grug-far.lua`                                 | modified           |     |     |
| `heirline.lua`                                 | modified           |  ✓  |  ✓  |
| `heirlineX.lua`                                | new                |     |  ✓  |
| `iron-nvim.lua` → `iron-nvimX.lua`             | renamed            |     |     |
| `json5.lua` → `json5X.lua`                     | renamed            |     |     |
| `lsp-crash-fix.lua`                            | deleted            |  ✓  |     |
| `mappings.lua` → `mappingsX.lua`               | renamed/modified   |     |  ✓  |
| `markview-nvim.lua`                            | deleted            |  ✓  |     |
| `mason-tool-installer.lua`                     | modified           |  ✓  |     |
| `mason.lua`                                    | modified           |  ✓  |     |
| `metals.lua`                                   | modified           |  ✓  |     |
| `mini-move.lua`                                | modified           |     |     |
| `mini-snippets.lua`                            | modified           |     |     |
| `minuet.lua` → `minuetX.lua`                   | renamed/modified   |     |     |
| `neo-tree.lua`                                 | modified           |  ✓  |     |
| `neo-treeX.lua`                                | new                |     |     |
| `neogit.lua`                                   | modified           |     |     |
| `neotest.lua`                                  | modified           |     |     |
| `noice.lua`                                    | **deleted**        |  ✓  |  ✓  |
| `norgX.lua`                                    | new                |     |     |
| `nvim-lint.lua`                                | modified           |     |     |
| `oil.lua`                                      | modified           |  ✓  |     |
| `orgmode-nvim.lua` → `orgmode-nvimX.lua`       | renamed            |     |     |
| `overseer.lua`                                 | modified           |  ✓  |     |
| `overseerX.lua`                                | new                |     |     |
| `prose_mode.lua`                               | new                |  ✓  |     |
| `quarto.lua` → `quartoX.lua`                   | renamed            |     |     |
| `r-nvim.lua` → `r-nvimX.lua`                   | renamed            |     |     |
| `rainbow-delimiters.lua`                       | modified           |     |     |
| `render-markdown.lua`                          | modified           |     |     |
| `render-markdownX.lua`                         | new                |     |     |
| `sandwich.lua`                                 | modified           |     |     |
| `sidekick.lua`                                 | **new**            |  ✓  |     |
| `sidekickX.lua`                                | new                |     |     |
| `slime.lua`                                    | modified           |     |     |
| `slimeX.lua`                                   | new                |     |     |
| `snacks.lua`                                   | modified           |  ✓  |  ✓  |
| `snacksX.lua`                                  | new                |     |  ✓  |
| `telekasten.lua` → `telekastenX.lua`           | renamed            |     |     |
| `treesitter.lua` → `treesitterX.lua`           | renamed            |     |     |
| `uv-nvim.lua` → `uv-nvimX.lua`                 | renamed            |     |     |
| `venv-selector.lua`                            | modified           |  ✓  |     |
| `venv-selectorX.lua`                           | new                |     |     |
| `wakatime.lua`                                 | modified           |  ✓  |     |
| `overridden.lua` → `which-keyX.lua`            | renamed            |     |     |
| `writing.lua` → `writingX.lua`                 | renamed/modified   |     |     |

> **Convention:** Files renamed with an `X` suffix (or `L.luaX`) mark configs disabled/moved to user-local overrides as part of the split between Micah Halter's base config and the user's personal overrides.

---

## File-by-file details

### `noice.lua` — **DELETED** [MH] [CLI]

**Commit:** `cd41ef6` — _feat: move to ui2 rather than noice_ (Micah Halter, 2026-04-10)

The entire `noice.nvim` plugin configuration was removed. `noice` was responsible for:

- **Cmdline UI**: `cmdline = { view = "cmdline" }` — kept the command line at the bottom of the screen (native position) rather than a floating popup.
- **Message routing**: long messages and Lua output were routed to a split; save/paste/yank/delete notifications were suppressed.
- **LSP UI suppression**: `lsp.progress`, `lsp.hover`, and `lsp.signature` were all disabled via noice.
- **nvim-notify integration**: `{ "rcarriga/nvim-notify", init = false, config = true }` was loaded as a noice dependency.

Replaced by AstroNvim's `ui2` module (configured in `init.lua`), which provides equivalent notification and cmdline UI without the full noice stack.

---

### `astrocore.lua` — modified [MH] [CLI]

**Commits:** `6ed2b10`, `8a591d2`, `54135f6`, `d234658` (Micah Halter); additional user commits.

#### Command-line / mapping changes [CLI]

- **`q:` → `:`** — The command-history window shortcut `q:` is now remapped to `:`, opening the regular command line instead. This prevents accidentally entering the command-history window.
- **`<C-Q>` disabled** (normal mode) — was already mapped before; explicitly cleared.
- **`<C-S>` disabled** (normal and visual modes) — removed to avoid conflicts with save-shortcut assumptions.
- **Terminal mode**: `<C-BS>` → `<C-\><C-n>` for terminal-normal mode (replaces a block of commented-out alternatives like `jj`, `<esc>`, `<C-n>`).
- **Insert mode**: `<S-Tab>` → literal Tab character. Removed: `<F4>` date stamp.
- Large block of commented-out normal-mode mappings removed (orgmode, ipython, toggleterm, recording, timestamps, window management).

#### Other notable changes [MH]

- **Ansible detection** refactored: path-based regex (`tasks|roles|handlers`) replaced by explicit filename-pattern entries in `filetypes.pattern` (e.g. `".*/roles/.*/tasks/.*%.ya?ml"`).
- **Treesitter** options added: highlight disabled for `csv`/`tsv`; indent disabled for `yaml`.
- **`showtabline` callback** wrapped in `vim.schedule_wrap()` to prevent cursor location issues.
- **Diagnostics** moved into `astrocore` opts: `virtual_text` and `virtual_lines` both set with `min = WARN`; `virtual_lines` feature flag defaulted to `false`.
- **FileType autocmd** pattern extended to `"markdown.*"` for wrap/spell.
- Options block simplified: removed `signcolumn = "auto"`, `number = true`, `timeoutlen`, `ttimeoutlen`, `foldlevel`, and `vim.g.autoformat = false` (moved elsewhere or dropped).
- `qmd` extension mapped to `"markdown"` (was commented out as `"quarto"`).

---

### `snacks.lua` — modified [MH] [CLI]

**Commits:** `b479462`, `4b1100f`, `b3bc1bf`, `5a35bd7` (Micah Halter); user commits.

#### Command-line / picker-adjacent changes [CLI]

- All custom picker/spell/buffer/terminal/colorscheme mappings removed from `snacks.lua` and moved to `snacksX.lua` (user override file). This includes:
  - `z=` / `=z` / `<leader>fs` → spell picker
  - `]z` / `[z` → next/prev spell suggestion
  - `<leader>bf` / `<leader>b.` → buffer list
  - `<leader>f/` → buffer lines
  - `<leader>fu` / `<leader>fx` → resume last picker
  - `<leader>fo` → smart find
  - `<leader>ft` → terminal list
  - `<leader>fS` → colorschemes
  - `<C-D>` (insert) → delete buffer
  - `]]` / `[[` → word jump keys (moved to snacksX)

#### New mappings in `snacks.lua` (Micah Halter's base) [MH]

- **`<Leader>i`** — hover image preview (snacks image, closes on `CursorMoved`).
- **`<Leader>gI`** — GitHub Issues (`snacks.gh.issue()`).
- **`<Leader>gP`** — GitHub Pull Requests (`snacks.gh.pr()`).

#### Other changes [MH]

- `dashboard` disabled (`enabled = false`).
- `notifier.top_down` removed from base (moved to snacksX).
- Picker `win.preview` configured: no line numbers, no sign/fold columns in preview window.
- `gitbrowse` URL patterns updated for new `code.mehalter.com` Gitea path format (`/src/branch/` etc.).

---

### `snacksX.lua` — new file [CLI]

New user-override file that holds all the custom picker/navigation mappings extracted from the old `snacks.lua`:

- `]]`/`[[` word jump keys
- Spell picker (`z=`, `=z`, `]z`, `[z`, `<leader>fs`)
- Buffer/find/terminal/colorscheme picker mappings
- `notifier.top_down = false`

---

### `heirline.lua` — modified [MH] [CLI]

**Commit:** part of `5da4af2` — _chore: prepare for astronvim v6 release_ (Micah Halter).

- **Status line separators** changed: `left = { " ", "" }` / `right = { " ", "" }` → `left = { "", " " }` / `right = { " ", "" }` (swapped powerline arrow direction).
- **Clock icon** changed: ` ` → ``.
- User's preferred separators (old style) preserved in new `heirlineX.lua`.

---

### `heirlineX.lua` — new file [CLI]

User override: restores the original separator style `left = { " ", "" }` / `right = { " ", "" }` that was present in the old `heirline.lua`.

---

### `blink.lua` — modified [MH] [CLI]

**Commits:** `2c39418` (Micah Halter), user commits.

#### Command-line completion changes [CLI]

- **`cmdline` provider** custom `min_keyword_length` function removed from base config (was suppressing completion when no space had been typed). Moved to `blinkX.lua`.
- **`<Tab>` keymap** changed: now calls `vim.g.ai_accept()` first (for inline AI completion acceptance) before falling back to snippet-forward. `<C-k>`/`<C-j>` prev/next completion removed from base.

#### Other changes

- `version = "^1"` pinning removed.
- `minuet-ai` dependency removed from base `blink.lua` (moved to `blinkX.lua`/user config).
- `avante_commands/files/mentions/shortcuts` blink sources removed from base.
- Platform-specific fuzzy implementation (Windows curl/rust workaround) removed.

---

### `blinkX.lua` — new file [CLI]

User override file for blink.cmp containing:

- Windows-specific fuzzy implementation fallback
- `minuet-ai` integration
- `cmdline` provider `min_keyword_length` function
- Avante completion sources

---

### `sidekick.lua` — new file [MH]

**Commits:** `6a0e6dd`, `3e12a19`, `bd33cf3`, `8bacc5d` (Micah Halter).

New AI tools plugin replacing the previous avante-based setup. Key features:

- **`<C-.>`** — toggle AI CLI (normal, insert, visual, terminal modes).
- **`<Leader>A<CR>`** — toggle Codex CLI.
- **`<Leader>AO`** — toggle OpenCode (added in `8bacc5d`).
- **`<Leader>AA`** — toggle any installed AI CLI.
- **`<Leader>Ad`** — detach AI CLI.
- **`<Leader>As`** — select AI CLI.
- **`<Leader>At`/`Af`/`Ap`** — send this/file/prompt to AI CLI.
- **`<Leader>Al`** — toggle Copilot LSP.
- **`<Leader>AP`** — search for agent plan files (`PLAN.md`, `PLAN.*.md`).
- **`<C-CR>`** (insert) — accept inline completion (guarded: only if no LSP inline completion active).
- Configures `astrolsp` for `inline_completion = true` and installs `copilot-language-server` via mason.
- `vim.g.ai_accept` set to call `sidekick.nes_jump_or_apply()` or LSP inline completion.

---

### `astrolsp.lua` — modified [MH]

**Commits:** `594c7eb`, `f72535c`, `3475535` (Micah Halter).

Major refactor for AstroLSP v4 / native LSP API:

- **`codelens` disabled** by default (`features = { codelens = false }`).
- `format_on_save` config removed (kept in new `astrolspX.lua`).
- All inline server `config` entries removed (basedpyright, clangd, gopls, lua_ls, metals, texlab, vtsls, etc.) — these are now handled via `vim.lsp.config()` directly or in separate files.
- `julials` handler rewritten: now uses `vim.lsp.config()`/`vim.lsp.enable()` API instead of `before_init` callback. Sysimage shim detection logic preserved.
- `codesettings` integration added to julials handler.
- `mason_lspconfig` nextflow server entry removed (moved to `astrocore.lua` filetypes).
- R language server removed from base servers list (kept in `astrolspX.lua`).

---

### `astrolspX.lua` — new file

User override for `astrolsp`: re-adds R language server and `format_on_save` configuration.

---

### `codesettings.lua` — new file [MH]

**Commit:** `d62f5ba` (Micah Halter).

New plugin `mrjones2014/codesettings.nvim` with `live_reload = true`. Patches all LSP server `before_init` handlers to call `codesettings.with_local_settings()`, enabling per-project `.codesettings.json` overrides.

---

### `codediff.lua` — new file [MH]

**Commits:** `95066f3`, `1b00ebb`, `d2396f9` (Micah Halter).

Replaces `diffview.nvim`. Provides diff/conflict resolution UI via `esmuellert/codediff.nvim`:

- `<Leader>D<CR>` — open CodeDiff.
- `<Leader>Dh` — file history.
- `<Leader>DH` — branch history against origin/main.
- `<Leader>Do` — open CodeDiff against origin branch.
- Hunk navigation: `]C`/`[C`, file navigation: `]D`/`[D`.
- Conflict resolution: `<Leader>Dt/o/a/b`, `<Leader>DT/O`.
- Neogit integration: `integrations.codediff = true`, `diff_viewer = "codediff"`.

---

### `diffview.lua` — **DELETED** [MH]

**Commit:** `95066f3` (Micah Halter) — _feat(plugins): migrate from diffview to codediff_.

`sindrets/diffview.nvim` removed and replaced by `codediff.lua`.

---

### `wakatime.lua` — modified [MH]

**Commit:** `c31e910` (Micah Halter) — _chore: disable wakatime if on vpn_.

Plugin re-enabled (was `return {}`) but with `enabled = false` and a `cond` that checks for VPN interfaces (`tun`, `wg`, `ppp` via `ip addr`). Wakatime only activates when not on VPN.

---

### `catppuccin.lua` — modified [MH]

**Commits:** `99e9831`, `bf2e6b9`, `104ad0d` (Micah Halter).

- Automatic integration detection enabled (explicit integration flags removed).
- Floating window options updated for new catppuccin API.
- General cleanup.

---

### `mason-tool-installer.lua` — modified [MH]

**Commits:** `d392762`, `32a0b74` (Micah Halter).

- `tree-sitter-cli` removed from forced installs.
- `lua-language-server` version pinned temporarily (pending lazydev fix).
- Haskell tools auto-installation removed (`dd7c393`).

---

### `oil.lua` — modified [MH]

**Commit:** `f0da462` (Micah Halter) — _chore(oil): improve code_. Also `a01d1e5` (in v6k only): hide untracked git files, show tracked.

Code improvements; git status display tweaked.

---

### `overseer.lua` — modified [MH]

**Commit:** `30539c5` (Micah Halter) — _fix(overseer): update to new non-deprecated API endpoints_.

Updated to non-deprecated overseer API. `overseerX.lua` created to hold user-extended overseer config.

---

### `metals.lua` — modified [MH]

**Commit:** `05098c9` (Micah Halter) — _fix(metals): update to work with AstroLSP v4_.

Updated metals config for AstroLSP v4 native LSP API.

---

### `prose_mode.lua` — new file [MH]

**Commit:** `cf474e3` (Micah Halter) — _feat(plugins): add a prose mode for natural language typing_.

New prose/writing mode plugin configuration for natural language editing.

---

### `venv-selector.lua` — modified [MH]

**Commit:** `5346d6c` (Micah Halter) — _chore(venv-selector): new branch merged to main_.

Updated to track the merged `main` branch.

---

## Commits in `v6k` not yet in `main` (by Micah Halter)

| Commit    | Summary                                                                |
| --------- | ---------------------------------------------------------------------- |
| `3c07e3a` | feat(plugins): add Nextflow language support                           |
| `a01d1e5` | feat(oil): hide all untracked git files and show all tracked git files |
| `e3ebe08` | fix(lazydev): add missing `cmd`                                        |
| `b7ab7c9` | fix(lsp-file-operations): enable capabilities in language servers      |
| `42dca1b` | feat(mason-nvim-dap): add adapter to vscode dap extension              |
| `39d4702` | fix(mason-nvim-dap): fix typo                                          |
| `16d1e58` | feat(mappings): make `n` and `N` always go forward/back respectively   |
| `c8d6a04` | feat(telescope): use new `filename_first` display option for telescope |

---

## Command-line impact summary

| Change                               | Plugin/File                  | Effect                                                                                |
| ------------------------------------ | ---------------------------- | ------------------------------------------------------------------------------------- |
| `noice.lua` deleted                  | `noice.lua`                  | Removes enhanced cmdline popup UI; reverts to native bottom cmdline (via ui2)         |
| `q:` → `:`                           | `astrocore.lua`              | Pressing `q:` now opens the command line, not the command-history window              |
| `<C-S>` disabled                     | `astrocore.lua`              | Prevents save-shortcut conflicts in normal and visual modes                           |
| cmdline completion threshold removed | `blink.lua`                  | Base config no longer suppresses completion on initial cmdline word (moved to blinkX) |
| `<Tab>` AI-first                     | `blink.lua`                  | Tab now tries AI inline completion before snippet/fallback                            |
| Status line separators swapped       | `heirline.lua`               | Left separator changed from `" "+"→"` to `"→"+" "` style (cosmetic)                   |
| Custom picker mappings moved         | `snacks.lua` → `snacksX.lua` | Spell/buffer/terminal picker shortcuts no longer in base config                       |
| `notifier.top_down`                  | `snacks.lua` → `snacksX.lua` | Notification stack direction moved to user override                                   |
