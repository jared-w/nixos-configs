" https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
" https://github.com/22mahmoud/neovim
" https://github.com/nanotee/nvim-lua-guide/
function! VimrcLoadPlugins()
    " Install vim-plug if not available
    let plug_install = 0
    let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
    if !filereadable(autoload_plug_path)
        silent exe 'curl -fLo --create-dirs ' . autoload_plug_path .
                    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        execute 'source ' . fnameescape(autoload_plug_path)
        let plug_install = 1
    endif
    unlet autoload_plug_path

    for p in ['backup', 'swap', 'undo']
        if !isdirectory(stdpath('data') . p) | call mkdir(stdpath('data') . p, "p", 0755) | endif
    endfor

    call plug#begin('~/.local/share/nvim/plugged')

    " Linting + LSP
    Plug 'neoclide/coc.nvim', {'branch': 'feat/lsp-316', 'do': 'yarn install --frozen-lockfile'}
    " Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    Plug 'antoinemadec/coc-fzf'
    Plug '~/src/personal/vscode-hie-server', { 'do': 'yarn install --frozen-lockfile' }
    " Plug 'chitoku-k/coc-yaml', { 'branch': 'dependency-update',  'do': 'yarn install --frozen-lockfile' }
    Plug 'direnv/direnv.vim'
    Plug 'sbdchd/neoformat', { 'for' : ['terraform'] }
    Plug 'editorconfig/editorconfig-vim'
    " Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'p00f/nvim-ts-rainbow'
    " https://github.com/metakirby5/codi.vim

    " https://github.com/nvim-telescope/telescope.nvim
    " https://github.com/glepnir/lspsaga.nvim

    Plug 'honza/vim-snippets'
    " Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey','WhichKey!'] }
    Plug 'folke/which-key.nvim'
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    Plug 'lambdalisue/suda.vim'
    Plug 'farmergreg/vim-lastplace'
    " Plug 'cohama/lexima.vim'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug '907th/vim-auto-save'
    Plug 'blueyed/vim-diminactive'
    Plug 'camspiers/lens.vim'
    Plug 'wsdjeg/vim-fetch'
    Plug '~/src/personal/neuron.vim', { 'for': ['markdown'] }
    " Plug 'chiefnoah/neuron-v2.vim', { 'for': ['markdown'] }
    Plug 'antoinemadec/FixCursorHold.nvim'

    " filetype ]] [[
    Plug 'arp242/jumpy.vim'

    Plug 'tomtom/tcomment_vim'
    Plug 'tommcdo/vim-exchange'
    " g>, g<, gs
    Plug 'machakann/vim-swap'
    Plug 'airblade/vim-rooter'
    " Plug 'svermeulen/vim-subversive'

    " Plug 'liuchengxu/vista.vim'
    Plug 'rhysd/git-messenger.vim'
    " x[ and x] to jump conflicts
    " ct for top/them, co for bottom/us, cn for none, cb for both
    Plug 'rhysd/conflict-marker.vim'
    " Plug 'dhruvasagar/vim-zoom'
    " Plug 'voldikss/vim-floaterm'
    " Plug 'christoomey/vim-tmux-navigator'
    Plug 'tyru/open-browser.vim'

    Plug 'machakann/vim-sandwich'
    Plug 'wellle/targets.vim'
    Plug 'romainl/vim-cool'
    Plug 'andymass/vim-matchup'
    Plug 'ryanoasis/vim-devicons'
    " Plug 'adelarsq/vim-devicons-emoji'
    Plug 'jceb/vim-orgmode'

    Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
    Plug 'folke/tokyonight.nvim'

    " Languages
    Plug 'lervag/vimtex'
    Plug 'dkarter/bullets.vim'
    Plug 'sheerun/vim-polyglot'
    call plug#end()

    if plug_install || len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      PlugInstall --sync
    endif
    unlet plug_install
endfunction

function! VimrcLoadPluginSettings()
    " vim-cool
    let g:CoolTotalMatches = 1

    " vim-matchup
    let g:matchup_transmute_enabled = 1
    let g:matchup_matchparen_deferred = 1
    let g:matchup_matchparen_status_offscreen = 0
    let g:matchup_delim_stopline = 2500

    " lens.vim
    let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

    " vimtex
    let g:tex_flavor = 'latex'

    " nvim-treesitter
    luafile ~/.config/nvim/lua/setup-treesitter.lua

    " nvim-ts-rainbow
    lua << EOF
    require'nvim-treesitter.configs'.setup {
        rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 }
    }
EOF

    " fzf.vim
    let s:env_dict = {
                \ "FZF_PREVIEW_COMMAND": 'bat --style=numbers,changes --color always {}',
                \ "FZF_DEFAULT_OPTS": "--color=light --reverse ",
                \ "FZF_DEFAULT_COMMAND": 'fd -t f -L -H -E .git',
                \ "BAT_THEME": "ansi",
                \ }

    for [l:e, l:d] in items(s:env_dict)
        let l:_e = getenv(l:e)
        if l:_e == "" || l:_e == v:null
            call setenv(l:e, l:d)
        endif
    endfor

    let &shell = "bash"
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

    " fzf-preview.vim
    nnoremap <silent> <leader>f :<C-u>CocCommand fzf-preview.DirectoryFiles<CR>
    nnoremap <silent> <leader>h :<C-u>CocCommand fzf-preview.History<CR>
    nnoremap <silent> <leader>b :<C-u>CocCommand fzf-preview.Buffers<CR>
    nnoremap <silent> <leader><space> :<C-u>CocCommand fzf-preview.ProjectGrep .<CR>
    xnoremap <silent> <leader><space> y:Rg <C-R>"<CR>
    nnoremap <silent> <leader>/ :<C-u>CocCommand fzf-preview.Lines<CR>
    nnoremap <silent> <Leader>gs :<C-u>CocCommand fzf-preview.GitStatus<CR>
    let g:fzf_preview_use_dev_icons = 1
    let g:fzf_preview_git_status_preview_command =  "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} || " .
                \ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} || " .
                \ 'bat --color=always --plain {-1}'

    " coc.nvim
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-rename)
    nmap <silent> gR <Plug>(coc-references)
    nmap <silent> K :call CocActionAsync('doHover')<CR>
    nmap <silent> gz <Plug>(coc-refactor)
    nmap <silent> gl <Plug>(coc-codelens-action)

    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    function! s:cocActionsOpenFromSelected(type) abort
        execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> ga :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> ga :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

    nmap <silent> gA <Plug>(coc-fix-current)
    nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
    nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)

    let g:coc_filetype_map = {
          \ 'yaml.ansible': 'yaml',
          \ 'markdown.neuron':'markdown'
          \ }

    let g:coc_global_extensions = [
                \ 'coc-actions',
                \ 'coc-cfn-lint',
                \ 'coc-clangd',
                \ 'coc-cmake',
                \ 'coc-css',
                \ 'coc-cssmodules',
                \ 'coc-diagnostic',
                \ 'coc-dictionary',
                \ 'coc-docker',
                \ 'coc-emmet',
                \ 'coc-emoji',
                \ 'coc-eslint',
                \ 'coc-fzf-preview',
                \ 'coc-git',
                \ 'coc-highlight',
                \ 'coc-html',
                \ 'coc-json',
                \ 'coc-lua',
                \ 'coc-pairs',
                \ 'coc-prettier',
                \ 'coc-pyright',
                \ 'coc-python',
                \ 'coc-rust-analyzer',
                \ 'coc-sh',
                \ 'coc-snippets',
                \ 'coc-tslint-plugin',
                \ 'coc-tsserver',
                \ 'coc-vetur',
                \ 'coc-vimlsp',
                \ 'coc-vimtex',
                \ 'coc-word',
                \ 'coc-yaml'
                \ ]

    let g:coc_fzf_preview = ''
    let g:coc_fzf_opts = []

    augroup coc
        au!
        au CompleteDone * if pumvisible() == 0 | pclose | endif
        au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        au CursorHold * silent! call CocActionAsync('highlight')
        au User CocQuickfixChange :CocFzfList --normal quickfix
    augroup END

    " inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<Tab>"
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " inoremap <expr> <S-Tab> "\<C-h>"
    inoremap <silent><expr> <c-space> coc#refresh()

    inoremap <silent><expr> <TAB>
                \ pumvisible() ? coc#_select_confirm() :
                \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<Tab>'
    let g:coc_snippet_prev = '<S-Tab>'

    xmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

    nmap <silent> <leader>c :CocCommand<CR>
    nmap <silent> <leader>lo :<C-u>CocFzfList outline<CR>
    nmap <silent> <leader>ls :<C-u>CocFzfList -I symbols<CR>
    nmap <silent> <leader>ld :<C-u>CocFzfList diagnostics<CR>

    nmap gp <Plug>(coc-git-prevchunk)
    nmap gn <Plug>(coc-git-nextchunk)

    " neoformat
    " see also: after/ftplugin/terraform
    let g:neoformat_only_msg_on_error = 1
    command! NeoformatDisable au! neoformat

    " " vista.vim
    " let g:vista#renderer#enable_icon = 1
    " let g:vista_fzf_preview = ['right:40%']
    "
    " let g:vista_echo_cursor_strategy = 'floating_win'
    " nnoremap <silent> <C-t> :Vista finder<CR>

    " " vim-floaterm
    " let g:floaterm_position = 'center'
    " let g:floaterm_winblend = 30
    " let g:floaterm_keymap_toggle = '<F12>'

    " " vim-tmux-navigation
    " let g:tmux_navigator_no_mappings = 1
    " nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
    " nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
    " nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
    " nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

    " targets.vim
    autocmd User targets#mappings#user call targets#mappings#extend({
                \ 'a': {'argument': [{'o': '[({[]', 'c': '[]})]', 's': ','}]}
                \ })

    " bullets.vim
    let g:bullets_enabled_file_types = ['markdown', 'markdown.neuron', 'text', 'gitcommit']
    let g:bullets_outline_levels = ['num', 'std-']

    " vim-polyglot
    let g:haskell_enable_quantification = 1
    let g:haskell_enable_pattern_synonyms = 1
    let g:haskell_enable_typeroles = 1
    let g:php_html_load = 1
    let g:vim_jsx_pretty_colorful_config = 1
    let g:vim_jsx_pretty_template_tags = []
    let g:vim_markdown_new_list_item_indent = 0
    let g:vim_markdown_auto_insert_bullets = 0
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_toml_frontmatter = 1
    let g:vim_markdown_json_frontmatter = 1
    let g:vim_markdown_strikethrough = 1

    " vim-easy-align
    xmap <CR> <Plug>(EasyAlign)

    " vim-exchange
    xmap gx <Plug>(Exchange)

    " vim-auto-save
    let g:auto_save = 1
    let g:auto_save_events = ["FocusLost"]

    " sandwich.vim
    let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

    " " vim-which-key
    " nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
    lua << EOF
    require("which-key").setup {
        plugins = { spelling = { enabled = true, }, },
    }
EOF

    " " chadtree
    " nnoremap <leader>v <cmd>CHADopen<cr>

    " suda.vim: Write file with sudo
    command! W :w suda://%

    " " firenvim
    " let g:firenvim_config = { 'localSettings': {}, 'globalSettings': {} }
    " let ls = g:firenvim_config['localSettings']
    " let ls['.*'] = {'takeover':'never', 'cmdline': 'firenvim' }
    " function! s:IsFirenvimActive(event) abort
    "   if !exists('*nvim_get_chan_info')
    "     return 0
    "   endif
    "   let l:ui = nvim_get_chan_info(a:event.chan)
    "   return has_key(l:ui, 'client') && has_key(l:ui.client, "name") &&
    "         \ l:ui.client.name is# "Firenvim"
    " endfunction
    " let g:dont_write = v:false
    " function! My_Write(timer) abort
    "   let g:dont_write = v:false
    "   write
    " endfunction
    "
    " function! Delay_My_Write() abort
    "   if g:dont_write
    "     return
    "   end
    "   let g:dont_write = v:true
    "   call timer_start(1000, 'My_Write')
    " endfunction
    "
    " function! OnUIEnter(event) abort
    "   if s:IsFirenvimActive(a:event)
    "     setl noconfirm noshowmode noshowcmd noruler nonumber
    "     setl laststatus=0 shortmess+=F cmdheight=1
    "
    "     let l:bufname=expand('%:t')
    "     if l:bufname =~? 'github.com'
    "       set ft=markdown
    "     elseif l:bufname =~? 'cocalc.com' || l:bufname =~? 'kaggleusercontent.com'
    "       set ft=python
    "     elseif l:bufname =~? 'localhost'
    "       " Jupyter notebooks don't have any more specific buffer information.
    "       " If you use some other locally hosted app you want editing function
    "       " in, set it here.
    "       set ft=python
    "     elseif l:bufname =~? 'reddit.com'
    "       set ft=markdown
    "     elseif l:bufname =~? 'stackexchange.com' || l:bufname =~? 'stackoverflow.com'
    "       set ft=markdown
    "     elseif l:bufname =~? 'slack.com' || l:bufname =~? 'gitter.com' || l:bufname =~? 'mattermost\..\+.com'
    "       set ft=markdown
    "       normal! i
    "       inoremap <CR> <Esc>:w<CR>:call firenvim#press_keys("<LT>CR>")<CR>ggdGa
    "       inoremap <s-CR> <CR>
    "     endif
    "
    "     nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
    "     nnoremap <C-z> :call firenvim#hide_frame()<CR>
    "     au TextChanged * ++nested call Delay_My_Write()
    "     au TextChangedI * ++nested call Delay_My_Write()
    "     startinsert
    "   endif
    " endfunction
    " autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
endfunction

function! VimrcLoadMappings()
    " General thoughts:
    "   Operator + non-motion is an 'invalid operation' in vim
    "   oprator + second operator is also 'invalid'
    "   With those in mind, there are lots of empty binds in
    "   vim available

    "Insert new lines in normal mode
    nnoremap <silent> go :pu _<CR>:'[-1<CR>
    nnoremap <silent> gO :pu! _<CR>:']+1<CR>

    nnoremap Y y$

    " Replace cursor under word. Pressing . will move to next match and repeat
    nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
    nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

    " Delete cursor under word. Pressing . will move to next match and repeat
    nnoremap d* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``dgn
    nnoremap d# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``dgN

    " Search for current selection when pressing * or # in visual mode
    xnoremap <silent> * :call VisualSearchCurrentSelection('f')<CR>
    xnoremap <silent> # :call VisualSearchCurrentSelection('b')<CR>

    nnoremap <silent> <C-j> :m .+1<CR>==
    nnoremap <silent> <C-k> :m .-2<CR>==
    inoremap <silent> <C-j> <Esc>:m .+1<CR>==gi
    inoremap <silent> <C-k> <Esc>:m .-2<CR>==gi
    xnoremap <silent> <C-j> :m '>+1<CR>gv=gv
    xnoremap <silent> <C-k> :m '<-2<CR>gv=gv

    xnoremap < <gv
    xnoremap > >gv
endfunction

function! VimrcLoadSettings()
    set title
    set nojoinspaces
    set inccommand=nosplit
    set pumblend=30
    set winblend=30
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set hidden " Required for coc.nvim
    set mouse=a " coc.nvim scrolling
    set complete+=k
    set completeopt=menu,menuone,noinsert
    set nrformats=bin,hex,octal,alpha
    set breakindent
    set clipboard=unnamedplus
    set backup
    set undofile
    set lazyredraw
    set virtualedit=block
    set dir=$XDG_DATA_HOME/nvim/swap//
    set undodir=$XDG_DATA_HOME/nvim/undo//
    set backupdir=$XDG_DATA_HOME/nvim/backup//
    set noerrorbells visualbell t_vb=
    set list
    set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:⌴
    set showbreak=↪\ \ 
    set fillchars=diff:⣿,vert:│,fold:\
    set scrolloff=2
    set sidescrolloff=2
    set number
    set shortmess+=caIA

    " breaks popup windows
    " set winwidth=79
    " set winheight=50

    " not needed with vim-sleuth (implemented by polyglot)
    " set expandtab
    " set softtabstop=2
    " set shiftwidth=2

    set ignorecase " Required so that smartcase works
    set smartcase
    set noshowmatch
    set nowrap
    set nofoldenable

    set redrawtime=10000
    set synmaxcol=500
    set termguicolors
    " fixcursorhold.nvim
    " set updatetime=100
    set updatetime=4001 " don't get overridden by sensible
    let g:cursorhold_updatetime = 100
    set splitright
    set splitbelow
    set nofixendofline
    set pyx=3

    let g:netrw_dirhistmax=0
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)

    if has('nvim-0.3.2') || has("patch-8.1.0360")
        set diffopt=filler,internal,algorithm:histogram,indent-heuristic
    endif
    set diffopt+=hiddenoff

    augroup vimrc_settings
        au!
        au BufWritePost $MYVIMRC nested source $MYVIMRC
        au BufWritePost $MYVIMRC
                    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                    \|   PlugInstall --sync | q
                    \| endif
        " au VimEnter * call vista#RunForNearestMethodOrFunction()
        au VimEnter * set title
    augroup END

    augroup win_resize
        au!
        au VimResized * wincmd =
    augroup END

    set statusline=%f\ %h%w%m%r%=%{NearestMethodOrFunction()}%-8.(%)\ %-14.(%l,%c%V%)\ %P

    augroup LuaHighlight
        au!
        au TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
endfunction

function! VimrcLoadFiletypeSettings()
    let g:LargeFile = 1024 * 768 * 1
    augroup LargeFile
        au!
        au BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
    augroup END
endfunction

function! DoColors()
    if filereadable(expand("~/.local/share/theme"))
        let l:theme = readfile(expand("~/.local/share/theme"))[0]
        let g:tokyonight_style = l:theme == "dark" ? "night" : "day"
        execute 'set background=' . l:theme
        colorscheme tokyonight
    end
endfunction

function! VimrcLoadColors()
    call DoColors()
    if filereadable(expand("~/.local/share/theme"))
        call timer_start(60000, {-> DoColors()}, {'repeat': -1})
    else
        let g:tokyonight_style = "day"
        colorscheme tokyonight
    endif
    hi! Comment gui=italic
    hi MatchParen guibg=none gui=italic
    hi SignColumn guibg=none
    hi LineNr guibg=none
    hi DiffChange guibg=none
    hi DiffText guibg=none
endfunction

let g:mapleader = "\<Space>"
" let g:polyglot_disabled = ['sensible']
" let g:polyglot_disabled = ['autoindent']
let g:python_host_skip_check=1 " disable python2
let g:loaded_python_provider=1 " disable python2

call VimrcLoadPlugins()
call VimrcLoadPluginSettings()
call VimrcLoadMappings()
call VimrcLoadSettings()
call VimrcLoadFiletypeSettings()
call VimrcLoadColors()
