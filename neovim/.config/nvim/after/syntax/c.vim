" Operators.
syntax match cOperator "\(<<\|>>\|[-+*/%&^|<>!=]\)="
syntax match cOperator "<<\|>>\|&&\|||\|++\|--\|->"
syntax match cOperator "[.!~*&%<>^|?:=,+-]"
syntax match cOperator "/[^/*=]"me=e-1
syntax match cOperator "/$"
syntax match cOperator "[][]"

" Special comments.
syntax keyword cTodo contained BUG HACK NOTE OPTIMIZE
