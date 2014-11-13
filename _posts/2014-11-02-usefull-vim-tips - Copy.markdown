---
layout: post
categories: EN tooling
title: Useful Vim tips
---


My vimrc can be viewed [here](https://github.com/andriniaina/playground/tree/master/vim).

.gitconfig
====================================

Use vim as the default diff tool
------------------

    [diff]
        tool = vimdiff
        guitool = gvim_andri
    [merge]
        tool = gvim_andri
    [mergetool "gvim_andri"]
        cmd = "\"D:/Program Files/Vim/vim74/gvim.exe\" -d "$(pwd -W)/$BASE" "$(pwd -W)/$MERGED" "$(pwd -W)/$LOCAL" && rm "$(pwd -W)/$BASE" && rm "$(pwd -W)/$LOCAL" && rm "$(pwd -W)/$REMOTE"   "
    [difftool "gvim_andri"]
        cmd = "\"D:/Program Files/Vim/vim74/gvim.exe\" -d "$LOCAL" "$(pwd -W)/$MERGED" && rm "$LOCAL" "


.vimrc
=======================

Use persistent_undo
-----------------------------
Undo changes even after closing vim!

    " persistent undo
    if has("persistent_undo")
        set undodir=c:\temp\vim_undo
        if !isdirectory(&undodir)
            call mkdir(&undodir)
        end
        set undofile
    endif

Put your vimrc in another folder (Use a git repo to sync your vim files)
---------------------
In \\users\\USERID\\_vimrc:

    let $HOME='PATH_TO_GIT_REPO_CLONE'
    set runtimepath+=$HOME\vimfiles    " point to a new HOME
    source $HOME\_vimrc                " read the real vimrc from the git repo

Put plugins in another folder (Use git submodules to manage plugins instead of copying the files in your ~/vimfiles)
----------------------
Use this [pathogen.vim](http://www.vim.org/scripts/script.php?script_id=2332) plugin.

In your vimrc, add:

    execute pathogen#infect('~/submodules/{}')

Now clone any plugin in the submodules folder

    cd submodules
    git submodule add https://github.com/vim-scripts/FuzzyFinder.git

Always use the [git mirror of vim-script](https://github.com/vim-scripts) instead of donwloading a static copy from http://www.vim.org.


Tidy code (SQL, xml, html)
-------------------

Use this [tidy.vim](https://github.com/andriniaina/playground/blob/master/vim/vimfiles/plugin/tidy.vim) plugin. And then add these command mappings:

    command! -range=% TidySQL <line1>,<line2>call TidySQL()
    command! -range=% TidyXml <line1>,<line2>call TidyXml()
    command! TidyHtml call TidyHtml()
    command! TidyHtml5 call TidyHtml5()

You will also need to download a copy of [Poor man's T-SQL formatter](http://www.architectshack.com/PoorMansTSqlFormatter.ashx) and put it in your `$HOME` folder



Toggle fullscreen with F11
-------------------
Use this [fullscreen.vim](https://github.com/andriniaina/playground/blob/master/vim/vimfiles/plugin/fullscreen.vim) plugin. And then add these command mappings

    noremap <F11> :call ToggleFullscreen()<Cr>

Search
-----------------------

    set hlsearch  " highlight search
    set incsearch  " incremental search, search as you type
    set ignorecase " Ignore case when searching 
    set smartcase " Ignore case when searching lowercase

    " re-enable incremental search and then search
    nnoremap / :set incsearch \| set wrapscan<Cr>/
    nnoremap <C-h> :%s/

    " Substitute in selection
    vnoremap <C-h> :s/
    " Disable incremental search and search in selection
    vnoremap / :<c-u>set noincsearch \| set nowrapscan<Cr>gv/\%>'<\%<'>





Useful plugins
=======================

Command-t or CtrlP or FuzzyFinder
-----------------------
Open/filter files and buffers quickly

* FuzzyFinder is in native viml.
* Command-t and CtrlP respectively require Ruby and Python but are faster.
* asyncfinder.vim is even supposedly faster but is for linux only (uses the fnctl Python module).


Largefile
-----------------------
Open/edit large files quickly (disables all syntax and other slow plugins)

Vim-fugitive
-----------------------
git integration

vim-airline or powerline
-----------------------
Cool colorful status bar.

* vim-airline is native viml.
* powerline requires python

<img src="https://raw.githubusercontent.com/wiki/bling/vim-airline/screenshots/demo.gif" />

To enable the fancy characters:

1. Download the [patched fonts by eugeneching](https://github.com/eugeneching/consolas-powerline-vim). [Mirror](/assets/consolas-powerline-vim/CONSOLA-Powerline.ttf)
2. activate the font in your vimrc:

```
set guifont=Consolas_for_Powerline_FixedD:h11,Consolas:h11 " you can additional alternative fonts here if it's not available on a particular host or terminal
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_left_sep = "\u2b80"
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"
let g:airline_symbols.space = " "
let g:airline_symbols.whitespace = "\u02fd"
let g:airline_symbols.modified = "*"
```



