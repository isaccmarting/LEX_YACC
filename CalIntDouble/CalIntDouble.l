%{
#define YYSTYPE MyType
typedef struct ValType
{
    unsigned char IsDouble; 
    int IntValue; 
    double DoubleValue; 
} MyType; 
#include "CalIntDouble.tab.h"
extern YYSTYPE yylval; 

int yywrap(void); 
%}

%%
"+"       {return ADD; }
"-"       {return MINUS; }
"*"       {return MUL; }
"/"       {return DIV; }
"^"       {return EXPONENT; }
"("       {return LP; }
")"       {return RP; }
[0-9]+    {yylval.IntValue = atoi(yytext); yylval.DoubleValue = atof(yytext); return NUMBER; }
([0-9]+"."[0-9]*)|([0-9]*"."[0-9]+) {yylval.IntValue = atoi(yytext); yylval.DoubleValue = atof(yytext); yylval.IsDouble |= 1; return NUMBER; }
"\n"      {yylval.IsDouble = 0; return EOL; }
[ \t]     {}
%%

int yywrap(void)
{
    return 0; 
}
