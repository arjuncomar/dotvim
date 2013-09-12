call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

colo wombat
filetype off
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
set pastetoggle=<F3>
nnoremap <F3> :set invpaste<CR>

let g:ctags_statusline=1
let generate_tags=1

let Tlist_Use_Horiz_Window=0

nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
map <F5> :TlistAddFiles src/*.cpp include/*.h ../include/*.h ../src/*.cpp *.cpp *.h<CR>

let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_close = 1

let g:alternateNoDefaultAlternate = 1
let g:alternateRelativeFiles = 1

let mapleader=","
filetype on
filetype plugin on
filetype indent on
syntax on
set autowrite
set ruler

set showcmd
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set smartindent
set autoindent
set laststatus=2
set wrap
set textwidth=79
set formatoptions=qrn1
set incsearch
set hlsearch
set ignorecase
set smartcase
set foldenable
set mousehide
set mouse=a


set foldmethod=syntax
nnoremap <leader>o zo
nnoremap <leader>a za
nnoremap <leader>c zc
nnoremap <leader>m zM
nnoremap <leader>r zR
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap d<leader>^ maj^mb`ad`b
nnoremap d<leader>g^ mak^mb`ad`b
nnoremap d<leader>$ mak$mb`ad`b
nnoremap d<leader>g$ maj$mb`ad`b

set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help
nmap <leader>ev :tabedit $MYVIMRC<cr>
autocmd BufEnter * cd %:p:h
set wildmenu
set wildmode=list:longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

if has("autocmd")
	augroup myvimrchooks
	au!
	autocmd bufwritepost .vimrc source ~/.vimrc
	augroup END
endif

nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <silent> <A-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-right> :execute 'silent! tabmove ' . tabpagenr()<CR>
let clojure#HighlightBuiltins = 1
let clojure#ParenRainbow = 1

" Let's remember some things, like where the .vim folder is.
 if has("win32") || has("win64")
     let windows=1
     let vimfiles=$HOME . "/vimfiles"
     let sep=";"
else
     let windows=0
     let vimfiles=$HOME . "/.vim"
     let sep=":"
endif

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/cv

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F12> :set tags+=./tags;/home/arjun<CR>

 "OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "cv"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

function! s:find_basedir() "{{{
" search Cabal file
  if !exists('b:ghcmod_basedir')
    let l:ghcmod_basedir = expand('%:p:h')
    let l:dir = l:ghcmod_basedir
    for _ in range(6)
      if !empty(glob(l:dir . '/*.cabal', 0))
        let l:ghcmod_basedir = l:dir
        break
      endif
      let l:dir = fnamemodify(l:dir, ':h')
    endfor
    let b:ghcmod_basedir = l:ghcmod_basedir
  endif
  return b:ghcmod_basedir
endfunction "}}}

" use ghc functionality for haskell files
let sandbox_dir = '/.cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d'
let g:ghc="/usr/bin/ghc"
augroup filetype_hs
    autocmd!
    autocmd Bufenter *.hs compiler ghc
    autocmd Bufenter *.hs let b:ghc_staticoptions = '-package-db ' . s:find_basedir() . sandbox_dir
augroup END
let g:haddock_browser = "/usr/bin/firefox-aurora"
let g:GHCStaticOptions = "-O2"
let g:haskell_jmacro        = 0

let g:ghcmod_ghc_options = ['-package-db ' . dir]
hi ghcmodType ctermbg=yellow
let g:ghcmod_type_highlight = 'ghcmodType'

nnoremap <leader>d [i
inoremap <leader>c <C-n>
nmap <leader>R :GHCReload<CR>
nmap <leader>i _i
nmap <leader>hh _?
nmap <leader>hs _?1
nmap <leader>e _t
nmap <leader>ie _ie
nmap <leader>g :make<CR>
nmap <leader>G :! cabal repl 

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
