"==========================================================
" File:        python_quick_radon.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 9-Mar-2015.
" Version:     0.1.1
" WebPage:     https://github.com/tell-k/vim-quick-radon
" License:     MIT Licence
"==========================================================
" see also README.rst

" Only do this when not done yet for this buffer
if exists("b:loaded_quick_radon_ftplugin")
   finish
endif

let b:loaded_quick_radon_ftplugin=1
let s:radon_current_buffer=''

if !exists("*QuickRadon()")

    function JumpToLine()
        let line=getline('.')
        let words=split(line, " ")
        let line_pos=split(words[1], ":")
        if len(line_pos) < 2
          return
        endif
        silent execute bufwinnr(bufnr(s:radon_current_buffer)).'wincmd w'
        silent execute ':normal ' . line_pos[0] . 'gg'
    endfunction

    function QuickRadon()

        if bufnr("quick_radon") > 0
            silent execute "bdelete " . bufnr("quick_radon")
        endif

        let s:radon_current_buffer=bufnr("%")
        if exists("g:radon_cmd")
            let s:radon_cmd=g:radon_cmd
        else
            let s:radon_cmd="radon"
        endif

        if !executable(s:radon_cmd)
            echoerr "File " . s:radon_cmd . " not found. Please install it first."
            return
        endif

        let target_file = expand('%')

        botright new quick_radon
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        silent execute '$read !echo "[ Cyclomatic Complexity ]"'
        silent execute '$read !radon cc ' . target_file
        silent execute '$read !echo "[ Maintainability Index ]"'
        silent execute '$read !radon mi ' . target_file
        silent execute '$read !echo "[ Raw Metrics ]"'
        silent execute '$read !radon raw ' . target_file
        setlocal wrap
        setlocal filetype=stdin
        silent execute ':normal gg1dd'
        silent execute ':normal ggj1dd'
        silent execute ':normal G10kdd'
        silent execute ':%s/^    //g'
        silent execute ':noh'
        silent execute ':normal gg'

        setlocal nomodifiable
        syntax match Number /-\sA$/
        syntax match NonText /-\sB$/
        syntax match ModeMsg /-\sC$/
        syntax match NonText /^M /
        syntax match Number /^C /
        syntax match ModeMsg /^F /
        set nolazyredraw
        redraw!
        noremap <buffer> <Enter> :call JumpToLine()<CR>
    endfunction

endif

if !exists("no_plugin_maps") && !exists("no_quick_radon_maps")
    if !hasmapto('QuickRadon(')
        command! -bar QuickRadon call QuickRadon() 
    endif
endif
