set nocompatible        "Use Vim settings rather than Vi settings. This must be first

let s:vim_version = system( 'vim --version | sed -rzn "2q;s/.*VIM.*?([0-9]\+?)\.([0-9]\+?).+patches:\s*[0-9]+-([0-9]+?).+/\1.\2.\3/p"' )

"Rename tmux window name if exists
if exists( '$TMUX' )
    autocmd BufReadPost,FileReadPost,BufNewFile,TabEnter * call system("tmux rename-window vim:" . expand("%:t")[-12:])
    autocmd VimLeave * call system("tmux set-window-option automatic-rename")
endif

"Install vim-plugged if it doesn't exist
let s:vim_plug_dir = expand( $HOME . '/.vim/autoload' )
let s:vim_plug_need_install = 0
if !filereadable( s:vim_plug_dir . '/plug.vim' )
    if executable( 'wget' )
        execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P ' . s:vim_plug_dir
    elseif executable( 'curl' )
        execute '!curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -fLo ' . s:vim_plug_dir . '/plug.vim'
    endif
    let s:vim_plug_need_install = 1
endif

"Initialize plugin system
call plug#begin( '~/.vim/plugged' )

"============================================================

Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_session_persistence = 1
let g:startify_custom_header = [
        \ '----------------------------------------------------',
        \ '|                    _                 __          |',
        \ '|          _      __(_)___  ___  _____/ /_         |',
        \ '|         | | /| / / / __ \/ _ \/ ___/ __/         |',
        \ '|         | |/ |/ / / / / /  __(__  ) /_           |',
        \ '|         |__/|__/_/_/ /_/\___/____/\__/           |',
        \ '|                                                  |',
        \ '|                              VIM ' . s:vim_version . '        |',
        \ '----------------------------------------------------',
        \ ]
let g:startify_skiplist = [
        \ 'Build', 'build', 'Output', 'output', 'Intermediate', 'intermediate', 'third_party', 'VisualGDB',
        \ ]

"============================================================

Plug 'vim-airline/vim-airline'
let g:airline#extensions#branch#displayed_head_limit = 12

"============================================================

Plug 'scrooloose/nerdtree'
nnoremap <F6> :NERDTreeToggle<CR>

"============================================================

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
nnoremap <F3> :LeaderfFile<CR>
let g:Lf_WildIgnore = {
    \    'dir': ['Build', 'build', 'Output', 'output', 'Intermediate', 'intermediate', 'VisualGDB'],
    \    'file': ['*.so', '*.csv', '*.jpg']
    \    }
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}

"============================================================

Plug 'powerman/vim-plugin-AnsiEsc'
nnoremap <F5> :AnsiEsc<CR>

"============================================================

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

"============================================================

Plug 'pearofducks/ansible-vim'

"============================================================
"
Plug 'udalov/kotlin-vim'

"============================================================

Plug 'majutsushi/tagbar'
nnoremap <F4> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1
let g:tagbar_vertical = 10

"============================================================

Plug 'hsanson/vim-android'
"let g:gradle_path = '/home/winest/.gradle/wrapper/dists/gradle-6.3-all/b4awcolw9l59x95tu1obfh9i8/gradle-6.3/'
"let g:android_sdk_path = '/usr/local/pkg/android-sdk25/'

"============================================================

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " --system-libclang' }
"autocmd FileType cpp    nnoremap <buffer> <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"autocmd FileType cpp    nnoremap <buffer> <C-F12> :YcmCompleter GoToDeclaration<CR> 
let g:ycm_global_ycm_extra_conf = '/home/winest/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 0

"============================================================

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
inoremap <expr> <Tab>   pumvisible() ? '<C-N>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-P>' : '<S-Tab>'
inoremap <expr> <CR>    pumvisible() ? '<C-Y>' : '<C-G>u<CR>'
let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_log_file = '/home/winest/asyncomplete.log'
"let g:asyncomplete_remove_duplicates = 1

Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function( 'asyncomplete#sources#file#completor' )
        \ }))

Plug 'prabirshrestha/vim-lsp'
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_async_completion = 0
"let g:lsp_log_file = expand('/home/winest/vim-lsp.log')

autocmd FileType dockerfile,java,kotlin,python,yaml            nnoremap <buffer> <C-F> :LspReferences<CR>
autocmd FileType cpp,dockerfile,java,kotlin,lua,python,yaml    nnoremap <buffer> <F12> :LspDefinition<CR>
autocmd FileType cpp,dockerfile,java,kotlin,lua,python,yaml    nnoremap <buffer> <C-F12> :LspDefinition<CR>

if executable( 'clangd' )
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
endif

"pip install python-language-server
if executable( 'pyls' )
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
endif

"npm install --global --unsafe-perm bash-language-server
if executable( 'bash-language-server' )
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'bash-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
            \ 'whitelist': ['sh'],
            \ })
endif

"mkdir -p ~/.vim/eclipse.jdt.ls
"cd ~/.vim/eclipse.jdt.ls
"wget http://download.eclipse.org/jdtls/milestones/0.62.0/jdt-language-server-0.62.0-202009291815.tar.gz"
"tar -zxvf jdt-language-server-0.62.0-202009291815.tar.gz
if executable( 'java' ) && filereadable( expand('~/.vim/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.800.v20200727-1323.jar') )
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'eclipse.jdt.ls',
            \ 'cmd': {server_info->[
            \     '/usr/lib/jvm/java-11-openjdk-amd64/bin/java',
            \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \     '-Dosgi.bundles.defaultStartLevel=4',
            \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \     '-Dlog.level=ALL',
            \     '-noverify',
            \     '-Dfile.encoding=UTF-8',
            \     '-Xmx1G',
            \     '-jar',
            \     expand('~/.vim/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.800.v20200727-1323.jar'),
            \     '-configuration',
            \     expand('~/.vim/eclipse.jdt.ls/config_linux'),
            \     '-data',
            \     expand('~/.vim/eclipse.jdt.ls/projects/' . fnamemodify(getcwd(), ':t'))
            \ ]},
            \ 'whitelist': ['java'],
            \ })
endif

"mkdir -p  ~/.vim/kotlin-language-server
"cd ~/.vim/kotlin-language-server
"wget https://github.com/fwcd/kotlin-language-server/releases/download/0.7.0/server.zip
"unzip server.zip
if executable(expand( '~/.vim/kotlin-language-server/server/bin/kotlin-language-server') )
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[
        \     &shell,
        \     &shellcmdflag,
        \     expand('~/.vim/kotlin-language-server/server/bin/kotlin-language-server')
        \ ]},
        \ 'whitelist': ['kotlin']
        \ })
endif


"luarocks install --server=http://luarocks.org/dev lua-lsp
if executable( 'lua-lsp' )
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'lua-lsp',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'lua-lsp']},
            \ 'whitelist': ['lua'],
            \ })
endif

"npm install --global dockerfile-language-server-nodejs
if executable( 'docker-langserver' )
    au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

"npm install --global yaml-language-server
if executable( 'yaml-language-server' )
  augroup LspYaml
   autocmd!
   autocmd User lsp_setup call lsp#register_server({
       \ 'name': 'yaml-language-server',
       \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
       \ 'whitelist': ['yaml', 'yaml.ansible'],
       \ 'workspace_config': {
       \   'yaml': {
       \     'validate': v:true,
       \     'hover': v:true,
       \     'completion': v:true,
       \     'customTags': [],
       \     'schemas': {},
       \     'schemaStore': { 'enable': v:true },
       \   }
       \ }
       \})
  augroup END
endif
"============================================================

Plug 'aceofall/gtags.vim'
let g:Gtags_Auto_Update = 1
autocmd FileType cpp    nnoremap <buffer> <C-F> :GtagsCursor<CR>
nnoremap <C-G> :Gtags -g <C-R>=expand( '<cword>' )<CR><CR>

"============================================================

Plug 'rking/ag.vim'

"============================================================

Plug 'tpope/vim-fugitive'

"============================================================

call plug#end()

if ( s:vim_plug_need_install )
    PlugInstall
endif



nnoremap <C-P> <C-I>
nnoremap <C-T> :tabnew<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <F9> :tabmove -1<CR>
nnoremap <F10> :tabmove +1<CR>
nnoremap <C-Z> :cclose<CR>
nnoremap <F7> :cprevious<CR>
nnoremap <F8> :cnext<CR>

filetype plugin indent on
autocmd FileType cpp  setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set pastetoggle=<F2>

set guioptions-=T
set completeopt-=preview
set completeopt-=menu
set completeopt^=menuone,longest "Display auto-complete even only one possible match
set clipboard^=unnamedplus       "Use the same clipbaord like Ctrl+C Ctrl+V
set showcmd                      "Display current commands
set wildmenu                     "Show possible vim commands in vim command mode
set cursorline                   "Highlight current line
set number                       "Show line number
set showmatch                    "Show match of brackets
set noruler                      "Disable ruler, use statusline directly
set statusline^=%<%F\ %=%{''.(&fenc!=''?&fenc:&enc).''}\ %{(&bomb?\",BOM\":\"\")}\ (%l,%c%V\ %=\ %P)
set laststatus=2                 "Enable statusline

set vb t_vb=                     "No beep
set ignorecase                   "Search case-insensitive
set smartcase                    "Search case-sensitive if keyword is capitalized when ignorecase is set
set incsearch                    "Do incremental searching
set backspace=indent,eol,start   "Allow backspacing over everything in insert mode
set nobackup                     "Do not keep a backup file, use versions instead
set noswapfile                   "Do not keep a swap file
set history=50                   "Keep 50 lines of command line history
set hidden                       "Keep vim buffer in the background when switch tabs
let &undodir = expand( $HOME . '/.vim/undo' )
if !isdirectory( &undodir )
    call mkdir( &undodir , 'p' )
endif
set undofile                     "Enable saving undo history even vim is closed
set undolevels=1000              "Maximum number of changes that can be undone
set undoreload=10000             "Maximum number of lines to be saved in undo

"Switch syntax highlighting on, when the terminal has colors
"Also switch on highlighting the last used search pattern.
if ( &t_Co > 2 || has('gui_running') )
    syntax on
    set hlsearch
endif
set background=dark             "Default is light
colorscheme winest-colors



"In many terminal emulators the mouse works just fine, thus enable it.
if has( 'mouse' )
    set mouse=a
endif

if ( $DISPLAY != '' && executable('xsel') )
	nnoremap <silent> "*y :'[,']w !xsel --clipboard -i<CR>
	nnoremap <silent> "*p :r!xsel --clipboard -o<CR>
	nnoremap <silent> "+y :'[,']w !xsel --clipboard -i<CR>
	nnoremap <silent> "+p :r!xsel --clipboard -o<CR>
endif



"Convenient command to see the difference between the current buffer and the
"file it was loaded from, thus the changes you made.
"Only define it when not defined already.
if !exists( ':DiffOrg' )
    command DiffOrg vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif



"Display file in csv mode
if !exists( ':Csv' )
    function! s:Csv()
        let path = expand( '%:p' )
        if executable( 'tabview' )
            silent execute '!tabview ' . path
        else
            silent execute '!cat ' . path . '| sed -e "s/,,/, ,/g" | column -s, -t | less -\#5 -N -S'
        endif
        silent execute ':redraw!'
    endfunction
    command Csv call s:Csv()
endif



"Display file in hex
if !exists( ':Hex' )
    function! s:Hex()
        "Hex mode should be considered a read-only operation
        "Save values for modified and read-only for restoration later,
        "and clear the read-only flag for now
        let l:modified=&mod
        let l:oldreadonly=&readonly
        let &readonly=0
        let l:oldmodifiable=&modifiable
        let &modifiable=1
        if !exists("b:editHex") || !b:editHex
            "Save old options
            let b:oldft=&ft
            let b:oldbin=&bin
            "Set new options
            setlocal binary " make sure it overrides any textwidth, etc.
            silent :e " this will reload the file without trickeries
                      "(DOS line endings will be shown entirely )
            let &ft="xxd"
            "Set status
            let b:editHex=1
            "Switch to hex editor
            %!xxd
        else
            "Restore old options
            let &ft=b:oldft
            if !b:oldbin
              setlocal nobinary
            endif
            "Set status
            let b:editHex=0
            "Return to normal editing
            %!xxd -r
        endif
        "Restore values for modified and read only state
        let &mod=l:modified
        let &readonly=l:oldreadonly
        let &modifiable=l:oldmodifiable
    endfunction
    command Hex call s:Hex()
endif



function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute( $VIMRUNTIME , ' ' , '" ' , '' ) . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
set diffexpr=MyDiff()



if exists( '+showtabline' )
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1

        let cnt = 0
        let totalLen = 0
        while i <= tabpagenr( '$' )
          let winnr = tabpagewinnr( i )
          let buflist = tabpagebuflist( i )
          let bufnr = buflist[winnr - 1]
          let file = bufname( bufnr )
          let buftype = getbufvar( bufnr , 'buftype' )
          if buftype == 'nofile'
              if file =~ '\/.'
                  let file = substitute( file , '.*\/\ze.' , '' , '' )
              endif
          else
              let file = fnamemodify( file , ':p:t' )
          endif
        "<Number><Space><file><Space>
          let totalLen = totalLen + 3 + len(file)
          let i = i + 1
        endwhile

        let i = 1
        while i <= tabpagenr( '$' )
            let buflist = tabpagebuflist( i )
            let winnr = tabpagewinnr( i )
            let s .= '%' . i . 'T'
            let s .= ( i == t ? '%1*' : '%2*' )
            let wn = tabpagewinnr( i ,'$' )

            let s .= '%#TabNum#'
            let s .= i
            "let s .= '%*'
            let s .= ( i == t ? '%#TabLineSel#' : '%#TabLine#' )
            let bufnr = buflist[winnr - 1]
            let file = bufname( bufnr )
            let buftype = getbufvar( bufnr , 'buftype' )
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute( file , '.*\/\ze.' , '' , '' )
                endif
            else
                let file = fnamemodify( file , ':p:t' )
            endif

            "echo totalLen . "/" . &columns . ", file=" . file
            if totalLen > &columns && len(file) > 16
                let file = strpart( file, 0, 6 )  . "~" . strpart( file, len(file)-10 )
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= ( tabpagenr('$') > 1 ? '%999XX' : 'X' )
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    highlight link TabNum Special
endif



"Format for the folded folds line
function! MyFoldText() " {{{
    let line = getline( v:foldstart )

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth( 0 ) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    "Expand tabs into spaces
    let onetab = strpart( '          ' , 0 , &tabstop )
    let line = substitute( line , '\t' , onetab , 'g' )

    let line = strpart( line, 0, windowwidth - 2 -len(foldedlinecount) )
    let fillcharcount = windowwidth - len( line ) - len( foldedlinecount )
    "return line . '-' . repeat( " " , fillcharcount ) . foldedlinecount . '-' . ' '
    return line . '   |' . foldedlinecount . ' lines|'
endfunction " }}}
set foldtext=MyFoldText()
