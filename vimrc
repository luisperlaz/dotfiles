set background=dark

" Setup language {{{ ==========================================================

" language en_US.UTF-8           " Solve some plugins incompatibilities

" }}}

" NEOBUNDLE {{{ ===============================================================

set nocompatible             " No to the total compatibility with the ancient vi

" NeoBundle auto-installation and setup {{{

" Auto installing NeoBundle
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif


" Call NeoBundle
if has('vim_starting')
    set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand($HOME.'/.vim/bundle/'))

" is better if NeoBundle rules NeoBundle (needed!)
NeoBundle 'Shougo/neobundle.vim'
" }}}

" BUNDLES (plugins administrated by NeoBundle) {{{

"NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'wincent/command-t'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundleLazy 'bchallenor/scala-dist-vim', { 'autoload' : { 'filetypes' : 'scala'}}

" GUI {{{

" A better looking status line
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'edkolev/tmuxline.vim'
" easily window resizing
" NeoBundle 'jimsei/winresizer'
"
NeoBundle 'jacoborus/tender.vim'

" }}}

" Syntax {{{

"NeoBundle 'scrooloose/syntastic'
NeoBundle 'w0rp/ale'
"
" }}}

" Code Snippets {{{
"
" Powerful and advanced Snippets tool
NeoBundle 'SirVer/ultisnips'
" Snippets for Ultisnips
NeoBundle 'honza/vim-snippets'
"
" }}}

" fuzzy finder {{{
"
NeoBundle 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
"
" }}}

" tmux {{{

NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'benmills/vimux'
"
" }}}
"
" fugitive {{{

NeoBundle 'tpope/vim-fugitive.git'

" }}}
"
"

" PO.vim {{{

NeoBundle 'vim-scripts/po.vim--gray'

" }}}

" END BUNDLES }}}

" Auto install the plugins {{{

" First-time plugins installation
if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :NeoBundleInstall
endif

" Check if all of the plugins are already installed, in other case ask if we
" want to install them (useful to add plugins in the .vimrc)
NeoBundleCheck

" }}}

filetype plugin indent on      " Indent and plugins by filetype

" END NEOBUNDLE }}}



" pymode {{{
" Don't autofold code
let g:pymode_folding = 0
" let jedi-vim do python autocompletion
let g:pymode_rope = 0
" }}}


" VIM Setup {{{ ===============================================================

" Common key mappings {{{
:nnoremap <F9> :previous<CR>
:nnoremap <F12> :next<CR>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" }}}

" To review: ruby and groovy support {{{
":autocmd BufReadPost buildfile set syntax=ruby
":autocmd BufReadPost *.groovy set syntax=groovy

"if did_filetype()
"	finish
"endif
"if getline(1) =~ '^#!.*[/\\]groovy\>'
"	setf groovy
"endif 
" }}}

" <Leader> & <LocalLeader> mapping {{{

let mapleader=','
let maplocalleader= ' '

" }}}

" Basic options {{{

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible
set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
set go+=rRlLbh                  " show all the scrollbars
set go-=rRlLbh                  " hide all the scrollbars
set visualbell                  " turn on the visual bell
"set cursorline                  " highlight the line under the cursor
set fillchars+=vert:│           " better looking for windows separator
set ttyfast                     " better screen redraw
"set title                       " set the terminal title to the current file
set showcmd                     " shows partial commands
set hidden                      " hide the inactive buffers
set ruler                       " sets a permanent rule
set lazyredraw                  " only redraws if it is needed
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly
set backspace=indent,eol,start  " defines the backspace key behavior
set virtualedit=all             " to edit where there is no actual character

" }}}

" Searching {{{

set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
"set smartcase                   " smart case ignore
"set ignorecase                  " ignore case letters

" }}}

" History and permanent undo levels {{{

set history=1000
"set undofile
set undoreload=1000
set nowritebackup

" }}}

" Make a dir if no exists {{{

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" }}}

" Wildmenu {{{

set wildmenu                        " Command line autocompletion
set wildmode=list:longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.jar                            " java archives
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.stats                          " Pylint stats

" }}}

" Tabs, space and wrapping {{{

set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent

" set formatoptions=qrn1ct
set textwidth=90
"set colorcolumn=81
"
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal noexpandtab ts=4 sts=4 sw=4
autocmd Filetype go setlocal noexpandtab ts=4 sts=4 sw=4


function! ToggleWrap()
    let s:nowrap_cc_bg = [22, '#005f00']
    redir => s:curr_cc_hi
    silent hi ColorColumn
    redir END
    let s:curr_cc_ctermbg = matchstr(s:curr_cc_hi, 'ctermbg=\zs.\{-}\s\ze\1')
    let s:curr_cc_guibg = matchstr(s:curr_cc_hi, 'guibg=\zs.\{-}\_$\ze\1')
    if s:curr_cc_ctermbg != s:nowrap_cc_bg[0]
        let g:curr_cc_ctermbg = s:curr_cc_ctermbg
    endif
    if s:curr_cc_guibg != s:nowrap_cc_bg[1]
        let g:curr_cc_guibg = s:curr_cc_guibg
    endif
    if &textwidth == 80
        set textwidth=0
        exec 'hi ColorColumn ctermbg='.s:nowrap_cc_bg[0].
                    \' guibg='.s:nowrap_cc_bg[1]
    elseif &textwidth == 0
        set textwidth=80
        exec 'hi ColorColumn ctermbg='.g:curr_cc_ctermbg.
                    \' guibg='.g:curr_cc_guibg
    endif
endfunction

nmap <silent><Leader>ew :call ToggleWrap()<CR>

" }}}

" Colorscheme {{{

syntax enable                  " enable the syntax highlight
set background=dark            " set a dark background
set t_Co=256                   " 256 colors for the terminal


"if (has("termguicolors"))
" set termguicolors
"endif

" Theme
colorscheme tender

" }}}

" Resize the divisions if the Vim window size changes {{{

au VimResized * exe "normal! \<c-w>="

" }}}

" New windows {{{

nnoremap <Leader>v <C-w>v
nnoremap <Leader>h <C-w>s

" }}}

" Fast window moves {{{

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}

" Fast window & buffer close and kill {{{

nnoremap <Leader>k <C-w>c
nnoremap <silent><Leader>K :bd<CR>

" }}}

" Toggle line numbers {{{

nnoremap <silent><Leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if !&number && !&relativenumber
      set number
      set norelativenumber
  elseif &number && !&relativenumber
      set nonumber
      set relativenumber
  elseif !&number && &relativenumber
      set number
      set relativenumber
  elseif &number && &relativenumber
      set nonumber
      set norelativenumber
  endif
endfunction

set number
" }}}

" Show hidden chars {{{

nmap <Leader>eh :set list!<CR>
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶,space:.

" }}}

" Highlight trailing whitespaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"}}}
"
" Folding {{{

set foldmethod=marker

" Toggle folding

nnoremap \ za
vnoremap \ za

" }}}

" Cut/Paste {{{

" to/from the clipboard
map <Leader>y "*y
map <Leader>p "*p

" toggle paste mode
map <Leader>P :set invpaste<CR>

" }}}

" Autoload configuration when this file changes ($MYVIMRC) {{{

autocmd! BufWritePost vimrc source %

" }}}

" Save as root {{{

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" Quick saving {{{

nmap <silent> <Leader>w :update<CR>

" }}}

" Delete trailing whitespaces {{{

nmap <silent><Leader>et :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" }}}

" Toggle the Quickfix window {{{

function! s:QuickfixToggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            lclose
            return
        endif
    endfor
    copen
endfunction
command! ToggleQuickfix call <SID>QuickfixToggle()

nnoremap <silent> <Leader>q :ToggleQuickfix<CR>

" }}}

" Execution permissions by default to shebang (#!) files {{{

augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post = '+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END

" }}}

" Make the Y behavior similar to D & C {{{

nnoremap Y y$

" }}}
"

" Omni completion {{
"
  filetype plugin on
  set omnifunc=syntaxcomplete#Complete

" }}

" END VIM SETUP }}}


" PLUGINS Setup {{{ ===========================================================

" Airline {{{

set noshowmode

"let g:airline_theme='molokai'
let g:airline_theme='cool'
let g:airline_enable_branch=1
let g:airline_detect_whitespace = 1
let g:airline#extensions#hunks#non_zero_only = 1

"let g:airline_powerline_fonts=0
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" }}}

"
"Ale {{{

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_use_global = 1

"}}}

"" Syntastic {{{

""let g:syntastic_python_pylint_exe = "pylint2"
"let g:syntastic_python_pylint_exe = "pylint"
"
"let g:syntastic_error_symbol='✗'
"let g:syntastic_warning_symbol='⚠'
"let g:syntastic_style_error_symbol  = '⚡'
"let g:syntastic_style_warning_symbol  = '⚡'
"
"" }}}

" Tagbar {{{
"
"let g:tagbar_ctags_bin='/home/luis/local/ctags-5.8/ctags'
nnoremap <silent> <F10> :TagbarToggle<CR>

" }}}
"
" NERDTree {{{
nnoremap <silent> <F2> :NERDTreeToggle<CR>
"
" }}}

" fzf {{{



" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'



" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


:nnoremap <C-p> :FZF<CR>


" }}}
"
"vimux {{{
"
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
"
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

"}}}

" END PLUGINS SETUP }}}

" vim:foldmethod=marker
