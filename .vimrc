autocmd FileType * set tabstop=4|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

syntax enable
set background=dark

hi CursorLine cterm=NONE ctermbg=235
hi CursorLine cterm=NONE ctermbg=235
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
