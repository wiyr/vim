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
inoremap jk <Esc>
nmap ; :
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
autocmd BufWrite *.tsx,*.vimrc,*.md :call DeleteTrailingWS()
autocmd BufWrite *.py :call DeleteTrailingWS()
" Allow to copy/paste between VIM instances
"copy the current visual selection to ~/.vbuf, will copy complete line
vmap <leader>y :w! ~/.vbuf<cr>

"paste the contents of the buffer file
nmap <leader>p :r ~/.vbuf<cr>

" Useful mappings for managing tabs
nnoremap <m-t> :tabnew<cr>
nnoremap <leader>w :tabclose<cr>
nnoremap <leader><tab> :tabnext<cr>
nnoremap <leader><s-tab> :tabprevious<cr>

vmap // y/\V<C-R>"<CR>

"}}}

"插件配置 {{{



" 插件管理工具
call plug#begin('~/.vim/plugged')

" 注释工具
Plug 'scrooloose/nerdcommenter', { 'commit': '9a32fd25344' }


" 快速找到头文件
Plug 'vim-scripts/a.vim'

"vim方式的文件树
Plug 'justinmk/vim-dirvish'

" git命令
Plug 'tpope/vim-fugitive', { 'commit': 'c118dabb8' }

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

" 多光标
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<ESC>'
function! Multiple_cursors_before()
	"set foldmethod=manual
    "let s:old_ycm_whitelist = g:ycm_filetype_whitelist
    "let g:ycm_filetype_whitelist = {}
    "call youcompleteme#DisableCursorMovedAutocommands()
endfunction

function! Multiple_cursors_after()
    "set foldmethod=marker
    "let g:ycm_filetype_whitelist = s:old_ycm_whitelist
    "call youcompleteme#EnableCursorMovedAutocommands()
endfunction

" 快速搜索
Plug 'mileszs/ack.vim'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" 文件查找
Plug 'Yggdroot/LeaderF', { 'commit':'da43974f3d5', 'do': './install.sh' }
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
Plug 'Valloric/YouCompleteMe', { 'commit': 'e1ead995', 'do': './install.py --all' }
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"display keywords of the programming language
let g:ycm_seed_identifiers_with_syntax = 1
" trigger ycm syntastic check
let g:ycm_show_diagnostics_ui = 0
" enable ycm work in comments
let g:ycm_complete_in_comments = 1
nnoremap gt :YcmCompleter GoToDefinition<CR>
 " disable preview
let g:ycm_add_preview_to_completeopt = 0
set completeopt=menu,menuone
" trigger complete
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 代码对齐线 && better json
Plug 'Yggdroot/indentLine', { 'commit': '4e4964d148f' }
let g:indentLine_char = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_color_term = 243
let g:indentLine_leadingSpaceChar = '·'
" for remove json display in indentLine plug
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" 自动生成tag
Plug 'ludovicchabant/vim-gutentags', {'commit' : 'b1eb744786'}
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" FIXME
let s:vim_tags = expand('/mnt/ficusbelgium/yxwang/.cache/tags')
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

" 增强状态栏
Plug 'vim-airline/vim-airline', { 'commit': 'ada0ba8ae3eea778d165ec4794ee557df98fab87' }
Plug 'vim-airline/vim-airline-themes', { 'commit': '3bfe1d00d48f7c35b7c0dd7af86229c9e63e14a9'}
let g:airline_left_sep=''
let g:airline_right_sep=''

" hi for cpp such as class, template, function name
Plug 'octol/vim-cpp-enhanced-highlight'

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

" 高亮查询
Plug 'haya14busa/incsearch.vim'
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)N
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

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
set noswapfile
"shiftwidth tabstop number nobackup autoindent cindent
syn on
set foldmethod=marker
colo desert256
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=NONE guifg=NONE
"hi CursorLine term=bold cterm=bold guibg=Grey40
hi Normal  ctermfg=252 ctermbg=none
hi ColorColumn ctermbg=8

" error color terminal
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline,bold gui=undercurl
hi clear QuickFixLine
hi QuickFixLine ctermfg=1 cterm=underline,bold gui=undercurl
" highlight trailing space
hi ExtraWhitespace ctermbg=red guibg=red
"修改补全弹出框颜色
hi PMenu ctermfg=0 ctermbg=64 guifg=black guibg=darkgrey
hi PMenuSel ctermfg=64 ctermbg=8 guifg=darkgrey guibg=black
set viminfo='20,\"50,:20,/20,%,n~/.viminfo.go
" }}}

" 其他配置 {{{
au BufNewFile,BufRead SCon* set filetype=python
au BufNewFile,BufRead *.conf set filetype=txt
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * match ExtraWhitespace /\s\+$/
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
