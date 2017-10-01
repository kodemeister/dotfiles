" Functions
syntax match cCustomFunc "\w\+\s*("me=e-1,he=e-1
highlight default link cCustomFunc Function

" Operators
syntax match cOperator "\(<<\|>>\|[-+*/%&^|<>!=]\)="
syntax match cOperator "<<\|>>\|&&\|||\|++\|--\|->"
syntax match cOperator "[.!~*&%<>^|?:=,+-]"
syntax match cOperator "/[^/*=]"me=e-1
syntax match cOperator "/$"
syntax match cOperator "[][]"

" Special comments
syntax keyword cTodo contained BUG HACK NOTE OPTIMIZE
