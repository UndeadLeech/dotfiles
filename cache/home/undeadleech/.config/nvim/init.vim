" Plugins
set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim
call dein#begin("~/.config/nvim/plugins")
call dein#add('Shougo/dein.vim')

" Appearance
    " Vim-Airline
    call dein#add('vim-airline/vim-airline')
    " Vim-Airline Theme
    call dein#add('chrisduerr/vim-undead')
    " Fancy Startscreen
    call dein#add('mhinz/vim-startify')

" Programming
    " Rust
    call dein#add('racer-rust/vim-racer')
    call dein#add('rust-lang/rust.vim', {'on_ft': ['rust']})
    call dein#add('autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'})
    " Git Diff
    call dein#add('airblade/vim-gitgutter')
    " HTML
    call dein#add('Valloric/MatchTagAlways', {'on_ft': ['css']})
    " Markdown
    call dein#add('suan/vim-instant-markdown', {'on_ft': ['markdown']})
    " Comment/Uncomment text
    call dein#add('tpope/vim-commentary')
    " Snippets
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    " Display Function Signatures
    call dein#add('Shougo/echodoc.vim')
    " Auto Completion Engine
    call dein#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
    " Syntax Highlighting for a ton of languages
    call dein#add('sheerun/vim-polyglot')

" Usability
    " Avoid error saving files with long path
    call dein#add('pixelastic/vim-undodir-tree')
    " Automatically toggles relative line numbers
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    " reopen files at last edit position
    call dein#add('dietsche/vim-lastplace')
    " Auto pair brackets
    call dein#add('Raimondi/delimitMate')
    " Mark Trailing Whitespaces
    call dein#add('ntpeters/vim-better-whitespace')
    " Sane defaults for vim
    call dein#add('tpope/vim-sensible')
    " Display open buffers
    call dein#add('bling/vim-bufferline')
    " Easier navigation
    call dein#add('easymotion/vim-easymotion')
    " Fuzzy Finder And Stuff
    call dein#add('Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'})

call dein#end()

filetype plugin indent on
syntax enable

" Automagically install new dein.vim plugins
if dein#check_install()
    call dein#install()
endif

let mapleader=' '
set encoding=utf-8
scriptencoding utf-8

" Case-insensitive pathname tab completion
set wildignorecase

" Persistent undo
set undodir=~/.config/nvim/.undo//
set backupdir=~/.config/nvim/.backup//
set directory=~/.config/nvim/.swp//
set undofile

" Better searching
set ignorecase smartcase incsearch showmatch hlsearch
nnoremap <C-L> :noh<CR><C-L>

" Show relative line numbers and never let cursor touch top/bottom
set relativenumber scrolloff=5

" Buffer navigation
nnoremap <C-RIGHT> :bn<CR>
nnoremap <C-LEFT> :bp<CR>

" Save root files
cnoremap w!! w !sudo tee % > /dev/null <CR>

" Set cursor shape
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Set colorscheme
colorscheme undead

" Indentation
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent

" Hide -- INSERT -- in cmdline
set noshowmode

" Don't abandon buffers
set hidden

" Don't open preview window after completion
set completeopt-=preview

" Language-specific
au FileType css  set ts=2 sw=2 sts=2
au FileType html set ts=2 sw=2 sts=2
au FileType rust :LanguageClientStart

" Setup TAB to work for neosnippet and deoplete
function! TabKeyFunc() abort
    if neosnippet#jumpable()
        return "\<Plug>(neosnippet_jump)"
    elseif pumvisible()
        return "\<C-N>"
    else
        return "\<TAB>"
    endif
endfunction
imap <expr><TAB> TabKeyFunc()

" Setup ENTER to prevent new line when completing
function! EnterKeyFunc() abort
    if neosnippet#expandable()
        echomsg 'HERE'
        return "\<Plug>(neosnippet_expand)"
    elseif pumvisible()
        return deoplete#close_popup()
    else
        return "\<ENTER>"
    endif
endfunction
imap <expr><ENTER> EnterKeyFunc()

" Hide 'match 1 of 8' messages
set shortmess=filnxtToOIc

" Use tab for indenting
xnoremap <TAB> >gv|
xnoremap <S-TAB> <gv
nnoremap <TAB> >>_
nnoremap <S-TAB> <<_

" Page Up/Down single line
nnoremap <PageUp> <C-y>
nnoremap <PageDown> <C-e>

" Yank to system clipboard
set clipboard+=unnamedplus

" Plugin Configs
    " Vim-Airline
    function! AirlineInit()
        let g:airline_section_z = airline#section#create(['%l/%L %c'])
        let g:airline_section_b = airline#section#create(['branch'])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()
    let g:airline_theme = 'undead'

    " Airline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''

    let g:airline#extensions#bufferline#overwrite_variables = 0

    " Better Whitespace Plugin
    highlight ExtraWhitespace ctermbg=01

    " Echodoc
    let g:echodoc_enable_at_startup = 1

    " Rust.vim
    let g:rustfmt_autosave = 1

    " Polyglot
    let g:polyglot_disabled = ['rust']

    " Vim-racer
    let g:racer_experimental_completer = 1

    " Deoplete
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#ignore_sources = {}
    let g:deoplete#ignore_sources._ = ['LanguageClient']

    " Neosnippet
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    " Denite
    call denite#custom#map('insert', '<Down>',
                         \ '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<Up>',
                         \ '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#option('default', 'prompt', '')
    call denite#custom#option('default', 'auto_resize', 'true')
    call denite#custom#option('default', 'statusline', 0)
    call denite#custom#option('default', 'highlight_matched_char', 'IncSearch')
    call denite#custom#option('default', 'highlight_matched_range', 'Normal')
    call denite#custom#option('default', 'highlight_mode_insert', 'NormalBold')

    " LanguageClient
    nnoremap <silent> <Leader><C-d> :Denite references<CR>
    nnoremap <silent> <Leader>h :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> <Leader>r :call LanguageClient_textDocument_rename()<CR>
    nnoremap <silent> <Leader>d :call LanguageClient_textDocument_definition()<CR>
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['/home/undeadleech/.cargo/bin/rls'],
    \ }

    " Bufferline
    let g:bufferline_show_bufnr = 0
    let g:bufferline_active_buffer_left = ''
    let g:bufferline_active_buffer_right = ''
    let g:bufferline_active_highlight = 'BufferLineSel'
    let g:bufferline_inactive_highlight = 'BufferLine'

    " EasyMotion
    " Mapping to <Leader> might result in issues
    map <Leader> <Plug>(easymotion-prefix)

    " Startify
    let g:startify_list_order = [
        \ ['   Files:'], 'files',
        \ ['   This Directory:'], 'dir',
        \ ['   Sessions:'], 'sessions',
        \ ['   Bookmarks:'], 'bookmarks',
        \ ['   Commands:'], 'commands',
        \ ]
    let g:startify_custom_header = [
        \ '                    (_)        .       .                                     .',
        \ '     .        ____.--^.',
        \ '      .      /:  /    |                               +           .         .',
        \ "            /:  `--=--'   .                                                .",
        \ '           /: __[\==`-.___          *           .',
        \ '          /__|\ _~~~~~~   ~~--..__            .             .',
        \ '          \   \|::::|-----.....___|~--.                                 .',
        \ '           \ _\_~~~~~-----:|:::______//---...___',
        \ '       .   [\  \  __  --     \       ~  \_      ~~~===------==-...____',
        \ '           [============================================================-',
        \ "           /         __/__   --  /__    --       /____....----''''~~~~      .",
        \ "     *    /  /   ==           ____....=---='''~~~~ .",
        \ "         /____....--=-''':~~~~                      .                .",
        \ '                        .                                   .           .',
        \ '                             .                      .             +',
        \ '           .     +              .'
        \ ]
