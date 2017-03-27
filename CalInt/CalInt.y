%{
#include <stdio.h>
#define YYSTYPE int

void yyerror(char *s); 
extern YYSTYPE yylex(void); 
%}

%token XOR ADD MINUS MUL DIV MOD
%token LP NUMBER RP
%token EOL
%%
callist: /*empty*/
| callist exp EOL {printf("= %d\n", $2); }
;
exp: result
| result XOR exp {$$ = $1 ^ $3; }
; 
result: factor
| factor ADD result {$$ = $1 + $3; }
| factor MINUS result {$$ = $1 - $3; }
;
factor: term
| term MUL factor {$$ = $1 * $3; }
| term DIV factor {$$ = $1 / $3; }
| term MOD factor {$$ = $1 % $3; }
; 
term: NUMBER
| LP exp RP {$$ = $2; }
| MINUS NUMBER {$$ = -$2; }
;
%%

int main(int argc, char **argv)
{
    return yyparse();
}

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}
