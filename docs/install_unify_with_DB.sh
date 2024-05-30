#######################################################
# pre-requisits
#######################################################

# homebrew: https://www.how2shout.com/linux/how-to-install-brew-ubuntu-20-04-lts-linux/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
# echo 'export "PATH=$PATH:~/linuxbrew/.linuxbrew/bin/brew" >> ~/.zshrc'
# echo 'export "PATH=$PATH:~/linuxbrew/.linuxbrew/bin/brew" >> ~/.bashrc'
brew install gcc
brew doctor

sudo apt -y install npm
sudo apt -y install libsqlite3-dev # required for ipython

#######################################################
# install packages and tools
#######################################################

# -- general --
sudo apt-get install xclip
sudo apt install pcre2-utils
sudo luarocks install luarocks-fetch-gitrec # --local

# for https://github.com/jupyter-vim/jupyter-vim
sudo apt install jupyter jupyter-core
sudo apt install -y python-tk
sudo apt-get install "python3-qt*"
sudo pip3 install pyqt5

# -- display images --
sudo pip3 install --upgrade Pillow
# pip uninstall pillow
# CC="cc -mavx2" pip install -U --force-reinstall pillow-simd
sudo pip3 install cairosvg
sudo apt install xorg-dev # required for ueberzug
sudo pip install ueberzug
# display latex formulas
sudo pip install pnglatex
# isplaying Plotly figures
sudo pip3 install --upgrade plotly kaleido

# -- markdwon --
sudo npm install -g markdownlint-cli
brew install vale
yarn add mermaid

# python:
sudo pip install "python-lsp-server[all]"
sudo python3 -m pip install pyright pyls
sudo pip install pylsp-mypy
sudo pip install python-lsp-black
sudo pip install pylsp-rope
sudo pip install pyls-memestra pyls-isort pyls-flake8
sudo pip install black
sudo pip install isort
sudo pip install ipdb
sudo pip install bpython
# -- lazy git --
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit

# ripgrep:
RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}_amd64.deb"
sudo apt install -y ./ripgrep.deb
rm -rf ripgrep.deb
rg --version

# =======================================================

# brew install luarocks
# luarocks install luacheck  # if you want to use luacheck
cargo install selene # if you want to use selene instead of luacheck
# brew install hadolint  # if you want to lint dockerfiles
pip install vim-vint # for vim linting
# install llvm and clang_format for clang stuff
npm install -g @fsouza/prettierd # if you want to use prettierd
npm install markmap-cli
npm audit fix --force

python -m pip install pynvim neovim
pip install yapf flake8 black    # for python stuff

# if you want to use the markdown thingy
# brew install vale markdownlint-cli
# cp -r ~/.config/lvim/.vale ~/.config/vale
# fix the address inside .vale.ini
# cp ~/.config/lvim/vale_config.ini ~/.vale.ini
# if you want the latex stuff
# brew install --cask mactex-no-gui # for mac
# or install zathura and chktex on linux

#######################################################
# languages
#######################################################

# https://tecadmin.net/write-append-multiple-lines-to-file-linux/

touch ~/.rep.lua
echo ~/.rep.lua "
if repl.VERSION >= 0.8 then
  -- default plugins
  repl:loadplugin 'linenoise'
  repl:loadplugin 'history'
  repl:loadplugin 'completion'
  repl:loadplugin 'autoreturn'
end

-- suppress warning message
repl.quiet_default_plugins = true
" >>~/.rep.lua

# julia
julia_mainversion='1.8'
julia_subversion='5'
julia_version=$julia_mainversion'.'$julia_subversion
cd
wget 'https://julialang-s3.julialang.org/bin/linux/x64/'$julia_mainversion'/julia-'$julia_version'-linux-x86_64.tar.gz'
tar zxvf 'julia-'$julia_version'-linux-x86_64.tar.gz'
echo 'export PATH="$PATH:$HOME/julia-'$julia_version'.'$julia_subversion'/bin"' >>~/.zshrc
rm 'julia-'$julia_version'-linux-x86_64.tar.gz'
