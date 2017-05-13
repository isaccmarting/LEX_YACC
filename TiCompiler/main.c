#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
// #include "tokens.h"
#include "tiger.tab.h"

YYSTYPE yylval;
extern int yyparse(void);

string toknames[] = {
"ID", "STRING", "INT", "COMMA", "COLON", "SEMICOLON", "LPAREN",
"RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "DOT", "PLUS",
"MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "LE", "GT", "GE",
"AND", "OR", "ASSIGN", "ARRAY", "IF", "THEN", "ELSE", "WHILE", "FOR",
"TO", "DO", "LET", "IN", "END", "OF", "BREAK", "NIL", "FUNCTION",
"VAR", "TYPE", "INTEGER", "SSTRING"
};


string tokname(int tok) {
  return tok<ID || tok>TYPE ? "BAD_TOKEN" : toknames[tok-ID];
}

void parse(string fname) 
{
	EM_reset(fname);
	if (yyparse() == 0) {/* parsing worked */
		/*fprintf(stderr,"Parsing successful!\n");*/
		printf("SUC!\n");
	} else {
		/*fprintf(stderr,"Parsing failed\n");*/
		printf("FAIL!\n");
	}
}

//int main(int argc, char **argv) {
// string fname; int tok;
// if (argc!=2) {fprintf(stderr,"usage: a.out filename\n"); exit(1);}
// fname=argv[1];
// EM_reset(fname);
// for(;;) {
//   tok=yylex();
//   if (tok==0) break;
//   switch(tok) {
//   case ID: case SSTRING:
//     printf("%10s %4d %s\n",tokname(tok),EM_tokPos,yylval.sval);
//     if(tok == STRING) free(yylval.sval); 
//     break;
//   case INTEGER:
//     printf("%10s %4d %d\n",tokname(tok),EM_tokPos,yylval.ival);
//     break;
//   default:
//     printf("%10s %4d\n",tokname(tok),EM_tokPos);
//   }
// }
// return 0;
//}
int main(int argc, char **argv) {
	if (argc!=2) {
		fprintf(stderr,"usage: a.out filename\n"); 
		exit(1);
	}
	parse(argv[1]);
	return 0;
}
