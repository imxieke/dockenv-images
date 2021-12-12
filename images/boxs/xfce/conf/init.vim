syntax on                                       " enable syntax  highlighting
set hidden                                      " Required for operations modifying multiple buffers like rename.

" 启用主题
set background=dark
" colorscheme palenight
" colorscheme hyper
" colorscheme wombat
" colorscheme zacks
colorscheme Base4Tone_Classic_A_Dark

filetype plugin indent on                       " enable indentations
set list
set modeline
set mouse=a                                     " enable mouse interaction
set incsearch ignorecase smartcase hlsearch     " highlight text while searching

set number                                      " 显示行号

set ruler
set wrap                                        " wrap text 自动折行
set nobackup                                    " 设置取消备份 禁止临时文件生成
set fenc=utf-8                                  " 文件编码
set encoding=utf-8
set cursorline                                  " 突出显示当前行
set cursorcolumn                                " 突出显示当前列

set laststatus=2
" set noshowmode                                " 不显示运行模式
set ignorecase
set smartcase
set autoindent smartindent                      " enable indentation
set tabstop=4
set shiftwidth=4
set emoji                                       " enable emojis
set history=1000                                " history limit
set title                                       " tab title as file name
