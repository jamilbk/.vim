" better plugin management
call pathogen#infect()

set tabpagemax=50
set sidescroll=1
set sidescrolloff=10
set backspace=indent,eol,start " fixes issue with compiled 7.3 not backspacing properly
set nocompatible
set number
set ruler
set wildmode=list:longest,full
set showmode
set history=50
set nomodeline
set nowrap
set shiftwidth=2
set shiftround
set expandtab
set tabstop=2
filetype on
filetype plugin indent on
syntax enable
autocmd FileType html set formatoptions+=t1
set ignorecase
set smartcase
set incsearch

" used to map Space bar as fold key
set foldmethod=syntax
set foldlevel=99 " files open with no folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" shows TODOs in project
map <F4> :grep TODO -r app/ test/ config/ db/ lib/

" similar to cmd-T in textmate (uses fuzzyfinder plugin)
map <F5> :FufFile **/<CR>

" NERDTree shortcut
map <F6> :NERDTreeToggle<CR>


" used to save viewstate, but conflicts with rails.vim
" au BufWinLeave * silent! mkview
" au BufWinEnter * silent! loadview
"
