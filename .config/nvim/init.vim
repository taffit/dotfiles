set shellslash      " Use forward slashes on file paths even on Windows
" We have valid defaults for the following paths, so no need to fiddle with
" this (see: https://github.com/neovim/neovim/issues/78#issue-28120804 )
let &packpath = &runtimepath

" Setting swapfiles active and defining the directory for saving
"exec 'set directory='.g:vim_data_root.'/tmp,.'
set swapfile
set wildignore=*/tmp/*,*/.git/*,*.swp,*.zip,*.exe,*.pyc

" Disabling the python provider for Python 2
"let g:loaded_python_provider = 1
"let g:python_host_prog = ''
" Setting the python3_host_prog to an explicit virtualenv
let g:python3_host_prog = $XDG_DATA_HOME . '/nvim/venv/bin/python'

" Loading the general configuration as early as possible, as else the
" leader-mappings may have problems.
source $XDG_CONFIG_HOME/vim/vimrc

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
" vim-zoom: Zoom window in / out using <c-w>m
" HP: https://github.com/dhruvasagar/vim-zoom
Plug 'dhruvasagar/vim-zoom'
" Multiple Cursors, use <Ctrl-n>; marking multiple lines + triggered gets it
" on multiple lines
" Ctrl-n for selecting word / next occurence and go to visual mode
" Ctrl-p in visual mode to deselect an occurence and return to the previous one
" Ctrl-x in visual mode to "jump over" an occurence and select the next occurence
"Plug 'terryma/vim-multiple-cursors'
" Nice statusline: Airline
"Plug 'bling/vim-airline'
" More lightweight: Lightline
Plug 'itchyny/lightline.vim'
" Ctrl-P for fuzzy searching files, buffers, tags, ...
" Plug 'kien/ctrlp.vim' "Unmaintained, use the following instead:
"Plug 'ctrlpvim/ctrlp.vim'
" Tim Pope's Markdown syntax
Plug 'tpope/vim-markdown'
" Tim Pope's surround.vim: surrounding on text objects [cs|ys|ds]<obj><surround>
Plug 'tpope/vim-surround'
" A plugin for pandoc
Plug 'vim-pandoc/vim-pandoc'
" ... and its related syntax file
Plug 'vim-pandoc/vim-pandoc-syntax'
" gruvbox
"Plug 'morhetz/gruvbox'
" Oceanic-Next
"Plug 'mhartington/oceanic-next'
" Gruvbox: https://github.com/morhetz/gruvbox/
Plug 'morhetz/gruvbox'
"Plug 'mhartington/oceanic-next'
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
" Workspace and session management
" See: https://github.com/thaerkh/vim-workspace
Plug 'thaerkh/vim-workspace'
" vim-bufferline: the buffer names in one line
" Replaces MiniBufExpl above as it is more compact
" https://github.com/bling/vim-bufferline
" For configuration run: :help bufferline
"Plug 'bling/vim-bufferline'
" Bufferline in lightline
"Plug 'mengelbrecht/lightline-bufferline'
" For quicker navigation within a line using f / F / t / T with ; / ,
" Seems to have problems with neovim
"Plug 'unblevable/quick-scope'
" As alternative to quick-scope: clever-f
Plug 'rhysd/clever-f.vim'
" Trying Conquer of Completion for autocompletion after the failures with
" deoplete and ncim2.
" See: https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" For installing coc-python, just type: :CocInstall coc-python
" See: https://github.com/neoclide/coc-python
" fuzzy file search: They said that it will change your life
" See: https://github.com/junegunn/fzf
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" diffchanges.vim for showing unsaved changes in current buffer
Plug 'jmcantrell/vim-diffchanges'
" Svelte-3-syntac-highlighting
Plug 'evanleck/vim-svelte'

" Initialize plugin system
call plug#end()

" Configuration for EasyMotion
let g:Easymotion_do_mapping = 0 " Disable default mappings
"nmap <Leader> <Plug>(easymotion-prefix)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
" Move to word
"nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)
"nmap <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
nmap <Leader><Leader>w <Plug>(easymotion-bd-w)

map <Leader>m <Plug>(zoom-toggle)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" vim-workspace: Session management
let g:workspace_session_directory = $XDG_DATA_HOME . '/nvim/swap//'
nnoremap <leader><leader>s :ToggleWorkspace<CR>
let g:workspace_session_disable_on_args = 1

" Auto-updating the `modified`-indicator
"autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

"let g:bufferline_echo = 0
"autocmd VimEnter *
"\ let &statusline='%{bufferline#refresh_status()}'
"    \ .bufferline#get_status_string()
" -----------------------------------------------------------
" CoC - settings
" -----------------------------------------------------------
" Adding coc-information to the statusline
" See: :h coc-status
"set statusline^=%{coc#status()}

" function! StatusDiagnostic() abort
"     let info = get(b:, 'coc_diagnostic_info', {})
"     if empty(info) | return '' | endif
"     let msgs = []
"     if get(info, 'error', 0)
"     call add(msgs, 'E' . info['error'])
"     endif
"     if get(info, 'warning', 0)
"     call add(msgs, 'W' . info['warning'])
"     endif
"     return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
" endfunction
" set statusline^=%{StatusDiagnostic}

" Use autocmd to force lightline update.
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Edit DS: With just 300 ms, the leader-key won't work correctly anymore
" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>x  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" -----------------------------------------------------------
" CoC - settings - end
" -----------------------------------------------------------

" -----------------------------------------------------------
" fzf - settings
" -----------------------------------------------------------
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Open file with <leader>F
map <Leader>F :Files

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>ll :Lines<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" -----------------------------------------------------------
" fzf - settings - end
" -----------------------------------------------------------

" DiffChanges.vim: Toggle diff view
nnoremap <leader><leader>d :DiffChangesDiffToggle<CR>

" MiniBufExpl - Configuration
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 

" Always use the system clipboard
set clipboard=unnamed
set clipboard+=unnamedplus

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

" As mentioned on the ReadMe for Oceanic-Next
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
" Set colorscheme
"colorscheme OceanicNext
" Switching to gruvbox
colorscheme gruvbox
" Set airline-theme
"let g:airline_theme='oceanicnext'
" Set lightline-theme
"let g:lightline_theme='oceanicnext'
let g:lightline_theme='gruvbox'
"let g:lightline = { 'tabline': {'left': [['buffers']], 'right': [['close']]}, 'component_expand': {'buffers': 'lightline#bufferline#buffers'}, 'component_type': {'buffers': 'tabsel'}}
"let g:lightline#bufferline#number_map = {
"\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
"\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
"let g:lightline#bufferline#show_number = 1
"let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
"let g:lightline.component_type   = {'buffers': 'tabsel'}
" Set airline-fonts as well
"let g:airline_powerline_fonts = 1
" According to https://vi.stackexchange.com/a/8562

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

" Enable quick-scope
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Configure clever-f
let g:clever_f_smart_case = 1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" Use <ESC> to exit terminal mode
" As this conflicts with fzf not closing with <ESC>, we redefine.
" See: https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166
if has("nvim")
  tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
  " Alternatively, instead of checking at runtime, restrict to particular buffer
  " au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  " au FileType fzf tunmap <buffer> <Esc>
endif

