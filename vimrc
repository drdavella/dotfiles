" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
filetype off

set relativenumber

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Different indentation for yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/plugins')
Plugin 'VundleVim/Vundle.vim'

" Add all plugins here
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
"Plugin 'vim-syntastic/syntastic'
Plugin 'leafgarland/typescript-vim'
Plugin 'drdavella/gitgrep.vim'
" To use with coc-python:
" :CocInstall coc-python
" :CocConfig and add python.jediEnabled: false
Plugin 'neoclide/coc.nvim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'mustache/vim-mustache-handlebars'
" Plugin 'psf/black'
Plugin 'fatih/vim-go'
Plugin 'junegunn/fzf'
Plugin 'rakr/vim-two-firewatch'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'
Plugin 'vim-autoformat/vim-autoformat'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'ntpeters/vim-better-whitespace'
Bundle 'stephpy/vim-php-cs-fixer'
Plugin 'udalov/kotlin-vim'
Plugin 'vimwiki/vimwiki'
" For rust development
Plugin 'rust-lang/rust.vim'

" All plugins must be added before the following line
call vundle#end()

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Use smartcase when searching with super star also
:nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
:nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
" set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

let mapleader = " "
let maplocalleader = " "

" Tab navigation
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprevious<CR>
nnoremap ]T :tablast<CR>
nnoremap [T :tabfirst<CR>

" Buffer navigation
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap gn :bnext<CR>
nnoremap gp :bprevious<CR>
nnoremap gl :ls<CR>
nnoremap gb :ls<CR>:b
nnoremap gq :bd<CR>

" Command for copying to system clipboard
set clipboard=unnamed
map <leader>c "*y

"------------------------------------------------------------
hi def link whiteSpaceError Error
autocmd Syntax * syn match whiteSpaceError "\(\S\| \)\@<=\t\+"
autocmd Syntax * syn match whiteSpaceError "\s\+\%\#\@\<!$"
autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile

" Format C files
autocmd BufWrite **/php-agent/**/*.{c,h} :Autoformat
autocmd BufWrite **/php-agent/**/*.{c,h} :StripWhitespaceOnChangedLines

" Format PHP Files
autocmd BufWritePost **/php-agent/**/*.php silent! call PhpCsFixerFixFile()
let g:php_cs_fixer_path = 'vendor/bin/php-cs-fixer'
let g:php_cs_fixer_config_file = '.php-cs-fixer.dist.php'


" Show lines that are too long
"------------------------------------------------------------
autocmd Syntax * syn match Error /\%89v.\+/
set colorcolumn=88
set textwidth=87
autocmd FileType markdown setlocal textwidth=80
autocmd FileType rust setlocal colorcolumn=101
autocmd Syntax rust syn match Error /\%101v.\+/

" Set colorscheme and background color
"------------------------------------------------------------
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
set background=dark
"highlight Normal ctermfg=grey ctermbg=black

" Configuration for YouCompleteMe
"------------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g <C-]>

" Configuration for NERDTreeTabs
" -----------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
map ,n :NERDTreeFind<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

" Configuration for syntastic
"------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'

let g:syntastic_rst_checkers = []
let g:syntastic_c_checkers = []

let g:go_auto_type_info = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1

" Configuration for tags
"------------------------------------------------------------
set tags+=$HOME/php-src/tags

" Configuration for black
"------------------------------------------------------------
let g:black_virtualenv = '~/.vim/black'
autocmd BufWritePre $HOME/python-agent/*.py execute ':Black'

map <leader>c :SyntasticCheck<CR>
map <leader>f :SyntasticCheck flake8<CR>
map <leader>r :SyntasticReset<CR>:set statusline&vi<CR>

map <leader>p :execute GitGrep(expand("<cword>"))<CR>

" Configuration for Python navigation
"------------------------------------------------------------
" Use jedi-vim for code navigation, but not completion since we're using coc-python
let g:jedi#completions_enabled = 0
map <leader>o <C-O>

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Configuration for fzf
"------------------------------------------------------------
let $FZF_DEFAULT_COMMAND = "rg"
nmap ; :FZF<CR>

command Vimrc :e $HOME/.vimrc
command Source :source $HOME/.vimrc

" Configuration for rust
"------------------------------------------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
autocmd FileType rust vnoremap <buffer> gq :RustFmtRange<CR>
let g:rust_cargo_use_clippy = 1
