set nocompatible
let mapleader = ','
set sw=4 ts=4 nu nobk ai cin
"shiftwidth tabstop number nobackup autoindent cindent
syn on
set mp=g++\ -std=c++11\ %\ -O2\ -o\ %<
map <F5> :w<CR> :make<CR>
au filetype c,cpp map <F6> :! ./%< <input.txt  <CR>
au filetype java map<F5> :w<CR> :!javac %<CR>
au filetype java map<F6> :!java %< <input.txt <CR>

nmap <silent> <leader>v :e ~/.vimrc<cr>
nmap <silent> <leader>s :source ~/.vimrc<cr> :echom 'reload vimrc!'<cr>
nmap <silent> <leader>p :setlocal paste!<cr>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
inoremap jk <Esc>


"插件配置 {{{


" 插件管理工具
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'


" 查找文件工具
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_by_filename = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|build$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.DS_Store$\|\.pyc$' }
nnoremap <leader>o :CtrlP<CR>

"代码补全
Plugin 'Valloric/YouCompleteMe'

" 文件列表
Plugin 'scrooloose/nerdtree'
"let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeShowHidden=1
map <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" go语言工具
Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_gocode_bin = "/Users/wiyr/Documents/bin/gocode"
"let g:go_fmt_fail_silently = 1

" git状态侧边栏
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_escape_grep = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '~-'
au Filetype go nmap gv <Plug>(go-def-vertical)
au Filetype go nmap gs <Plug>(go-def-split)
au Filetype go nmap gt <Plug>(go-def-tab)
au Filetype go nmap <C-]> <Plug>(go-def)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>tf <Plug>(go-test-func)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>p <Plug>(go-implements)
au FileType go nmap <leader>a <Plug>(go-calleers)

" 增强状态栏
Bundle 'bling/vim-airline'
let g:airline_left_sep=''
let g:airline_right_sep=''

" solarized配色
Plugin 'altercation/vim-colors-solarized'

" 注释工具
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"has problem in mac
"try
	"set background=dark
	"color solarized
	"let g:solarized_termcolors=256
	"let g:solarized_termtrans=1
"catch
	"color desert
"endtry
color desert


" 光标记忆
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \   if line("'\"") > 1 && line("'\"") <= line("$") |
        \     let JumpCursorOnEdit_foo = line("'\"") |
        \     let b:doopenfold = 1 |
        \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \        let b:doopenfold = 2 |
        \     endif |
        \     exe JumpCursorOnEdit_foo |
        \   endif |
        \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

