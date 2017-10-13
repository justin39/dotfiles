syntax enable
set ttimeoutlen=50
set background=dark
set number
set showcmd
set t_ut=
set autoindent
set hlsearch
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
colo one
set noshowmode
set laststatus=2
hi Normal guibg=NONE ctermbg=NONE
au FileType gitcommit set tw=72
:autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\<Esc>]50;CursorShape=1;BlinkingCursorEnabled=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2;BlinkingCursorEnabled=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\BlinkingCursorEnabled=0\x7"

let git_path = system("git rev-parse --show-toplevel 2>/dev/null")
let git_vimrc = substitute(git_path, '\n', '', '') . "/.vimrc"
if !empty(glob(git_vimrc)) && git_path" " != $HOME"\n"
    echo git_vimrc
    sandbox exec ":source " . git_vimrc
endif

let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'filename' ] ]
			\ },
			\ 'component_function': {
			\   'readonly': 'LightlineReadonly',
			\   'modified': 'LightlineModified',
			\		'filename': 'LightlineFilename'
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\ }

function! LightlineModified()
	if &filetype == "help"
		return ""
	elseif &modified
		return "+"
	elseif &modifiable
		return ""
	else
		return ""
	endif
endfunction

function! LightlineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return ""
	else
		return ""
	endif
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
				\ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
