" PALLETE
" #d3d0d8 #999999 #f2777a #99cc99 #ffcc66 #66cccc #6699cc #cc99cc #f99157
" #33343a #27282d

" normal colors
let s:fg = "d7d7d7"
let s:co = "8e8e8e"
let s:re = "ff8787"
let s:or = "ff875f"
let s:ye = "ffd787"
let s:gr = "85d485"
let s:aq = "5fd7d7"
let s:bl = "5f87d7"
let s:pu = "d787d7"

" sped colors
let s:bg = "27282d"
let s:se = "33343a"
let s:wi = "27282d"

" setting up
set background=dark
hi clear 
hi clear Search
syntax reset
let g:colors_name = "eight"

fun <SID>yo(group, gfg, gbg, att)
    if a:group != ""
        if a:gfg != ""
            exec "hi " . a:group . " guifg=#" . a:gfg
        endif
        if a:gbg != ""
            exec "hi " . a:group . " guibg=#" . a:gbg
        endif	
        if a:att != ""
            exec "hi " . a:group . " gui=" . a:att . " cterm=" a:att
        elseif a:att == ""
            exec "hi " . a:group . " gui=none" . " cterm=none"
        endif
    endif
endfun

" kill me
" VIM
call <SID>yo("Normal",                  s:fg, s:bg, "")
call <SID>yo("LineNr",                  s:se, "", "")
call <SID>yo("ErrorMsg",                s:se, s:re, "")
call <SID>yo("Error",                   s:se, s:re, "")
call <SID>yo("NonText",                 s:se, "", "")
call <SID>yo("SpecialKey",              s:se, "", "")

call <SID>yo("Search",                  "", s:se, "bold")
call <SID>yo("TabLine",                 s:co, s:bg, "")
call <SID>yo("TabLineSel",              s:re, s:bg, "")
call <SID>yo("TabLineFill",	            s:re, s:bg, "")

call <SID>yo("StatusLine",	            s:co, "", "")
call <SID>yo("StatusLineNC",            s:bg, s:se, "")   
call <SID>yo("WildMenu",                s:re, s:bg, "")

call <SID>yo("VertSplit",               s:fg, s:se, "") 
call <SID>yo("Visual",                  "", s:se, "") 
call <SID>yo("Directory",               s:bl, "", "") 
call <SID>yo("ModeMsg",                 s:gr, "", "bold")
call <SID>yo("MoreMsg",                 s:gr, "", "bold") 
call <SID>yo("Question",                s:gr, "", "")
call <SID>yo("Warningmsg",              s:re, "", "")
call <SID>yo("MatchParen",              "", s:se, "") 
call <SID>yo("Folded",                  s:co, s:bg, "") 
call <SID>yo("FoldColumn",              "", s:bg, "") 
call <SID>yo("CursorLine",              "", s:bg, "") 
call <SID>yo("CursorLineNr",            s:co, "", "")
call <SID>yo("CursorColumn",            "", s:bg, "") 
call <SID>yo("PMenu",                   s:fg, s:se, "") 
call <SID>yo("PMenuSel",                s:fg, s:se, "") 
call <SID>yo("SignColumn",              "", s:bg, "")
call <SID>yo("ToolbarLine",             "", s:se, "")
call <SID>yo("ColorColumn",             "", s:se, "")

" STANDARD
call <SID>yo("Comment",                 s:co, "", "") 
call <SID>yo("Todo",                    s:co, s:bg, "") 
call <SID>yo("Title",                   s:co, "", "") 
call <SID>yo("Identifier",              s:re, "", "") 
call <SID>yo("Statement",               s:fg, "", "") 
call <SID>yo("Conditional",             s:fg, "", "") 
call <SID>yo("Repeat",                  s:fg, "", "") 
call <SID>yo("Structure",               s:pu, "", "") 
call <SID>yo("Function",                s:bl, "", "") 
call <SID>yo("Constant",                s:or, "", "") 
call <SID>yo("Keyword",                 s:or, "", "") 
call <SID>yo("String",                  s:gr, "", "") 
call <SID>yo("Special",                 s:fg, "", "") 
call <SID>yo("PreProc",                 s:pu, "", "") 
call <SID>yo("Operator",                s:aq, "", "") 
call <SID>yo("Type",                    s:bl, "", "") 
call <SID>yo("Define",                  s:pu, "", "") 
call <SID>yo("Include",                 s:bl, "", "") 
call <SID>yo("Ignore",                  s:co, "", "") 

" VIM
call <SID>yo("vimCommand",              s:or, "", "") 

" HTML
call <SID>yo("htmlTag",                 s:re, "", "") 
call <SID>yo("htmlTagName",             s:re, "", "") 

" DIFF
call <SID>yo("DiffAdd",                 s:gr, s:bg, "") 
call <SID>yo("DiffDelete",              s:re, s:bg, "") 
call <SID>yo("DiffChange",              s:ye, s:bg, "") 
call <SID>yo("DiffText",                s:se, s:bl, "") 
              
" GIT
call <SID>yo("DiffAdded",               s:gr, s:bg, "") 
call <SID>yo("DiffRemoved",             s:re, s:bg, "") 
call <SID>yo("gitcommitSummary",        "", "", "bold") 
call <SID>yo("", "", "", "") 

" DELETE
delf <SID>yo
