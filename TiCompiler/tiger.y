%{
// #define YYDEBUG 1
#include <stdio.h>
#include "util.h"
#define F(s) printf("%s\n", s) 

void yyerror(char *s); 
int yylex(void); 

// int yydebug=1; 

%}

%union {
	int pos;
	int ival;
	string sval;
}

%token <sval> ID SSTRING 
%token <ival> INTEGER 

%left SEMICOLON
%right ASSIGN
%left OR
%left AND
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS
%left TIMES DIVIDE
%right OF DO THEN ELSE
%right UMINUS
%right DOT
%right LBRACK LBRACE ID

%token 
    INT STRING ARRAY COMMA COLON 
    LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE 
    IF THEN WHILE FOR TO LET IN END BREAK
    NIL FUNCTION VAR TYPE

%start program
%%

program: exp
;
ids: ID
| INT
| STRING
;
decs: dec {F("decs"); }
| dec decs
;
dec: tydec 
| vardec 
| fundec 
;
tydec: TYPE /*TYPE*/ID EQ ty
;
ty: ids
| LBRACE tyfields RBRACE {F("typdec: LBRACE tyfields RBRACE"); }
| ARRAY OF /*TYPE*/ids {F("tydec: array of ids"); }
;
tyfields: /* Empty */
| tyfield
;
tyfield: ID COLON /*TYPE*/ids 
| ID COLON /*TYPE*/ids COMMA tyfield
;
vardec: VAR ID ASSIGN exp {F("vardec: VAR ID ASSIGN exp"); }
| VAR ID COLON /*TYPE*/ids ASSIGN exp {F("vardec: VAR ID COLON ids ASSIGN exp"); }
;
fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp {F("fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp"); }
| FUNCTION ID LPAREN tyfields RPAREN COLON /*TYPE*/ids EQ exp {F("fundec: FUNCTION ID LPAREN tyfields RPAREN COLON ids EQ exp"); }
;
expseq: exp
| exp SEMICOLON expseq
;
exp: NIL
| INTEGER 
| SSTRING 
| lvalue
| LPAREN expseq RPAREN {F("exp: LPAREN expseq RPAREN"); }
| LPAREN RPAREN {F("exp: LPAREN RPAREN"); }
| funcall

| MINUS exp %prec UMINUS {F("UMINUS"); }
| exp PLUS exp {F("PLUS"); }
| exp MINUS exp {F("MINUS"); }
| exp TIMES exp {F("TIMES"); }
| exp DIVIDE exp {F("DIVIDE"); }

| exp EQ exp {F("EQ"); }
| exp NEQ exp {F("NEQ"); }
| exp LT exp {F("LT"); }
| exp LE exp {F("LE"); }
| exp GT exp {F("GT"); }
| exp GE exp {F("GE"); }

| exp AND exp {F("AND"); }
| exp OR exp {F("OR"); }

| ID LBRACE record_item RBRACE {F("exp: ID LBRACE record_item RBRACE"); }
| ID LBRACE RBRACE {F("exp: ID LBRACE RBRACE"); }
| ID LBRACK exp RBRACK OF exp {F("exp: ID LBRACK exp RBRACK OF exp"); }
| lvalue ASSIGN exp {F("exp: lvalue ASSIGN exp"); }

| IF exp THEN exp ELSE exp {F("if_then_else"); }
| IF exp THEN exp {F("if_then"); }
| WHILE exp DO exp {F("while"); }
| FOR ID ASSIGN exp TO exp DO exp {F("for"); }
| BREAK {F("break"); }

| LET decs IN END {F("let_in: LET decs IN END"); }
| LET decs IN expseq END {F("let_in: LET decs IN expseq END"); }
;
record_item: ID EQ exp  
| ID EQ exp COMMA record_item 
;
funcall: lvalue LPAREN RPAREN {F("funcall: lvalue LPAREN RPAREN"); } /* ID -> lvalue */
| lvalue LPAREN para RPAREN  {F("funcall: lvalue LPAREN para RPAREN"); }
;
para: exp
| exp COMMA para
;
lvalue: ID {F("lvalue: ID"); }
| lvalue DOT ID {F("lvalue: lvalue DOT ID"); }
| lvalue LBRACK exp RBRACK {F("lvalue LBRACK exp RBRACK"); }
;

%%

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
