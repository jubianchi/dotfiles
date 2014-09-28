""
"" Vundle
""
set rtp+=$DOTFILES/.vim/bundle/vundle/
call vundle#rc()

""
"" Bundles
""
Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'madflow/vim-php'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'airblade/vim-gitgutter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'vim-scripts/taglist.vim'

""
"" Options
""
"" set guifont=Source\ Code\ Pro\ for\ Powerline:h12
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac,dos
set ts=4 sw=4 noet
set nocompatible
set number
set mouse=a
set backspace=2
let mapleader = ","

set list
set listchars=eol:↩,tab:→\ ,trail:␣,nbsp:•,precedes:<,extends:>
augroup chars_style
	autocmd!
	autocmd VimEnter,Colorscheme * :highlight ExtraWhitespace ctermbg=160 guibg=#d70000
	autocmd VimEnter,Colorscheme * :match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * :match ExtraWhitespace /\s\+$/
	autocmd InsertLeave * :match ExtraWhitespace /\s\+$/
augroup END

filetype plugin indent on

""
"" Syntax
""
syntax enable

""
"" PHP
""
let php_folding=1
let php_sql_query=1
let php_htmlInStrings=1


""
"" Indent
""
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
augroup indent_style
	autocmd VimEnter * :IndentGuidesEnable
	autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd  ctermbg=234
	autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermbg=235
augroup END

""
"" Airline
""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_b = airline#section#create(['hunks'])
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

""
"" Solarized
""
set cursorline
set background=dark
let g:solarized_visibility="high"
colorscheme solarized

""
"" Git
""
let g:gitgutter_enabled=1
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_modified_removed='-~'
augroup gitgutter_style
	autocmd!
	autocmd VimEnter,Colorscheme * :highlight SignColumn ctermfg=8 ctermbg=0 guifg=#000000 guibg=#073642
	autocmd VimEnter,Colorscheme * :highlight GitGutterAdd ctermfg=64 ctermbg=0 guifg=#5f8700 guibg=#073642
	autocmd VimEnter,Colorscheme * :highlight GitGutterDelete ctermfg=160 ctermbg=0 guifg=#d70000 guibg=#073642
	autocmd VimEnter,Colorscheme * :highlight GitGutterChange ctermfg=136 ctermbg=0 guifg=#af8700 guibg=#073642
	autocmd VimEnter,Colorscheme * :highlight GitGutterChangeDelete ctermfg=160 ctermbg=0 guifg=#d70000 guibg=#073642
augroup END

""
"" Tags
""
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'


""
"" EasyMotion
""
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

""
"" Mappings
""
map <C-n> :next<CR>
map <C-p> :prev<CR>
