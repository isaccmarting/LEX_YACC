%{
#include <stdio.h>
#define F(s) printf("%s\n", s) 
%}

%union {
	int pos;
	int ival;
	string sval;
}

%token <sval> ID STRING 
%token <ival> INTEGER 

%left SEMICOLON
%right ASSIGN
%left AND OR
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS
%left TIMES DIVIDE
%right OF DO THEN ELSE
%right UMINUS
%right DOT
%right LBRACK LBRACE ID

%token 
    INT ARRAY COMMA COLON 
    LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE 
    IF THEN WHILE FOR TO LET IN END BREAK
    NIL FUNCTION VAR TYPE

%start program
%%

program: exp
;
decs: dec {F("decs"); }
;
dec: tydec
| vardec
| fundec
;
tydec: TYPE /*TYPE*/ID EQ ty
;
ty: ID
| LBRACE tyfields RBRACE
| ARRAY OF /*TYPE*/ID
;
tyfields: /* Empty */
| tyfield
;
tyfield: ID COLON /*TYPE*/ID 
| ID COLON /*TYPE*/ID COMMA tyfield
;
vardec: VAR ID ASSIGN exp
| VAR ID COLON /*TYPE*/ID ASSIGN exp
;
fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp
| FUNCTION ID LPAREN tyfields RPAREN COLON /*TYPE*/ID EQ exp
;
expseq: exp
| exp SEMICOLON expseq
;
exp: NIL
| INTEGER 
| STRING
| LPAREN expseq RPAREN
| LPAREN RPAREN
| funcall

| MINUS exp %prec UMINUS
| exp PLUS exp
| exp MINUS exp
| exp TIMES exp
| exp DIVIDE exp

| exp EQ exp
| exp NEQ exp
| exp LT exp
| exp LE exp
| exp GT exp
| exp GE exp

| exp AND exp
| exp OR exp

| ID LBRACE record_item RBRACE
| ID LBRACE RBRACE
| ID LBRACK exp RBRACK OF exp
| lvalue ASSIGN exp {F("assign"); }

| IF exp THEN exp ELSE exp {F("if_then_else"); }
| IF exp THEN exp {F("if_then"); }
| WHILE exp DO exp {F("while"); }
| FOR ID ASSIGN exp TO exp DO exp {F("fpr"); }
| BREAK {F("break"); }

| LET decs IN END {F("let_in"); }
| LET decs IN expseq END {F("let_in"); }

| lvalue
;
record_item: ID EQ exp  {F("record_item"); }
| ID EQ exp COMMA record_item {F("record_item"); }
;
funcall: lvalue LPAREN RPAREN {F("funcall"); } /* ID -> lvalue */
| lvalue LPAREN para RPAREN  {F("funcall"); }
;
para: exp
| exp COMMA para
;
lvalue: ID
| lvalue DOT ID
| lvalue LBRACK exp RBRACK
;

%%

main(int argc, char **argv)
{
    yyparse();
}

yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
