" 不与 vi 兼容
set nocompatible 

" 打开行号显示
set number

" 打开语法高亮
syntax on

" 底部显示当前模式
set showmode

" 显示输入的指令
set showcmd

" 支持鼠标
set mouse=a

" 使用 utf-8 编码
set encoding=utf-8

" 启用 256 色
set t_Co=256

" 启用文件类型检查
filetype indent on

" 自动缩进
set autoindent

" tab 对应空格数量
set tabstop=4

" 缩进对应字符数量
set shiftwidth=4

" 自动将 tab 转为空格
set expandtab

" 高亮当前行
set cursorline

" 设置行宽
set textwidth=80

" 自动换行
set wrap

" 禁止单词内部换行
set linebreak

" 设置换行边缘空白宽度
set wrapmargin=2

" 设置垂直滚动上下高度
set scrolloff=5

" 设置水平滚动两侧高度
set sidescrolloff=15

" 是否显示状态栏 
set laststatus=2

" 显示光标位置
set ruler

" 括号匹配
set showmatch

" 高亮搜索
set hlsearch

" 增量搜索
set incsearch

" 搜索忽略大小写
set ignorecase

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

" 显示行尾空格
set listchars=tab:»■,trail:■
set list

" 支持命令tab补全
set wildmenu
set wildmode=longest:list,full

