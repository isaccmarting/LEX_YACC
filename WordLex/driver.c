#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

YYSTYPE yylval;

int yylex(void); /* prototype for the lexing function */



string toknames[] = {
"ID", "STRING", "NUM", "COMMA", "COLON", "SEMICOLON", "LPAREN",
"RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "DOT", "PLUS",
"MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "LE", "GT", "GE",
"AND", "OR", "ASSIGN", "ARRAY", "IF", "THEN", "ELSE", "WHILE", "FOR",
"TO", "DO", "LET", "IN", "END", "OF", "BREAK", "NIL", "FUNCTION",
"REAL", "TYPE", "INT", "SHORT", "LONG", "UNSIGNED", "FLOAT", "DOUBLE", "CHAR", 
"CHARACTER", "BIT_AND", "BIT_OR", "BIT_XOR", "BANG", "RETURN"
};


string tokname(tok) {
  return tok<257 || tok>312 ? "BAD_TOKEN" : toknames[tok-257];
}

int main(int argc, char **argv) {
 string fname; int tok;
 if (argc!=2) {fprintf(stderr,"usage: lextest filename\n"); exit(1);}
 fname=argv[1];
 EM_reset(fname);
 for(;;) {
   tok=yylex();
   if (tok==0) break;
   switch(tok) {
   case ID: case STRING: case CHARACTER: 
     // printf("%10s %4d %s\n",tokname(tok),EM_tokPos,yylval.sval);
     printf("%s(%s) ",tokname(tok),yylval.sval);
     break;
   case NUM:
     // printf("%10s %4d %d\n",tokname(tok),EM_tokPos,yylval.ival);
     printf("%s(%d) ",tokname(tok),yylval.ival);
	 break;
   case REAL:
	 // printf("%10s %4d %lf\n",tokname(tok),EM_tokPos,yylval.fval);
     printf("%s(%lf) ",tokname(tok),yylval.fval);
     break; 
   default:
     // printf("%10s %4d\n",tokname(tok),EM_tokPos);
     printf("%s ",tokname(tok));
   }
 }
 return 0;
}



