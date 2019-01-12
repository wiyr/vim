#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if [ -e $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc.bak
fi

if [ -d $HOME/.vim ]; then
    mv $HOME/.vim $HOME/.vim.bak
fi
/usr/bin/env git clone https://github.com/wiyr/vim.git $HOME/.vim
pushd $HOME/.vim
/usr/bin/env git checkout -b simple_version origin/simple_version
popd

if [ ! -e $HOME/.vim/vimrc ]; then
    exit 1
fi
ln -s $HOME/.vim/vimrc $HOME/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall < /dev/tty
