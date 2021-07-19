" Galgo's Grand .vimrc
" isn't it lovely? ^^"

" #general
" #shortcuts
" #pluginsettings
" #language
" #tags
" #tmux
" #work
" #plugins
" #color


"" GENERAL #general
set number
syntax on
filetype plugin on
filetype indent on
set ignorecase
set smartcase
set nowrap
autocmd BufEnter * silent! lcd %:p:h
set encoding=utf-8
set autoread " auto reload changed files
set ruler
set incsearch
set lazyredraw
set magic
set showmatch
set hidden " allow opening of new buffers without saving current one
set clipboard^=unnamed " Merge clipboards with system's
set undodir=~/.vim/undodir " save undo history when closing file
set undofile

" Tab
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

command W w !sudo tee % > /dev/null

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"" CUSTOM SHORTCUTS #shortcuts
" Escape for regex
function! Escape()
    s/\//\\\//g
    s/(/\\(/g
    s/)/\\)/g
    s/\[/\\\[/g
    s/\]/\\\]/g
    s/\./\\\./g
    s/\^/\\\^/g
    s/\$/\\\$/g
    s/+/\\+/g
endfunction
noremap <silent><leader>e :silent! call Escape()<CR>

" Trim trailing whitespaces
function! TrimTrailing()
    s/\s\+$//e
endfunction
noremap <silent><leader>d :silent! call TrimTrailing()<CR>

function! ShowFuncName()
    return cfi#format("%s", "")
endfunction



" Fix shift-tab not functional on some terminals
nnoremap <S-Tab> <Up>
inoremap <S-Tab> <Up>

" Tab width set by AutoIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
let g:detectindent_preferred_tabstop = 4
" autocmd BufReadPost * :DetectIndent " NOTE uncomment for autoindent (based 
" on current file indentation)
autocmd FileType xml :DetectIndent

" Quickly set indentation mode by z0, z1, z2
nnoremap z0 :set fdm=manual<CR>
nnoremap z1 :set fdm=indent<CR>
nnoremap z2 :set fdm=syntax<CR>

" Add full file path to statusline
set statusline+=%F
set laststatus=2

" Quick compilation shortcuts
autocmd FileType c nnoremap <F5> :w <bar> :Dispatch gcc *.c -o out; ./out<CR>
autocmd FileType python nnoremap <F5> :w <bar> :Dispatch python %<CR>
autocmd FileType objc nnoremap <F5> :w <bar> :Dispatch clag -framework Foundation *.m  -o out; ./out%<CR>
" with no dispatch:
" autocmd FileType python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
" autocmd FileType c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o'.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" autocmd FileType objc nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o'.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

" Have Vim start in position 0 and in insert mode in git commits
autocmd FileType gitcommit exe "normal gg$" | startinsert

" Surround - use lowercase s to surround with
vmap s S

" Folding settings
" XML
augroup XML
    autocmd!
        autocmd FileType xml setlocal foldmethod=manual foldlevelstart=999 foldminlines=0
    augroup END


"" PLUGIN SETTINGS #pluginsettings
" DelimitMate settings
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType vim let delimitMate_smart_quotes = "':'" " vimrc uses \" for comments
autocmd FileType python let b:delimitMate_nesting_quotes = ["'", '"'] " triple quotes for python
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1


" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1


" YouCompleteMe settings
inoremap <silent> <C-c> <Esc>:pclose<CR><Esc>
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_objc'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_complete_in_comments = 1
let g:ycm_auto_start_csharp_server = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_auto_trigger = 1
let g:ycm_semantic_triggers = {
 \ 'objc' : ['re!\@"\.*"\s',
 \ 're!\@\w+\.*\w*\s',
 \ 're!\@\(\w+\.*\w*\)\s',
 \ 're!\@\(\s*',
 \ 're!\@\[.*\]\s',
 \ 're!\@\[\s*',
 \ 're!\@\{.*\}\s',
 \ 're!\@\{\s*',
 \ "re!\@\’.*\’\s",
 \ '#ifdef ',
 \ 're!:\s*',
 \ 're!=\s*',
 \ 're!,\s*', ],
 \ }
autocmd FileType c nnoremap gd :YcmCompleter GoTo<CR>
autocmd FileType cpp nnoremap gd :YcmCompleter GoTo<CR>


" Jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 1

let g:jedi#force_py_version=3
set bs=2


" ALE
" let b:ale_linters = ['flake8', 'pylint'] " Check Python files with flake8 and pylint (uncomment for styling errors)
let b:ale_linters = ['pylint'] " Check Python files with pylint.
let g:ale_completion_enabled = 1 " Enable completion where available.
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8', 'yapf'],
\}


"" COMMON lANGUAGE FEATURES #language
" Auto style/format with \f on python, c, json
autocmd FileType python nmap <leader>f :ALEFix<cr>
autocmd FileType c nmap <leader>f :YcmCompleter FixIt<cr>
autocmd FileType cpp nmap <leader>f :ClangFormat<cr>
autocmd FileType perl nmap <leader>f :ClangFormat<cr>
autocmd FileType json nmap <leader>f :execute '%!python -m json.tool'<cr>

" Refactor with \r on C, C++ (Jedi implements \r on Python)
autocmd FileType c nmap <leader>r :YcmCompleter RefactorRename
autocmd FileType cpp nmap <leader>r :YcmCompleter RefactorRenamee

" Go to references/usages with \b on C, C++, Python
autocmd FileType c nmap <leader>b :YcmCompleter GoToReferences<cr>
autocmd FileType cpp nmap <leader>b :YcmCompleter GoToReferences<cr>
let g:jedi#usages_command = "<leader>b"


"" TAGS #tags
let g:ctags_statusline=1
let ctags_title=1

" Rooter (base cwd on git root - takes care of tag generation path.)
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1

" cscope
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

" Invoke command - \x for x-refs.
nnoremap <silent> <Leader>x :call Cscope('3', expand('<cword>'))<CR>

" Gutentags
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" let g:gutentags_modules = ['ctags']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_project_root = ['.git', '.cproject', 'Makefile', '.xcodeproj']
let g:GtagsCscope_Auto_Map = 1
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 0
set statusline+=%{gutentags#statusline()}

" Tagbar
nnoremap <silent> <F4> :TagbarToggle<CR><C-w>l
let g:tagbar_autoclose = 1
let g:tagbar_map_nexttag = 'J'
let g:tagbar_map_prevtag = 'K'
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'


" Lineline
" Gutentags for Lightline
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
" Tags with Lightline and Tagbar
source ~/.vim/tagbar_showfunc.vim


" ALE for Lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
" register components
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
" colors for ale plugin
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = {
      \       'right': [ [ 'lineinfo'  ],
      \                  [ 'fileformat', 'fileencoding', 'filetype'  ],
      \                  [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'  ]
      \                ],
      \       'left': [ [ 'mode', 'paste'  ],
      \                 [ 'readonly', 'filename', 'modified' ],
      \                 [ 'tagbar' ]
      \               ],
      \ }
let g:lightline.component = {
      \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}'
      \    }

" CtrlP
" NOT USING CTRLP ANYMORE - FZF is much faster. Settings are here in case FZF
" is unavailable (for some reason).
" Make ctrlp a lot faster in git repositories
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" " let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
" " let g:ctrlp_user_command = 'mdfind -onlyin %s file'
" let g:ctrlp_use_caching = 0 " ag is so fast that caching isn’t necessary
" let g:ctrlp_max_files = 10000
" let g:ctrlp_working_path_mode = 'r' " Always use the current working directory rather than the location of the current file
" let g:ctrlp_by_filename = 1 " Default to filename only search rather than searching the whole path.  This is more like Xcode's Shift+Cmd+O
"
"
" " Ignore some folders and files for CtrlP indexing
" let g:ctrlp_custom_ignore = {
  " \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  " \ 'file': '\.so$\|\.dat$|\.DS_Store$\|\.pyc$\|\.*.sw.'
  " \ }


" FZF
" Find in files/find tags
let g:fzf_prefer_tmux = 1
noremap <C-F> :Ag<cr>
noremap <C-T> :Tags<cr>
noremap <C-p> :Files<cr>

" EasyMotion
" let g:EasyMotion_do_mapping = 0 Disable default mappings
" map f <Plug>(easymotion-overwin-f)
nmap <leader>F <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" FuzzyFinder
map <F3> :FufFileWithFullCwd<CR>

" TMUX INTEGRATION #tmux
" autoswap
set title titlestring=
let g:autoswap_detect_tmux = 1

" SentinelOne/work-related #work
" My own code to format S1 logs.
function! SentinelLogs()
    :set filetype=python
    :silent! %s/true/True/g
    :silent! %s/false/False/g
    :ALEFix
endfunction
autocmd BufRead */SentinelLog_*/match_reports/* call SentinelLogs()
autocmd VimEnter */SentinelLog_*/match_reports/* echom "Pretty-formatted Sentinel log file."

" s1-arbiter syntax highlighting
au BufRead,BufNewFile arbiter.txt set filetype=s1arbiter
au! Syntax s1arbiter source $HOME/.vim/s1arbiter/s1arbiter.vim


" VIM PLUGGED #plugins
call plug#begin()
" Language Features
if (has('python') || has('python3'))
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " our lord and savior
endif
Plug 'w0rp/ale' " async python analysis
Plug 'davidhalter/jedi-vim' " used mostly for refactor
Plug 'gregsexton/MatchTag' " match pairs in HTML and XML (blue highlight)
Plug 'tmhedberg/matchit' " match pairs in HTML and XML with %
Plug 'rhysd/vim-clang-format' "  autoformat C family code
Plug 'gilligan/vim-lldb' " lldb debuuger integrated into vim
Plug 'msanders/cocoa.vim' " objective c support

" Source Control
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'airblade/vim-gitgutter' " git diff in column line

" Visible
Plug 'joshdick/onedark.vim' " colorscheme
Plug 'itchyny/lightline.vim' " better status line
Plug 'maximbaz/lightline-ale' " ALE plugin for lightline
Plug 'majutsushi/tagbar' " show tags in statusbard
Plug 'tyru/current-func-info.vim' " show function name in statusbar
Plug 'Yggdroot/indentLine' " visualize indentation levels

" Browsing
Plug 'vim-scripts/FuzzyFinder' " fuzzy file browser
Plug 'airblade/vim-rooter' " manage root directory according to .git files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " install fzf utility
Plug 'junegunn/fzf.vim'   " quickly search in files
" Plug 'kien/ctrlp.vim' " quick search bar - replaced with FZF

" Tags
Plug 'ludovicchabant/vim-gutentags' " auto generate tags for projects
Plug 'vim-scripts/ctags.vim' " support for ctags

" Misc
Plug 'scrooloose/nerdcommenter' " autocomment
Plug 'Raimondi/delimitMate' " auto add indent and } on newline
Plug 'tpope/vim-surround' " support more surrounds
Plug 'tpope/vim-dispatch' " background tasks in vim
Plug 'tpope/vim-repeat' " expand actions performed by .
Plug 'christoomey/vim-tmux-navigator' " integrate with tmux
Plug 'tpope/vim-obsession' " better VIM session restoration
Plug 'vim-scripts/L9' " library required for other plugins
Plug 'vim-utils/vim-man' " man pages in vim
Plug 'ciaranm/detectindent' " auto set indentation according to current file indentation
Plug 'easymotion/vim-easymotion' " quickly jump to letters
Plug 'vim-scripts/camelcasemotion' " ',w', ',b', ',e' to navigate camelcase
Plug 'Galgofrit/vim-base64' " encode and decode base64 within VIM
Plug 'Shougo/vinarise.vim' " hex editor

call plug#end()


" Colorscheme #color #theme
" These are required for OneDark to look natural. This bit is sometimes
" required for Tmux (but I have never had troubles without it).
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" if (empty($TMUX))
  " if (has("nvim"))
  " "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  " endif
  " "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  " "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  " if (has("termguicolors"))
    " set termguicolors
  " endif
" endif

let g:onedark_color_overrides = {
 \ "black": {"gui": "#ffffff", "cterm": "0", "cterm16": "0" }
\}
colorscheme onedark
set background=dark " for the dark version
