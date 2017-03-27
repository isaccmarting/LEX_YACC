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
| exp ADD factor {$$ = $1 + $3; }
| exp MINUS factor {$$ = $1 - $3; }
;
factor: term
| factor MUL term {$$ = $1 * $3; }
| factor DIV term {$$ = $1 / $3; }
| factor MOD term {$$ = $1 % $3; }
; 
term: expval
| expval EXPONENT term {$$ = pow($1, $3); } 
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
