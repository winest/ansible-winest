set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

set t_Co=256
let g:colors_name = "winest-colors"



"Comment          any comment
"Todo             anything that needs extra attention; mostly the keywords TODO FIXME and XXX
hi Comment        guifg=#5FDF5F guibg=NONE guisp=#FF0000 gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Todo           guifg=#5FDF5F guibg=NONE guisp=#FF0000 gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE

"Constant         any constant
"String           a string constant like 'this is a string' 'std'
"Character        a character constant  'c', '\n'
"Number           a number constant  234, 0xff
"Boolean          a boolean constant  TRUE, false
"Float            a floating point constant  2.3e10
hi Constant       guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi String         guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Character      guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Number         guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Boolean        guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Float          guifg=#800000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE

"Special          any special symbol
"SpecialChar      special character in a constant
hi Special        guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SpecialChar    guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi ExtraWhiteSpace guifg=NONE guibg=#808000 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=1 cterm=NONE
match ExtraWhiteSpace /\s\+$/
autocmd BufWinEnter * match ExtraWhiteSpace /\s\+$/
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"Identifier       any variable name
"Function         function name (also  methods for classes)
hi Identifier     guifg=#D0D0D0 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=252 ctermbg=NONE cterm=NONE
hi Function       guifg=#FFDF00 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=220 ctermbg=NONE cterm=NONE

"Statement        any statement
"Conditional      if, then, else, endif, switch, etc.
"Repeat           for, do, while, etc.
"Label            case, default, etc.
"Operator         'sizeof', '+', '*', etc.
"Keyword          any other keyword
"Exception        try, catch, throw
hi Statement      guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Conditional    guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Repeat         guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Label          guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Operator       guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Keyword        guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Exception      guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD

"Type             int, long, char, etc.
"StorageClass     static, register, volatile, etc.
"Structure        struct, union, enum, etc.
"Typedef          A typedef
hi Type           guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=NONE
hi StorageClass   guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=NONE
hi Structure      guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=BOLD
hi Typedef        guifg=#00DFFF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=45 ctermbg=NONE cterm=NONE

"PreProc          generic Preprocessor
"Include          preprocessor #include
"Define           preprocessor #define
"Macro            same as Define
"PreCondit        preprocessor #if, #else, #endif, etc.
hi PreProc        guifg=#FFAF5F guibg=NONE guisp=#FF0000 gui=BOLD ctermfg=215 ctermbg=NONE cterm=BOLD
hi Include        guifg=#FFAF5F guibg=NONE guisp=#FF0000 gui=BOLD ctermfg=215 ctermbg=NONE cterm=BOLD
hi Define         guifg=#FFAF5F guibg=NONE guisp=#FF0000 gui=BOLD ctermfg=215 ctermbg=NONE cterm=BOLD
hi Macro          guifg=#FFAF5F guibg=NONE guisp=#FF0000 gui=BOLD ctermfg=215 ctermbg=NONE cterm=BOLD
hi PreCondit      guifg=#FFAF5F guibg=NONE guisp=#FF0000 gui=BOLD ctermfg=215 ctermbg=NONE cterm=BOLD

"Tag              you can use CTRL-] on this
"Delimiter        character that needs attention
"SpecialComment   special things inside a comment
"Debug            debugging statements
hi Tag            guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Delimiter      guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Debug          guifg=#808000 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE

"Underlined       text that stands out, HTML links
hi Underlined     guifg=#0000FF guibg=NONE guisp=#FF0000 gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE

"Ignore           left blank, hidden  |hl-Ignore|
hi Ignore         guifg=NONE guibg=NONE guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE

"Error            any erroneous construct
hi WarningMsg     guifg=NONE guibg=NONE guisp=#FF0000 gui=UNDERCURL ctermfg=160 ctermbg=NONE cterm=UNDERLINE
hi Error          guifg=NONE guibg=NONE guisp=#FF0000 gui=UNDERCURL ctermfg=160 ctermbg=NONE cterm=UNDERLINE
hi ErrorMsg       guifg=NONE guibg=NONE guisp=#FF0000 gui=UNDERCURL ctermfg=160 ctermbg=NONE cterm=UNDERLINE
hi SpellBad       guifg=NONE guibg=NONE guisp=#FF0000 gui=UNDERCURL ctermfg=160 ctermbg=NONE cterm=UNDERLINE

"LineNr           line number
"CursorLine       cursorline in vim
"StatsLine        statusline in vim
"Visual           selection in visual mode
hi LineNr         guifg=#606060 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE
hi CursorLine     guifg=NONE guibg=#000087 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=18 cterm=NONE
hi StatusLine     guifg=#000080 guibg=NONE guisp=#FF0000 gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Visual         guifg=NONE guibg=#606060 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE

"DiffAdd          new line
"DiffDelete       deleted line
"DiffChange       changed line
"DiffText         changed text in changed line
hi DiffAdd        guifg=NONE guibg=#0000AF guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=19 cterm=NONE
hi DiffDelete     guifg=NONE guibg=#AF0000 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=124 cterm=NONE
hi DiffChange     guifg=NONE guibg=#5F0087 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=54 cterm=NONE
hi DiffText       guifg=NONE guibg=#5F5F00 guisp=#FF0000 gui=NONE ctermfg=NONE ctermbg=58 cterm=NONE
