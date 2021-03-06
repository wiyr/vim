" 快捷键绑定 {{{
"inoremap <esc> <nop> set previewheight=7 set nocompatible
let mapleader = ','
let localleader = '\\'
au filetype c,cpp set makeprg=g++\ -std=c++11\ %\ -w\ -O2\ -o\ %<
au filetype c,cpp map <F5> :w<CR>:make<CR>
au filetype c,cpp map <F6> :! ./%< <input.txt  <CR>
au filetype java map<F5> :w<CR> :!javac %<CR>
au filetype java map<F6> :!java %< <input.txt <CR>
au FileType python map<F5> :w<CR> :AsyncRun! -raw python %<CR>
au Filetype sh map<F5> :w<CR> :AsyncRun! -raw bash %<CR>
au FileType python nmap<leader>rr :w<CR> :AsyncRun! -raw python %

"set tags=./tags;,tags,~/.vimtags
set mouse=a
nmap <silent> <leader>v :e ~/.vimrc<cr>
nmap <silent> <leader>s :source ~/.vimrc<cr>:echom 'reload vimrc!'<cr>
nmap <silent> <leader><leader>p :setlocal paste!<cr>
" conflict with some plugin
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
inoremap <C-h> <left>
inoremap <C-l> <right>
nmap <m-l> :vertical res +
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
nmap ; :
"remove ^M
nnoremap <leader>cmm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" ^M to \n
"nnoremap <leader>cmm :%s/<C-v><C-M>/<C-v><cr>/g<CR>
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
autocmd BufWrite *.tsx,*.cpp,*.vimrc,*.md :call DeleteTrailingWS()
autocmd BufWrite *.py,*.h :call DeleteTrailingWS()
" Allow to copy/paste between VIM instances
"copy the current visual selection to ~/.vbuf, will copy complete line
vmap <leader>y :w! ~/.vbuf<cr>

"paste the contents of the buffer file
nmap <leader>p :r ~/.vbuf<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
nmap <leader>; mqA;<esc>`q"
"vmap <silent> * :call VisualSearch('f')<CR>
"vmap <silent> # :call VisualSearch('b')<CR>
vmap <silent> gv :call VisualSearch('gv')<CR>
vmap // y/\V<C-R>"<CR>

" 查找/搜索
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . ""
	elseif a:direction == 'gv'
		execute "Ack! " . l:pattern . ""
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . ""
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"}}}

"插件配置 {{{



" 插件管理工具
call plug#begin('~/.vim/plugged')

"
Plug 'benmills/vimux'

Plug 'tpope/vim-unimpaired'

" 重复上一个操作
Plug 'tpope/vim-repeat'

" 快速找到头文件
Plug 'vim-scripts/a.vim'

"vim方式的文件树
Plug 'justinmk/vim-dirvish'

augroup dirvish_config
  autocmd!

  " Map `t` to open in new tab.
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 7 :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 8 :call dirvish#open('split', 0)<CR>
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> 9 :call dirvish#open('vsplit', 0)<CR>

  " Map `gr` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gr :<C-U>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>
augroup END

"Read-Eval-Print Loop
Plug 'sillybun/vim-repl/'
nnoremap <m-r> :REPLToggle<Cr>
let g:sendtorepl_invoke_key = "<leader>w"
let g:repl_program = {
            \   "python": "python",
            \   "default": "zsh"
            \   }

"
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" 多光标
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<ESC>'


" 代码域选择
"Plug 'terryma/vim-expand-region'
"nmap <Up> <Plug>(expand_region_expand)
"nmap <Down> <Plug>(expand_region_shrink)

" 快速搜索
Plug 'mileszs/ack.vim'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" 文件查找
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<m-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <leader>o :LeaderfMru<cr>
noremap <m-f> :LeaderfFunction!<cr>
noremap <m-b> :LeaderfBuffer<cr>
"let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

"代码补全
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"display keywords of the programming language
let g:ycm_seed_identifiers_with_syntax = 1
" trigger ycm syntastic check
let g:ycm_show_diagnostics_ui = 1
" enable ycm work in comments
let g:ycm_complete_in_comments = 1
nnoremap gt :YcmCompleter GoToDefinition<CR>
" it seems open much useless words
"let g:ycm_semantic_triggers =  {
            "\ 'c,cpp,python,java,go': ['re!\w{2}'],
            "\ }

 " disable preview
let g:ycm_add_preview_to_completeopt = 0
set completeopt=menu,menuone
" trigger complete
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 代码对齐线
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239

" 自动生成tag
Plug 'ludovicchabant/vim-gutentags'
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_define_advanced_commands = 1
let g:gutentags_enabled = 0
nmap <leader>t :GutentagsToggleEnabled<CR>

function! s:get_gutentags_status(mods) abort
	let l:msg = ''
	if index(a:mods, 'ctags') > 0
	   let l:msg .= '♨'
	 endif
	 if index(a:mods, 'cscope') > 0
	   let l:msg .= '♺'
	 endif
	 return l:msg
endfunction

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 异步运行命令
Plug 'skywind3000/asyncrun.vim'
" automatically open quickfix window when AsyncRun command is executed
" set the quickfix window 6 lines height.
let g:asyncrun_open = 15
let $PYTHONUNBUFFERED=1
nmap <leader>tt :AsyncStop!<CR>
" ring the bell to notify you job finished
let g:asyncrun_bell = 1
au FileType c,cpp map <F4> :w<CR> :AsyncRun scons -uj8 <CR>

" 文件列表
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"let NERDTreeShowBookmarks=1
" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store', '\.o']
let NERDTreeShowHidden=1
map <leader>n :NERDTreeToggle<CR>
au filetype nerdtree nnoremap bk :Bookmark<CR>
au filetype nerdtree nnoremap cm :ClearBookmarks<CR>
au filetype nerdtree nnoremap ca :ClearAllBookmarks<CR>
":NERDTreeMirror<CR>
"open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endi
""close vim if the only window left open is a NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" git状态文件列表栏
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }

" 代码片段
" Track the engine.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
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
Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>m :Tagbar<CR>

" go语言工具
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
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


" git命令
Plug 'tpope/vim-fugitive'
" git状态侧边栏
Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_escape_grep = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '~-'
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" 快速移动
Plug 'easymotion/vim-easymotion'
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" 高亮查询
Plug 'haya14busa/incsearch.vim'
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" 增强状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep=''
let g:airline_right_sep=''

" color配色
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'danilo-augusto/vim-afterglow'
Plug 'flazz/vim-colorschemes'
" hi for cpp such as class, template, function name
Plug 'octol/vim-cpp-enhanced-highlight'

" 注释工具
Plug 'scrooloose/nerdcommenter'

" typescript高亮
Plug 'leafgarland/typescript-vim'
"it works pretty well but there are cases where it fails.
let g:typescript_indent_disable = 1

"Vim indenter for standalone and embedded JavaScript and TypeScript.
Plug 'jason0x43/vim-js-indent'

Plug 'Quramy/tsuquyomi'
"use syntastic check
let g:tsuquyomi_disable_quickfix = 1

" 代码格式化
Plug 'Chiel92/vim-autoformat'
let verbose=1
"let g:formatdef_my_cpp='"astyle --style=java"'
"let g:formatters_cpp=['my_cpp']
"sudo pip install --upgrade autopep8
let g:formatters_py=['yapf']
"Plug 'google/yapf', { 'rtp': 'plugins/vim' }

"Plug 'nvie/vim-flake8'
"let g:flake8_show_in_file=1
"let g:flake8_show_in_gutter=1  " show
"autocmd BufWritePost *.py call Flake8()
"" to use colors defined in the colorscheme

" 代码语法检查
Plug 'w0rp/ale'
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
nmap <m-j> :ALEToggle<CR>
nmap <Leader>d :ALEDetail<CR>
let b:ale_linters = {
            \'cpp': ['clang'],
            \'c': ['clang'],
            \'python':['flake8']
            \}



" 代码风格检查
"Plug 'scrooloose/syntastic'

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%{gutentags#statusline_cb(function('<SID>get_gutentags_status'))}
"set statusline+=%{gutentags#statusline()}
"set statusline+=%*

"let g:syntastic_check_on_open=1
"let g:syntastic_auto_jump=0
"let g:syntastic_php_checkers=['php', 'phpcs']
"let g:syntastic_python_checkers=[]
"let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint'] " You shouldn't use 'tsc' checker.
"let g:syntastic_c_checkers=[]
"let g:syntastic_cpp_checkers=[]
""let g:syntastic_java_checkers=['checkstyle', 'javac']
""YCM required
"let g:syntastic_java_checkers = []
"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
""let g:syntastic_reuse_loc_lists = 0
""let g:syntastic_go_checkers=['govet', 'golint', 'gometalinter']
""let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
""let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
""let g:syntastic_debug = 3
"nnoremap <leader>j :call ChangeJump()<CR>

"function! ChangeJump()
   "let g:syntastic_auto_jump= 1 - g:syntastic_auto_jump
    "if len(g:syntastic_python_checkers)
        "let g:syntastic_python_checkers=[]
    "else
        "let g:syntastic_python_checkers=['flake8']
    "endif
"endfunction

" 文本编写环境
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" confict with nnoremap <C-J> <C-W>j
"Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'


" python环境
Plug 'python-mode/python-mode'
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_rope_autoimport = 0
"use ycm
let g:pymode_rope_completion = 0
let g:pymode_lint = 0
let g:pymode_syntax = 0
let g:pymode_options_max_line_length = 120

call plug#end()
"}}}

" 环境变量 {{{

filetype plugin indent on
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Turn on the WiLd menu
set wildmenu
set backspace=2
set sw=4 ts=4 nu nobk ai cin
set expandtab
set encoding=utf-8
set fileencoding=utf-8
"shiftwidth tabstop number nobackup autoindent cindent
syn on
set foldmethod=marker
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
colo desert256
"colo afterglow
"colo tango
"let g:bg_tango = 1
"colo spacegray
"colo cobalt2
" highlight row
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=NONE guifg=NONE
hi Normal  ctermfg=252 ctermbg=none
hi ColorColumn ctermbg=8

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
set noswapfile
" error color terminal
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline,bold gui=undercurl
hi clear QuickFixLine
hi QuickFixLine ctermfg=1 cterm=underline,bold gui=undercurl
" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" /20  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,/20,%,n~/.viminfo.go
" }}}

" 其他配置 {{{
au BufNewFile,BufRead SCon* set filetype=python
au BufNewFile,BufRead Jenkins* set filetype=groovy
au BufNewFile,BufRead *.conf set filetype=json
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
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

" Cscope代码索引
if has("cscope")
    set nocscopetag
    set cscopetagorder=1
    set nocscopeverbose
    let cscope_out=findfile("cscope.out", ".;")
    let cscope_pre=matchstr(cscope_out, ".*/")
    if !empty(cscope_out) && filereadable(cscope_out)
        execute 'cs add' cscope_out cscope_pre
    endif

    nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)
" }}}
