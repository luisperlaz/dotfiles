set background=dark


" Common key mappings {{{
:nnoremap <F9> :previous<CR>
:nnoremap <F12> :next<CR>

" restore arrow keys
nnoremap <up> <up>
nnoremap <down> <down>
nnoremap <left> <left>
nnoremap <right> <right>
inoremap <up> <up>
inoremap <down> <down>
inoremap <left> <left>
inoremap <right> <right>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" }}}

" Bundles {{{
NeoBundle 'davidhalter/jedi-vim'
NeoBundleDisable 'Shougo/neocomplete.vim'
NeoBundleLazy 'bchallenor/scala-dist-vim', { 'autoload' : { 'filetypes' : 'scala'}}
" }}}

" pymode {{{
" Don't autofold code
let g:pymode_folding = 0
" let jedi-vim do python autocompletion
let g:pymode_rope = 0
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
