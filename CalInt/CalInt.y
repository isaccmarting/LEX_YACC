%{
#include <stdio.h>
#include <math.h>
#define YYSTYPE int

void yyerror(char *s); 
extern int yylex(void); 
%}

%token ADD MINUS MUL DIV MOD EXPONENT
%token LP NUMBER RP
%token EOL
%%
callist: /*empty*/
| callist exp EOL {printf("= %d\n", $2); }
;
exp: factor
| factor ADD exp {$$ = $1 + $3; }
| factor MINUS exp {$$ = $1 - $3; }
;
factor: term
| term MUL factor {$$ = $1 * $3; }
| term DIV factor {$$ = $1 / $3; }
| term MOD factor {$$ = $1 % $3; }
; 
term: expval
| expval EXPONENT expval {$$ = pow($1, $3); } 
; 
expval: NUMBER
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
