choco install lazygit -f -y
# scoop bucket add extras
# scoop install lazygit
choco install universal-ctags -f -y
choco install neovim -f -y
choco install fzf -f -y
choco install ag -f -y
choco install ripgrep-all -f -y
choco install pandoc -f -y
choco install win32yank -f -y
choco install vale -f -y
choco install deno -fy
choco install nodejs -fy
choco install yarn -fy
choco install deno --force -y  # peek.nvim interactive markdown file view in "browser"
choco install mingw -fy  # (gcc / mingw, llvm, zig are required for treesitter)
# choco install visidata  

# choco install zig -fy  # may not work  (gcc / mingw, llvm, zig are required for treesitter)
# choco install llvm -fy  # may not work  (gcc / mingw, llvm, zig are required for treesitter)

# choco install npm -f -y
npm install tslib                    # markdown-preview
npm install -g @compodoc/live-server # markdown-preview
npm install tree-sitter-cli
npm install markmap-cli
npm audit fix --force

choco install oh-my-posh -f -y # similar to oh-my-zsh
# instead of choco winget could be better

choco upgrade all -y

# choco install microsoft-windows-terminal –pre -f -y
# choco install zig -f -y

# for https://github.com/jupyter-vim/jupyter-vim
python -m pip install pynvim neovim
pip install jupyter
pip install ipdb
pip
npm install -g npm-check-updates
pip3 install visidata

# ~/.npmrc
# strict-ssl=false
