" Make Vim more useful
set nocompatible
set backspace=2

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu
set wildmode=longest:list,full

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Change mapleader
let mapleader=","

" Don’t add empty newlines at the end of files
set binary
set noeol

" Respect modeline in files
set modeline
set modelines=4

" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Make tabs as wide as two spaces
set tabstop=4

" Show “invisible” characters
set listchars=tab:▸\ ,trail:·,nbsp:_
set list

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" Enable mouse in all modes
set mouse=a

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" enable 256 color mode
set t_Co=256

" 启用文件类型检查
filetype indent on

" 自动缩进
set autoindent

" 设置行宽
set textwidth=80

" 自动换行
set wrap

" 禁止单词内部换行
set linebreak

" 设置换行边缘空白宽度
set wrapmargin=2

" 设置水平滚动两侧高度
set sidescrolloff=15

" 括号匹配
set showmatch

" 禁止备份文件
set nobackup

" 禁止缓存文件
set noswapfile

" 禁止错误响铃
set noerrorbells

" 错误闪烁
set visualbell

" 记忆历史操作次数
set history=1000

" 监视文件外部修改
set autoread

" For vim-plug
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'kien/ctrlp.vim'
call plug#end()

" For NERDCommenter
let g:NERDSpaceDelims = 1

" My scripts
function! CommentHide()
	:highlight Comment guifg=bg ctermfg=black
endfunction
noremap <leader>hh :call CommentHide()<CR>

function! CommentFold()
	:set fdm=expr
	:set fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
	:highlight Folded ctermbg=none ctermfg=black
endfunction
noremap <leader>ff :call CommentFold()<CR>
