#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if [ -d $HOME/.vim ]; then
    mv $HOME/.vim $HOME/.vim.bak
fi
/usr/bin/env git clone https://github.com/wiyr/vim.git $HOME/.vim

if [ ! -e $HOME/.vim/vimrc ]; then
    exit 1
fi
ln -s $HOME/.vim/vimrc $HOME/.vimrc

/usr/bin/env git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
vim +BundleInstall +qall
