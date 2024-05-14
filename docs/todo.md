# To Do

Regular read: https://dotfyle.com/this-week-in-neovim
Treesitter config: https://alpha2phi.medium.com/neovim-101-tree-sitter-d8c5a714cb03

- smoka7/hop.nvim
- surround (sr, sd, ...)
- hinell/lsp-timeout.nvim (keep nvim fast)
- search for plugin to create git project
- (Fuzzy) File explorerer: https://github.com/SalOrak/whaler.nvim
- Data viewer: https://github.com/VidocqH/data-viewer.nvim
- Build nvim plugins: https://github.com/trimclain/builder.nvim
- soulis-1156/hoverhints.nvim
- dasupradyum/launch.nvim


## Code runners

- https://github.com/arjunmahishi/flow.nvim
- sniprun (not working on windows): https://github.com/michaelb/sniprun
- code runnder?
- dash.nvim
- https://github.com/ten3roberts/recipe.nvim

- Codi Vim: https://github.com/metakirby5/codi.vim

## Markdwon

- https://github.com/gsuuon/note.nvim
- https://github.com/epwalsh/obsidian.nvim
- https://github.com/oflisback/obsidian-bridge.nvim

- https://github.com/NFrid/markdown-togglecheck
- gaoDean/autolist.nvim
- fcpg/vim-waikiki

Markdwon previewers:

- https://github.com/oknozor/illumination (rust)
- https://github.com/euclio/vim-markdown-composer (rust)
- {"davidgranstrom/nvim-markdown-preview"},
- {"jghauser/follow-md-links.nvim"},
- {"NFrid/markdown-togglecheck"},

- my function to increment / decrement headers
- ixru/nvim-markdown
- https://github.com/jakewvincent/mkdnflow.nvim
- lervag/wiki.vim

- https://dev.to/konstantin/taking-notes-in-vim-revisited-558k
- http://joereynoldsaudio.com/2018/07/07/you-dont-need-vimwiki.html
- https://timunkert.net/2021/12/using-neovim-as-a-markdown-editor.html

## managing python environments

- rafi/...

## Miscelleneuous

- changes to the auto-completion symbols have been some how introduced by commit from 2022-09-14

- neovim move: https://alpha2phi.medium.com/neovim-101-motion-3b20c37b623a
- [ ] Customize cmp Completion??
- [ ] lazygit: don't show start up window, (go back)
- [o] better / consistent quitting (closing) of buffers, expecially floating windows/buffers
- [ ] new mappings for Calendar-vim plugin (switched off defaults because of conflicts)
- [ ] run code in interactive shell, send code, ...
- [ ] how to debug
- [ ] autocommnds: rewrite vim stuff to LUA
- [ ] alpha: line at left hand side
- [ ] alpha dot-file: https://github.com/alpha2phi/dotfiles
- [-] https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e
  - [x] 1
  - [ ] 2: "mfussenegger/nvim-treehopper", 'ruifm/gitlinker.nvim','jbyuki/instant.nvim'
  - [ ] 3: "vuki656/package-info.nvim", crates.nvim, "haringsrob/nvim_context_vt", "rhysd/git-messenger.vim", "nacro90/numb.nvim",
  - [ ] 4: "j-hui/fidget.nvim", "hoschi/yode-nvim", "AckslD/nvim-neoclip.lua",
  - [ ] 5: https://alpha2phi.medium.com/neovim-plugins-for-a-better-coding-experience-part-5-7ac5aff6867
- [ ] https://alpha2phi.medium.com/jupyter-notebook-vim-neovim-c2d67d56d563
- [ ] https://alpha2phi.medium.com/vim-neovim-plugins-for-a-better-integrated-experience-6accd4c2a52c
- [ ] https://alpha2phi.medium.com/vim-neovim-managing-notes-and-todo-list-8ae8e3db6464
- [ ] https://alpha2phi.medium.com/new-neovim-plugins-to-improve-development-workflow-33419d74e9ac

https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e

- [x] use {'nvim-treesitter/nvim-treesitter-refactor'}
- [x] https://github.com/romgrk/nvim-treesitter-context

## Configurations

- [https://nvchad.com/]

## Plugins

- https://github.com/kyazdani42/nvim-tree.lua
- https://github.com/LinArcX/telescope-command-palette.nvim or "mrjones2014/legendary.nvim",

```lua
use { "RRethy/nvim-treesitter-textsubjects" }
```

In your treesitter configuration,

```lua
require("nvim-treesitter.configs").setup {
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
}
```

```lua
use {
  "AckslD/nvim-neoclip.lua",
  requires = {
    { "kkharji/sqlite.lua", module = "sqlite" },
    -- you'll need at least one of these
    -- {'nvim-telescope/telescope.nvim'},
    -- {'ibhagwan/fzf-lua'},
  },
  config = function() require("neoclip").setup() end,
}
```
