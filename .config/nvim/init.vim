set shellslash      " Use forward slashes on file paths even on Windows
" We have valid defaults for the following paths, so no need to fiddle with
" this (see: https://github.com/neovim/neovim/issues/78#issue-28120804 )
let &packpath = &runtimepath

" Setting swapfiles active and defining the directory for saving
"exec 'set directory='.g:vim_data_root.'/tmp,.'
set swapfile
set wildignore=*/tmp/*,*/.git/*,*.swp,*.zip,*.exe,*.pyc

filetype off                  " required for e.g. Vundle / Plug

" Plug, see https://github.com/junegunn/vim-plug
exec 'call plug#begin("'.&directory.'/plug")'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
""Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
" Nerdtree
"Plug 'scrooloose/nerdtree'
"Bundle 'jeetsukumaran/vim-buffergator'
"Bundle 'vim-scripts/DBGPavim'
"Bundle 'DBGp-client'
" Show indent guides <Leader>ig
"Bundle 'nathanaelkane/vim-indent-guides'
"indentLine as lightweight alternative
"Bundle 'Yggdroot/indentLine'
" EasyMotion, triggered with <leader><leader><motion>
" HP: https://github.com/Lokaltog/vim-easymotion
Plug 'Lokaltog/vim-easymotion'
" ZoomWin: Zoom window in / out using <c-w>o
" HP: https://github.com/vim-scripts/ZoomWin
Plug 'vim-scripts/ZoomWin'
" Multiple Cursors, use <Ctrl-n>; marking multiple lines + triggered gets it
" on multiple lines
" Ctrl-n for selecting word / next occurence and go to visual mode
" Ctrl-p in visual mode to deselect an occurence and return to the previous one
" Ctrl-x in visual mode to "jump over" an occurence and select the next occurence
"Plug 'terryma/vim-multiple-cursors'
" Nice statusline: Airline
"Plug 'bling/vim-airline'
" Nice statusline: Airline
Plug 'itchyny/lightline.vim'
" Ctrl-P for fuzzy searching files, buffers, tags, ...
" Plug 'kien/ctrlp.vim' "Unmaintained, use the following instead:
"Plug 'ctrlpvim/ctrlp.vim'
" Tim Pope's Markdown syntax
Plug 'tpope/vim-markdown'
" A plugin for pandoc
Plug 'vim-pandoc/vim-pandoc'
" ... and its related syntax file
Plug 'vim-pandoc/vim-pandoc-syntax'
" gruvbox
"Plug 'morhetz/gruvbox'
" Oceanic-Next
Plug 'mhartington/oceanic-next'
" Vim DevIcons
Plug 'ryanoasis/vim-devicons'
" vim-expand-region for having an IntelliJ Ctrl-W-like behavior
Plug 'terryma/vim-expand-region'
" Trying out a simplier alternative to Nerd Tree and netrw
" See https://github.com/justinmk/vim-dirvish
"Bundle 'justinmk/vim-dirvish'
" Trying the "original" vim-filebeagle, see https://github.com/jeetsukumaran/vim-filebeagle
" Use <leader>f or - to open FileBeagle
" - to go up one dir, <BS> to go to prev dir
" o..open, <Ctrl>-V..vertical split, <Ctrl>-S..horizontal split, <Ctrl>-T..tab
" You can also use the line number, e.g. 42v..open in vertical split
" q..close FileBeagle
"Plug 'jeetsukumaran/vim-filebeagle'
" jedi-vim for autocompletion (first: pip install jedi)
" Ctrl-<Space> for autocompletion
" Check: https://github.com/davidhalter/jedi-vim
"Plug 'davidhalter/jedi-vim'
" vinegar as replacement for netrw (creating problems on Windows currently)
"Plug 'tpope/vim-vinegar'
" vim-which-key: https://github.com/liuchengxu/vim-which-key: Not working
" unfortunately in neovim
"Plug 'liuchengxu/vim-which-key'
" Denite seems to be helm for vim / neovim
"Plug 'Shougo/denite.nvim'
" MiniBufExpl - Show buffer names on top of the window
" https://github.com/weynhamz/vim-plugin-minibufexpl
"Plug 'weynhamz/vim-plugin-minibufexpl'
" vim-bufferline: the buffer names in one line
" Replaces MiniBufExpl above as it is more compact
" https://github.com/bling/vim-bufferline
" For configuration run: :help bufferline
Plug 'bling/vim-bufferline'
" For quicker navigation within a line using f / F / t / T with ; / ,
" Seems to have problems with neovim
"Plug 'unblevable/quick-scope'
" As alternative to quick-scope: clever-f
Plug 'rhysd/clever-f.vim'

" Configuration for EasyMotion
let g:Easymotion_do_mapping = 0 " Disable default mappings
"nmap <Leader> <Plug>(easymotion-prefix)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
" Move to word
"nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)
nmap <Leader> <Plug>(easymotion-prefix)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
nmap <Leader><Leader>w <Plug>(easymotion-bd-w)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" MiniBufExpl - Configuration
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 

" Initialize plugin system
call plug#end()

" Always use the system clipboard
"set clipboard=unnamed
"set clipboard+=unnamedplus

" Font-settings for the GUI are set in the ginit.vim
" Setting Courier_new as font in the GUI for displaying UTF-8 characters
"if has('gui_running')
    "set guifont=Courier_New:h12:b
    "set guifont=Cousine\ 15
"endif
"if has('nvim')
"Guifont! UbuntuMono\ Nerd\ Font\ Mono:h12
"endif
" Using the following for fixing a problem with Plug
"if has("gui_running") == 0
    "set shell=/usr/bin/bash
"endif

" Search for the visually selected text; // in normal mode means: search for
" last searched text; now hitting // in visual mode searches for the selected
" text
vnoremap // y/<C-R>"<CR>
" Adding also a command for this: Change Directory to Current
"command CDC cd %:p:h

" TODO: CHECK the following configuration settings if still relevant
" ##################################################################


" As mentioned on the ReadMe for Oceanic-Next
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set termguicolors
"if (has("termguicolors"))
    "set termguicolors
"endif
" Set colorscheme
colorscheme OceanicNext
" Set airline-theme
"let g:airline_theme='oceanicnext'
" Set lightline-theme
let g:lightline_theme='oceanicnext'
" Set airline-fonts as well
"let g:airline_powerline_fonts = 1
" According to https://vi.stackexchange.com/a/8562
" True gui colors in terminal
"if has('gui_running')
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    "set termguicolors
"endif

" Autocompletion
" key	description
" ^P	basic tab completion, pulling from a variety of sources
" ^N	the same as ^P but backward
" ^X ^L	whole line completion
" ^X ^O	syntax-aware omnicompletion
" Find the article at http://robots.thoughtbot.com/vim-you-complete-me
" The following uses the current file, other buffers (closed or still open and current tags file)
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview
" mapping Tab to autocomplete
"imap <Tab> <C-P> 

" Activating % also for if/elsif/else/end/xml-tags etc.
" see: http://items.sjbach.com/319/configuring-vim-right
runtime macros/matchit.vim

" Setting the indentation guides a bit smaller
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1

" Setting the indentation character for indentLine
"let g:indentLine_char = '|'
"let g:indentLine_color_term = 239
"let g:indentLine_color_gui = '#A4E57E'

" Cross-platform reload vim-config files on save as seen on http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2403926#2403926
"augroup myvimrc
    "autocmd!
    "autocmd BufWritePost $MYVIMRC so $MYVIMRC
"    ""autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

" Crude line text-objects, see https://vi.stackexchange.com/a/6102
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>
" Using the vim-expand-region-plugin to have an IntelliJ Ctrl-W-like
" experience. Shrink the selection by pressing Ctrl-v in visual mode, expand
" by pressing v in visual mode. Brilliant!
" Found on the very good page https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({
     \ 'a]' :1,
     \ 'ab' :1,
     \ 'aB' :1,
     \ '_'  :0,
     \ 'il' :1,
     \ 'al' :1,
     \ })

" Setting the cursor modes as described in http://vim.wikia.com/wiki/Configuring_the_cursor 
highlight Cursor guifg=steelblue guibg=lightgrey
highlight iCursor guifg=steelblue guibg=white

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait90

" Switching just to the next / previous buffer
nmap <leader>bn :bn<CR>
nmap <leader>bb :bp<CR>


" Following the hint from :help nvim-from-vim
"if !has('nvim')
    "set ttymouse=xterm2
    "set term=xterm
    "set t_co=256
"endif

" let g:Guifont="Literation Mono Nerd Font Complete Mono:h10"
" set guifont=Literation\ Mono\ Nerd\ Font\ Complete\ Mono:h10
"set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono\ Windows\ Compatible:h10
"set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono\ Windows\ Compatible:h10
"set guifont=DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono\ Windows\ Compatible:h10
set guifont=Fira\ Mono:h10
"if exists("g:loaded_webdevicons")
    "call webdevicons#refresh()
"endif
set conceallevel=3

" Improving netrw (beside using vinegar)
" See: https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
" absolute width of netrw window
"let g:netrw_winsize = -30

" do not display info on the top of window
"let g:netrw_banner = 0

" tree-view
"let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
"let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
"let g:netrw_browse_split = 4
"let g:netrw_altv=1  " Open in vertical split

" Set vim to chdir for each file
" Found here: https://stackoverflow.com/a/1709267/1785391
" % .. current filename :p .. expand full path :h head (rm last path component)
if exists('+autochdir')
    set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" Close netrw window so it doesn't show up in the buffer list
" See: https://vi.stackexchange.com/a/14633
autocmd FileType netrw setl bufhidden=wipe

"com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)

fun! Lexplore(dir, right)
  if exists("t:netrw_lexbufnr")
  " close down netrw explorer window
  let lexwinnr = bufwinnr(t:netrw_lexbufnr)
  if lexwinnr != -1
    let curwin = winnr()
    exe lexwinnr."wincmd w"
    close
    exe curwin."wincmd w"
  endif
  unlet t:netrw_lexbufnr

  else
    " open netrw explorer window in the dir of current file
    " (even on remote files)
    let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
    exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
    if a:dir != ""
      exe "Explore ".a:dir
    else
      exe "Explore ".path
    endif
    setlocal winfixwidth
    let t:netrw_lexbufnr = bufnr("%")
  endif
endfun

" As heard at https://www.youtube.com/watch?v=MquaityA1SM
"noremap Q !!$SHELL<CR>

" If in netrw, q closes the window
autocmd FileType netrw nnoremap q :bw<CR>

" Loading the general configuration that is the same for all vim instances
source $XDG_CONFIG_HOME/vim/vimrc

" Enable quick-scope
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Configure clever-f
let g:clever_f_smart_case = 1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

