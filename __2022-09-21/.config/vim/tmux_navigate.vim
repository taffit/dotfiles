function! TmuxWincmd(direction)
  let l:oldwin = winnr()
  execute 'wincmd ' . a:direction
  if l:oldwin == winnr()
    if $TMUX == ''
      execute '999wincmd ' . tr(a:direction, 'hjkl', 'lkjh')
    else
      silent call system('tmux_navigate skipvim ' . a:direction)
    endif
  endif
endfunction

nnoremap <silent> <C-h> :call TmuxWincmd('h')<CR>
nnoremap <silent> <C-j> :call TmuxWincmd('j')<CR>
nnoremap <silent> <C-k> :call TmuxWincmd('k')<CR>
nnoremap <silent> <C-l> :call TmuxWincmd('l')<CR>
