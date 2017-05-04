set nocompatible | filetype indent plugin on | syn on

" Enable 256 colors
set t_Co=256

fun! SetupVAM()
	let c = get(g:, 'vim_addon_manager', {})
	let g:vim_addon_manager = c
	let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
	" most used options you may want to use:
	" let c.log_to_buf = 1
	" let c.auto_install = 0
	let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
	if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
		execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
					\       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
	endif
	call vam#ActivateAddons([], {'auto_install' : 0})
endfun

let g:vim_addon_manager = {'scms': {'git': {}}}
fun! MyGitCheckout(repository, targetDir)
	let a:repository.url = substitute(a:repository.url, '^git://github', 'https://github', '')
	return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun
let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']

call SetupVAM()

" YouCompleteMe requires recompiles
VAMActivate
 \ vim-fugitive
 \ vim-gitgutter
 \ editorconfig-vim
 \ vim-spec
 \ nerdtree 
 \ tlib_vim
 \ vim-addon-commenting
 \ vim-autoformat
 \ vim-jade
 \ vim-cucumber
 \ matchit
 \ restore_view.vim
 \ vim-ruby
 \ YouCompleteMe
 \ tern_for_vim
 \ ctrlp.vim
 \ vim-pug
 \ vim-es6
 \ html5-syntax.vim
 \ html5.vim
 \ javascript-libraries-syntax.vim
 \ typescript-vim
 \ yats.vim
 \ vim-colorschemes
 \ syntastic
 \ mango.vim

set background=dark

"colorscheme monokai
"colorscheme mango
colorscheme apprentice

set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

set backspace=indent,eol,start
set t_ut=
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set paste

set foldenable
set foldlevelstart=10
set foldnestmax=30
set foldmethod=indent
set runtimepath^=~/.vim/vim-addons/ctrlp.vim

let mapleader=","
let g:NERDTreeDirArrows=0
let g:multi_cursor_exit_from_insert_mode=0
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v.*(git|hg|svn|node_modules|sass-cache|coverage|dist).*$',
			\ 'file': '\v\.(exe|so|dll|zip|swp|tmp)$',
			\ }
let g:rspec_command = "!bundle exec rspec -I . -f d -c $PWD/{spec}"
let g:mocha_js_command = "!mocha --recursive {spec}"

syntax on
filetype plugin indent on

noremap <F7> :Autoformat<CR><CR>
noremap <F8> :CtrlP<CR><CR>

nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-E> :TagbarToggle<CR>

map <Leader>r :TernRename<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

au FileType jade setl sw=2 sts=2 et
au FileType styl setl sw=2 sts=2 et

" YouCompleteMe configuration
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_strings = 0
let g:ycm_log_level = 'error'

" Syntastic Configuration
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_args = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

" Setup tabbing
map [ :tabp<CR>
map ] :tabn<CR>

" Auto remove whitespace when saving
" autocmd BufWritePre * %s/\s\+$//e
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
