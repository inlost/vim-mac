 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"             inlost 的 Vim 配置文件
"
"         Author: sailflyer@gmail.com
"        Website: http://cloudlii.com/
"          Since: 2014-06-28
"  Last Modified: [2014.06.18 17:53:09@CST] inlost
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=====================
"   Vundle
"=====================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'othree/html5.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'burnettk/vim-angular'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'asins/vim-dict'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'vim-scripts/Marks-Browser'
Plugin 'stephenway/postcss.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'BufferExplorer'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if v:version < 700
    echoerr 'This _vimrc requires Vim 7 or later.'
    quit
endif

" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
    let l:c = 0
    while l:c<line("$") && (
                \ getline(l:c) =~ '^\s*$'
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
                \ )
        let l:c = l:c+1
    endwhile
    exe "normal ".l:c."Gz\<CR>"
endf

" 返回当前时期
func! GetDateStamp()
    return strftime('[%Y.%m.%d %H:%M:%S@%Z]')
endfunction

" 全选
func! SelectAll()
    let s:current = line('.')
    exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endfunc

" =====================
" 环境配置
" =====================
" 中文帮助
set helplang=cn

" 保留历史记录
set history=500

" 行控制
set linebreak " 英文单词在换行时不被截断
set nocompatible " 设置不兼容VI
"set textwidth=80 " 设置每行80个字符自动换行，加上换行符
set wrap " 设置自动折行

" 标签页
set tabpagemax=15 " 最多15个标签
set showtabline=1 " 有多个标签时才显示标签栏

" 关闭遇到错误时的声音提示
set noerrorbells
set novisualbell
set t_vb= " close visual bell

" 行号和标尺
set ruler " 显示标尺
set number " 行号

" 命令行于状态行
set cmdheight=1 " 设置命令行的高度
set laststatus=2 " 始终显示状态行

" 搜索
set hlsearch  " 高亮显示搜索的内容
set noincsearch " 关闭显示查找匹配过程
"set magic     " Set magic on, for regular expressions
"set showmatch " Show matching bracets when text indicator is over them
"set mat=2     " How many tenths of a second to blink

" 制表符(设置所有的tab和缩进为4个空格)
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " 不使用空格来替换tab
set smarttab

set linespace=0

" 状态栏显示目前所执行的指令
set showcmd

" 缩进
set autoindent " 设置自动缩进
set smartindent " 设置智能缩进

" 自动重新读入
set autoread " 当文件在外部被修改，自动更新该文件

" 设定在任何模式下鼠标都可用
set mouse=a

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 备份和缓存
set nobackup
set nowb
"set noswapfile

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu " 只在下拉菜单中显示匹配项目，并且会自动插入所有匹配项目的相同文本

" 代码折叠
set foldmethod=indent

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 显示tab和空格
set list
" 设置tab和空格样式
set listchars=tab:\|\ ,nbsp:%,trail:-

" 设定行首tab为灰色
highlight LeaderTab guifg=#666666
" 匹配行首tab
match LeaderTab /\t/

set wildmenu "打开 wildmenu 选项，启动具有菜单项提示的命令行自动完成。
set matchpairs=(:),{:},[:],<:>
set whichwrap=b,s,<,>,[,]

"光标可以定位在没有实际字符的地方
set ve=block

" 启动后自动全屏
"set fullscreen

" 搜索时无视大小写
set ignorecase

if has("gui_running")
    " Turn undofile on
    set undofile
    " Set undofile path
    set undodir=~/tmp/vim/undofile/
endif

" Set hidden to undo buffer
set hidden

"cliboard seting
set clipboard+=unnamed " set clipboard

let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8/bin/ctags"

" =====================
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8

    if has('win32')
        language english
        let &termencoding=&encoding " 处理consle输出乱码
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =====================
" 图形界面
" =====================
if has('gui_running')
    "set guioptions=mcr " 只显示菜单
    set guioptions=   " 隐藏全部的gui选项
    "set guioptions+=r " 显示gui右边滚动条
    "Toggle Menu and Toolbar 使用F2隐藏/显示菜单
    "set guioptions-showtabline=m
    set guioptions-=T
    map <silent> <F3> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>

    if has('gui_macvim')
        set guioptions+=e
    endif

    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim

        " F11 最大化
        "map <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>
        au GUIEnter * simalt ~x
        " 字体配置
        "exec 'set guifont='.iconv('Courier_New', &enc, 'gbk').':h10:cANSI'
        "exec 'set guifontwide='.iconv('微软雅黑', &enc, 'gbk').':h10'
        set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI
    endif

    if has("unix") && !has('gui_macvim')
        set guifont=Courier\ 11\ Pitch\ 12
    endif

    if has("mac") || has("gui_macvim")
        if has("gui_macvim")
            " 开启抗锯齿渲染
            set anti
            " MacVim 下的字体配置
            set guifont=Source\ Code\ Pro:h18
            set guifontwide=Source\ Code\ Pro:h18

            "set transparency=8
            set lines=222 columns=222

            " 使用 MacVim 原生的全屏幕功能
            let s:lines=&lines
            let s:columns=&columns
            func! FullScreenEnter()
                set lines=999 columns=999
                set fu
            endf

            func! FullScreenLeave()
                let &lines=s:lines
                let &columns=s:columns
                set nofu
            endf

            func! FullScreenToggle()
                if &fullscreen
                    call FullScreenLeave()
                else
                    call FullScreenEnter()
                endif
            endf
        endif
    endif
endif


"去除当前所编辑文件的路径信息，只保留文件名
set guitablabel=%{ShortTabLabel()}
function ShortTabLabel()
    let bufnrlist = tabpagebuflist(v:lnum)
    let label = bufname(bufnrlist[tabpagewinnr(v:lnum) -1])
    let filename = fnamemodify(label, ':t')
    return filename
endfunction


" =====================
" 主题配色
" =====================
if has('syntax')
    " 保证语法高亮
    syntax enable

    set background=light
    colorscheme solarized

    " 默认编辑器配色
    " au BufNewFile,BufRead,BufEnter,WinEnter * colo yytextmate

    " 各不同类型的文件配色不同
    "au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo moria
endif

"Highlight current
if has("gui_running")
    set cursorline
    set cursorcolumn
    "hi cursorline guibg=#0D142C
    "hi cursorline guibg=#E8E9E8
    "hi CursorColumn guibg=#FCF5C9
    "hi CursorColumn guibg=#E8E9E8
endif

if has('multi_byte_ime')
    "未开启IME时光标背景色
    hi Cursor guifg=bg guibg=Orange gui=NONE
    "开启IME时光标背景色
    hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
    " 关闭Vim的自动切换IME输入法(插入模式和检索模式)
    set iminsert=0 imsearch=0
endif

" =====================
" AutoCmd 自动运行
" =====================
if has("autocmd")
    filetype plugin indent on " 打开文件类型检测

    "根据当前buffer切换到该文件所在工作目录
    autocmd BufRead * :lcd! %:p:h

    augroup vimrcEx " 记住上次文件位置
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
    augroup END

    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1

    " 格式化 JavaScript 文件
    au FileType javascript map <leader>jb :call g:Jsbeautify()<cr>
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    " CSS 语法支持
    au BufRead,BufNewFile *.css,*.less,*.scss,*.wxss set filetype=css

    "art 高亮支持
    au BufRead,BufNewFile *.art,*.vue,*.wxml set filetype=html

    " 增加 Objective-C 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.m,*.h setf objc

    " 将指定文件的换行符转换成 UNIX 格式
    au FileType php,javascript,html,css,python,vim set ff=unix
endif

" 自动载入VIM配置文件
autocmd! bufwritepost vimrc source $MYVIMRC

" 关闭VIM的时候保存会话，按F7读取会话
"set sessionoptions=buffers,sesdir,help,tabpages,winsize
"echo has('signs')au VimLeave * mks! ~/.vim/Session.vim
"nmap <F7> :so ~/.vim/Session.vim<CR>


" =====================
" 快捷键
" =====================
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-B> <Left>

"设置','为leader快捷键
let mapleader = ","
let g:mapleader = ","

"设置快速保存和退出
"快速保存为,s
"快速退出（保存）为,w
"快速退出（不保存）为,q
nmap <leader>w :wqa!<cr>
nmap <leader>q :qa!<cr>
nmap <Leader>n :nohlsearch<cr>
nmap <Leader>s :! 

"切换buffer
nmap bn :bn<cr>
nmap bp :bp<cr>

" 插件快捷键
nmap <C-v> :NERDTree<cr>
nmap <C-e> :BufExplorer<cr>

" 直接查看第一行生效的代码
nmap <C-g><C-f> :call GotoFirstEffectiveLine()<cr>

" 按下 Q 不进入 Ex 模式，而是退出
nmap Q :x<cr>

"Use spacebar toggle fold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"关闭自动检测编码用F6控制(fencview.vim)
let g:fencview_autodetect=0
map <F6> :FencView<cr>

" 快速修改 vimrc 文件
if has("win32")
    map <silent> <leader>ee :e $VIM/_vimrc<cr>
    map <silent> <leader>rc :source $VIM/_vimrc<cr> " 快速载入 vimrc 文件
else
    map <silent> <leader>ee :e ~/.vim/vimrc<cr>
    map <silent> <leader>rc :source ~/.vim/vimrc<cr> " 快速载入 vimrc 文件
endif

" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" 搭配minibuffer切换buffer
noremap <leader><leader> <C-^>

" 基本完美解决buffer切换，用buffer号加B 键
function! BufPos_ActivateBuffer(num)
    if a:num == 0
        echo "No buffer " . a:num "!"
        return
    endif
    if a:num > bufnr("$")
        echo "No buffer " . a:num "!"
    else
        if buflisted(a:num) && getbufvar(a:num, "&modifiable")
            exe "buffer " . a:num
        endif
    endif
endfunction
nmap <leader>b :<C-U>call BufPos_ActivateBuffer(v:count)<CR>


" =====================
" 插件配置
" =====================

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let tlist_html_settings = 'html;h:Headers;o:Objects(ID);c:Classes'
let tlist_xhtml_settings = 'html;h:Headers;o:Objects(ID);c:Classes'

" markbrowser setting
nmap <silent> <leader>bm :MarksBrowser<cr>

"zenCoding
let g:user_zen_mode='inv'

"jsDoc
nmap <silent> <C-l> <Plug>(jsdoc)
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_input_description=1

"vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline_theme='solarized'

"对NERD_commenter的设置
let NERDShutUp=1
"支持单行和多行的选择，//格式
map <c-h> ,c<space>

let g:neocomplcache_min_syntax_length = 3

"Tagbar
nmap <leader>tg :TagbarToggle<CR>
"CtrlP
nmap <leader>of :CtrlP<CR>

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'
" 是否在打开文件时检查
let g:syntastic_check_on_open=1
" 是否在保存文件后检查
let g:syntastic_check_on_wq=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:syntastic_html_tidy_exec = 'tidy5'

"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }


" Under the Mac(MacVim)
if has("gui_macvim")
    " Mac 下，按 \f 切换全屏
    map <Leader>f :call FullScreenToggle()<cr>

    " I like TCSH :^)
    set shell=/bin/tcsh

    " Set input method off
    set imdisable

    " 如果为空文件，则自动设置当前目录为桌面
    "lcd ~/Desktop/
endif

" on Windows, default charset is gbk
if has("win32")
    let g:fontsize#encoding = "cp936"
endif
    " 增加 Objective-C 语法支持

