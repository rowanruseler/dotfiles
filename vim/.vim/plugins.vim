" Plugins, Vundle
" Brief help
" :PluginList     - lists configured plugin
" :PluginInstall  - installs plugins; append `!` to update
" :PluginSearch   - searche pattern; append `!` to refresh local cache
" :PluginClean    - confirms removal of unused plugins
" see :help vundle for more details
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'rodjek/vim-puppet'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'reedes/vim-pencil'
Plugin 'reedes/vim-colors-pencil'
call vundle#end()

" Plugin configurations
" The NERD tree
let g:NERDTreeChDirMode=1                                                                                                                                  

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=2
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_wq=1
let g:syntastic_check_on_open=0

" ctrlp.vim
let g:ctrl_tjump_only_silent=1
let g:ctrl_tjump_shortener=['/home/.*/gems/', '.../']

" vim-airline
let g:airline_theme='pencil'
let g:pencil_gutter_color=1
let g:pencil_spell_undercurl=1
let g:pencil_neutral_code_bg=1
let g:pencil_neutral_headings=1
let g:pencil_terminal_italics=1
let g:pencil_higher_contrast_ui=0
