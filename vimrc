"inoremap <esc> <nop>
set previewheight=7
set nocompatible
let mapleader = ','
let localleader = '\\'
set sw=4 ts=4 nu nobk ai cin
set expandtab
"shiftwidth tabstop number nobackup autoindent cindent
syn on
set mp=g++\ -std=c++11\ %\ -O2\ -o\ %<
map <F5> :w<CR>:make<CR>
au filetype c,cpp map <F6> :! ./%< <input.txt  <CR>
au filetype java map<F5> :w<CR> :!javac %<CR>
au filetype java map<F6> :!java %< <input.txt <CR>

set mouse=a
nmap <silent> <leader>v :e ~/.vimrc<cr>
nmap <silent> <leader>s :source ~/.vimrc<cr>:echom 'reload vimrc!'<cr>
nmap <silent> <leader><leader>p :setlocal paste!<cr>
" conflict with some plugin
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nmap <right> :bn!<cr>
nmap <left> :bp!<cr>
nmap ; :
"remove ^M
nnoremap <leader>cm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
inoremap jk <Esc>
" Switch CWD to the directory of the open buffer
cmap cd. lcd %:p:h
cmap w!! w !sudo tee % >/dev/null
" Remap VIM 0 to first non-blank character
map 0 ^
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.tsx,*.cpp,*.txt,*.vimrc,*.md :call DeleteTrailingWS()
autocmd BufWrite *.py :call DeleteTrailingWS()


vmap <silent> * :call VisualSearch('f')<CR>
vmap <silent> # :call VisualSearch('b')<CR>
vmap <silent> gv :call VisualSearch('gv')<CR>
" 查找/搜索
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		execute "noautocmd grep -Inr " . l:pattern . "" . " **/*"
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"插件配置 {{{


" 插件管理工具
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'

" 多光标
Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<ESC>'


" 代码域选择
Plugin 'terryma/vim-expand-region'
nmap <Up> <Plug>(expand_region_expand)
nmap <Down> <Plug>(expand_region_shrink)

" 查找文件工具
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_by_filename = 0
let g:ctrlp_max_files=500
let g:ctrlp_max_depth=10
let g:ctrlp_mruf_max=50
let g:ctrlp_cmd = ''
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\.git$\|\.hg$\|\.svn$\|build$',
			\ 'file': '\.exe$\|\.so$\|\.dll$\|\.DS_Store$\|\.pyc$' }
nnoremap <leader>o :CtrlPMRU<CR>
au filetype nerdtree nnoremap mk :Bookmark<CR>
au filetype nerdtree nnoremap cm :ClearBookmarks<CR>
au filetype nerdtree nnoremap ca :ClearAllBookmarks<CR>

"代码补全
Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"display keywords of the programming language
let g:ycm_seed_identifiers_with_syntax = 1

" 文件列表
Plugin 'scrooloose/nerdtree'
"let NERDTreeShowBookmarks=1
" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeShowHidden=1
map <leader>n :NERDTreeToggle<CR>
":NERDTreeMirror<CR>

"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endi
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" inoremap <Tab> <c-r>=UltiSnips#ExpandSnippet()<cr>
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" tag列表
Plugin 'majutsushi/tagbar'
nnoremap <silent> <leader>m :Tagbar<CR>

" webapi-vim
Plugin 'mattn/webapi-vim'


" go语言工具
Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fileds = 1
let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
"highlight such as // +build linux
"let g:go_highlight_build_constraints = 1
"let g:go_gocode_bin = "/Users/wiyr/Documents/bin/gocode"
"let g:go_fmt_fail_silently = 1
"au Filetype go nmap gv <Plug>(go-def-vertical)
"au Filetype go nmap gs <Plug>(go-def-split)
"au Filetype go nmap gt <Plug>(go-def-tab)
au Filetype go nmap <C-]> <Plug>(go-def)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>tf <Plug>(go-test-func)
"au FileType go nmap <leader>c <Plug>(go-coverage)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
" Show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <leader>i <Plug>(go-implements)
au FileType go nmap <leader>a <Plug>(go-calleers)

" Show type info for the word under your cursor
"au FileType go nmap <leader>i <Plug>(go-info)

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
" all errors show in quickfix windows
"let g:go_list_type = "quickfix"
"let g:go_list_type_commands = {"GoBuild": "locationlist"}
"nnoremap <C-n> :cnext<CR>
"nnoremap <C-m> :cprevious<CR>
"Location list
nnoremap <C-n> :lnext<CR>
nnoremap <C-p> :lprevious<CR>
nnoremap <leader>cc :cclose<CR>
let g:go_metalinter_autosave_enabled = ['errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_test_show_name = 1
"highlight variable when cursor stop on some variable
"let g:go_auto_sameids = 1


" git command in vim
Plugin 'tpope/vim-fugitive'
" git状态侧边栏
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_escape_grep = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '~-'

"快速移动
Plugin 'easymotion/vim-easymotion'
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" 增强状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_left_sep=''
let g:airline_right_sep=''

" color配色
Plugin 'altercation/vim-colors-solarized'
Plugin 'TuttiColori-Colorscheme'
Plugin 'junegunn/seoul256.vim'
Plugin 'iCyMind/NeoSolarized'
Plugin 'desert256.vim'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'tango.vim'
Plugin 'flazz/vim-colorschemes'

" 注释工具
Plugin 'scrooloose/nerdcommenter'

"typescript highlight
Plugin 'leafgarland/typescript-vim'
"it works pretty well but there are cases where it fails.
let g:typescript_indent_disable = 1

"Vim indenter for standalone and embedded JavaScript and TypeScript.
Plugin 'jason0x43/vim-js-indent'

"typescript language
"Plugin 'Shougo/vimproc.vim'

Plugin 'Quramy/tsuquyomi'
"use syntastic check
let g:tsuquyomi_disable_quickfix = 1

"easy code formatting
Plugin 'Chiel92/vim-autoformat'
let verbose=1
let g:formatdef_my_cpp='"astyle --style=java"'
let g:formatters_cpp=['my_cpp']
"sudo pip install --upgrade autopep8
let g:formatters_py=['autopep8']

"Plugin 'nvie/vim-flake8'
"let g:flake8_show_in_file=1
"let g:flake8_show_in_gutter=1  " show
"autocmd BufWritePost *.py call Flake8()
"" to use colors defined in the colorscheme

" 代码风格检查
Plugin 'scrooloose/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=0
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint'] " You shouldn't use 'tsc' checker.
let g:syntastic_c_checkers=[]
let g:syntastic_cpp_checkers=[]
"let g:syntastic_java_checkers=['checkstyle', 'javac']
"YCM required
let g:syntastic_java_checkers = []
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_reuse_loc_lists = 0
"let g:syntastic_go_checkers=['govet', 'golint', 'gometalinter']
"let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:syntastic_debug = 3
nnoremap <leader>j :call ChangeJump()<CR>

function! ChangeJump()
   let g:syntastic_auto_jump= 1 - g:syntastic_auto_jump
    if len(g:syntastic_python_checkers)
        let g:syntastic_python_checkers=[]
    else
        let g:syntastic_python_checkers=['flake8']
    endif
endfunction

" set mode of write markdown or text
Plugin 'junegunn/goyo.vim'
Plugin 'amix/vim-zenroom2'
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"Hyperfocus-writing in Vim.
"Plugin 'junegunn/limelight.vim'

" confict with nnoremap <C-J> <C-W>j
"Plugin 'vim-latex/vim-latex'
Plugin 'lervag/vimtex'


Plugin 'python-mode/python-mode'
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_folding = 0
let g:pymode_rope=1
let g:pymode_rope_autoimport = 1
"use ycm
let g:pymode_rope_completion = 0
let g:pymode_lint = 0
let g:pymode_syntax = 0
let g:pymode_options_max_line_length = 120

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"has problem in mac
try
	"set background=dark
	"color solarized
catch
endtry

try
	"let g:seoul256_background = 235
	"colo seoul256
catch
endtry
"colo peaksea
"colo desert
"colo tutticolori
"colo NeoSolarized
"colo desert256
colo afterglow
"colo tango
"let g:bg_tango = 1
"colo cobalt2
" highlight row
set cursorline

"Change cursor shape in different modes
"For tmux running in iTerm2 on OS X
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif


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

augroup JumpErrorList
	au!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l*    lwindow
augroup END

set noswapfile

au filetype c,cpp map <F3> :call SetTitleOfCodeforces()<CR>GkkO
func! SetTitleOfCodeforces()
	call setline(1,       "#include <bits/stdc++.h>")
	call append(line("$"), "typedef long long LL;")
    call append(line("$"), "using namespace std;")
	call append(line("$"), "#define ALL(x) (x.begin(), x.end())")
	call append(line("$"), "#define mset(a,i) memset(a,i,sizeof(a))")
	call append(line("$"), "#define rep(i,n) for(int i = 0;i < n;i ++)")
	call append(line("$"), "")

	call append(line("$"), "int main() {")
	call append(line("$"), "    ios :: sync_with_stdio(false);")
	call append(line("$"), "    cout << fixed << setprecision(16);")
	call append(line("$"), "    return 0;")
	call append(line("$"), "}")
	call append(line("$"), "")
endfunc

" error color terminal
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline,bold gui=undercurl
hi clear QuickFixLine
hi QuickFixLine ctermfg=1 cterm=underline,bold gui=undercurl
" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" /20  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,/20,%,n~/.viminfo.go
" Linebreak on 100 characters
set lbr
set tw=100
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"nnoremap <space> / "will cost a lot problem
"nnoremap <c-space> ?
" Allow to copy/paste between VIM instances
"copy the current visual selection to ~/.vbuf, will copy complete line
vmap <leader>y :w! ~/.vbuf<cr>

"copy the current line to the buffer file if no visual selection
"nmap <leader>y :.w! ~/.vbuf<cr>

"paste the contents of the buffer file
nmap <leader>p :r ~/.vbuf<cr>
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
set backspace=2
nmap <leader>; mqA;<esc>`q"
"can't work
"map <leader>; :execute "normal! mqA;\<esc>`q"
