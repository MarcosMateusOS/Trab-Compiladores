grammar Lang;

@header
{
package lang.parser;    
}

/* Regras da gramática */
prog    : data* fun* #Program ; 

data    : DATA_TYPE NAME_TYPE OPEN_BRACE decl* CLOSE_BRACE #Datas ;

decl    : ID DOUBLE_COLON type SEMICOLON #DataDeclaration ;

fun     : ID OPEN_PARENT params? CLOSE_PARENT (COLON type (COMMA type)*)? OPEN_BRACE cmd* CLOSE_BRACE #FunDeclaration ;

params  : ID DOUBLE_COLON type (COMMA ID DOUBLE_COLON type)* #ParamsDeclaration ;

type    : btype #BasicType
        | type OPEN_BRACKET CLOSE_BRACKET #ArrayType;

btype   : INT_TYPE #Int
        | CHAR_TYPE #CharType
        | BOOL_TYPE #BoolType
        | FLOAT_TYPE #FloatType
        | NAME_TYPE #NameType
        | ID #IdType
        ;

cmd     : OPEN_BRACE cmd* CLOSE_BRACE #CommandList
        | IF OPEN_PARENT exp CLOSE_PARENT cmd #IfCommand
        | IF OPEN_PARENT exp CLOSE_PARENT cmd ELSE cmd #IfElseCommand
        | ITERATE OPEN_PARENT exp CLOSE_PARENT cmd #IterateCommand
        | READ lvalue SEMICOLON #ReadCommand
        | PRINT exp SEMICOLON #PrintCommand
        | RETURN exp? SEMICOLON #ReturnCommand
        | RETURN exps? SEMICOLON  #ReturnMultCommand // Múltiplos 
        | lvalue EQUAL exp SEMICOLON #AssignCommand
        | ID OPEN_PARENT exps? CLOSE_PARENT (LESSER_THAN lvalue (COMMA lvalue)* GREATER_THAN)? SEMICOLON #CallCommand
        ;

exp     : exp AND_SIGN exp #AndExp
        | exp LESSER_THAN exp #LesserThanExp
        | exp EQUALITY_SIGN exp #EqualityExp
        | exp NOT_EQUAL_SIGN exp #HotEqualExp
        | exp PLUS_SIGN exp #PlusExp
        | exp MINUS_SIGN exp #MinusExp
        | exp MULT_SIGN exp #MultExp
        | exp DIVIDE_SIGN exp #DivExp
        | exp MOD_SIGN exp #ModExp
        | NOT_SIGN exp #NotSignExp
        | MINUS_SIGN exp #MinusSignExp
        | TRUE #True
        | FALSE #False
        | NULL #Null
        | INT_VAL #IntVal
        | FLOAT_VAL #FloatVal
        | CHAR_VAL #CharVal
        | lvalue #LValueExp
        | OPEN_PARENT exp CLOSE_PARENT #ExpParen 
        | NEW type (OPEN_BRACKET exp CLOSE_BRACKET)? #New
        | ID OPEN_PARENT exps? CLOSE_PARENT OPEN_BRACKET exp CLOSE_BRACKET #ArrayAccess
        ;

lvalue  : ID #IdLvalue
        | lvalue OPEN_BRACKET exp CLOSE_BRACKET #ArrayLvalue
        | lvalue DOT ID #DotLvalue
        ;

exps    : exp (COMMA exp)* #FunCallParams;

/* Tokens da linguagem */

EOL          : '\r'? '\n' -> skip;       // Final de linha
WS           : [ \t]+ -> skip;            // Espaço em branco
LINE_COMMENT : '--' .*? EOL -> skip;      // Comentário de linha
MULTILINE_COMMENT: '{-' .*? '-}' -> skip; // Comentário multilinha

fragment ESC_SEQ: '\\' [btnrf"'\\] ;  // Sequências de escape para caracteres

/*Tipos */
INT_TYPE    : 'Int';
CHAR_TYPE   : 'Char';
BOOL_TYPE   : 'Bool';
FLOAT_TYPE  : 'Float';
DATA_TYPE   : 'data';

/* Palavras reservadas */
IF          : 'if';
ELSE        : 'else';
ITERATE     : 'iterate';
READ        : 'read';
PRINT       : 'print';
RETURN      : 'return';
NEW         : 'new';
TRUE        : 'true';
FALSE       : 'false';
NULL        : 'null';

/* Símbolos */
AND_SIGN     : '&&';
EQUALITY_SIGN: '==';
NOT_EQUAL_SIGN: '!=';
LESSER_THAN  : '<';
GREATER_THAN : '>';

PLUS_SIGN    : '+';
MINUS_SIGN   : '-';
MULT_SIGN    : '*';
DIVIDE_SIGN  : '/';
MOD_SIGN     : '%';
NOT_SIGN     : '!';

EQUAL        : '=';
AMPERSAND    : '&';
DOT          : '.';
COMMA        : ',';
SEMICOLON    : ';';
COLON        : ':';
DOUBLE_COLON : '::';
SINGLE_QUOTE : '\'';
BACK_SLASH   : '\\';

/*Delimitadores */
OPEN_PARENT  : '(';
CLOSE_PARENT : ')';
OPEN_BRACE   : '{';
CLOSE_BRACE  : '}';
OPEN_BRACKET : '[';
CLOSE_BRACKET: ']';


/* Léxico */
ID          : [a-z][a-zA-Z0-9_]* ;        // Identificadores
NAME_TYPE   : [A-Z][a-zA-Z0-9_]* ;      // Nomes dos tipos
INT_VAL     : [0-9]+ ;                   // Valores inteiros
CHAR_VAL    : '\'' ( ESC_SEQ | ~[\r\n\\'] ) '\'' ; // Valores dos caracteres
FLOAT_VAL   : [0-9]+ '.' [0-9]* ;       // Valores dos floats
