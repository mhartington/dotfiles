" function! ConflictDetection#Highlight() abort "{{{
"     syntax region conflictOurs   matchgroup=conflictOursMarker start="^<\{7}<\@!.*$"   end="^\([=|]\)\{7}\1\@!"me=s-1 keepend containedin=TOP
"     syntax region conflictBase   matchgroup=conflictBaseMarker start="^|\{7}|\@!.*$"   end="^=\{7}=\@!"me=s-1         keepend containedin=TOP
"     syntax region conflictTheirs start="^=\{7}=\@!.*$" matchgroup=conflictTheirsMarker end="^>\{7}>\@!.*$"            keepend containedin=TOP contains=conflictSeparatorMarkerSymbol
"     syntax match conflictOursMarkerSymbol       "^<\{7}"        contained
"     syntax match conflictBaseMarkerSymbol       "^|\{7}"        contained
"     syntax match conflictSeparatorMarkerSymbol  "^=\{7}"        contained
"     syntax match conflictTheirsMarkerSymbol     "^>\{7}"        contained
" endfunction "}}}
