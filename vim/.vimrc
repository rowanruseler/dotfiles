" The stupid content editor
"
" Maintainer: Rowan Ruseler <rowanruseler@gmail.com>
" Last change:	2017 Sep 21
"
" This is my personal vimrc, alot of settings are used from the defaults.vim
" located at: https://github.com/vim/vim/
" Beware that this is not an exact copy!

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocomptable
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200       " keep 200 lines of command line history
set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands
set wildmenu          " display completion matches in a status line

set ttimeout          " time out for key codes
set ttimeoutlen=100   " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: https://www.archlinux.org/download/

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after insert a line break.
" Revert with ":iunmap <C-u>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_string".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" End of the defaults vimrc,
" Commit: 9a48961
" patch: 8.0.0639

" Number of colors
set t_Co=256

" Use {color} for the background
set background=dark

" I like the line number relative to the line with the cursor in front of
" each line.
set nonumber
set relativenumber

" Copy indent from current line when starting a new line
set autoindent

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
" Spaces are used in indents with the '>' and '<' commands and when
" 'autoindent' is on.
set expandtab

" Number of spaces that <Tab> in the file counts for.
set tabstop=4
set shiftwidth=2
set softtabstop=2

" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'.
set smarttab

" Highlight the screen line of the cursor.  Useful to easily spot the cursor.
" Woll make screen redrawing slower.
set cursorline

" While typing a search command, show where the pattern, as it was typed so
" far, matches.  The matched string is highlighted.  If the pattern is invalid
" or not found, nothing is shown.
set incsearch

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" Ignore case when the pattern contains lowercase letters only.
set ignorecase

" When this option is set, the current window scrolls as other scrollbind
" windows (windows that also have this option set) scroll.
set noscrollbind

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" When off, all folds are open.  This option can be used to quickly switch
" between showing all text unfolded and viewing the text with folds (including
" manually opened or closed folds).
set foldenable
set foldmethod=indent

" Strings to use in 'list' mode and for the :list command.  It is a comma
" separated list of string settings.
set listchars=eol:¬,tab:\▸\ ,trail:~,extends:>,precedes:<

" A tag is an identifier that appears in a "tags" file.
set tags=./tags

" Keybind
source ~/.vim/keybind.vim

" Pencil
source ~/.vim/pencil.vim

" Plugins
source ~/.vim/plugins.vim
