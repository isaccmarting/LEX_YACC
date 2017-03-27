%{
#define YYSTYPE int
#include "CalInt.tab.h"
extern YYSTYPE yylval; 

int yywrap(void); 
%}

%%
"+"       {return ADD; }
"-"       {return MINUS; }
"*"       {return MUL; }
"/"       {return DIV; }
"%"       {return MOD; }
"^"       {return EXPONENT; }
"("       {return LP; }
")"       {return RP; }
[0-9]+    {yylval = atoi(yytext); return NUMBER; }
"\n"      {return EOL; }
[ \t]     {}
%%

int yywrap(void)
{
    return 0; 
}
