%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#define YYSTYPE MyType
typedef struct ValType
{
    unsigned char IsDouble; 
    int IntValue; 
    double DoubleValue; 
} MyType; 

void yyerror(char *s); 
extern int yylex(void); 
%}

%token ADD MINUS MUL DIV EXPONENT
%token LP NUMBER RP
%token EOL
%%
callist: /*empty*/
| callist exp EOL {
    if($2.IsDouble != 0)
        printf("= %lf\n", $2.DoubleValue); 
    else
        printf("= %d\n", $2.IntValue); }
;
exp: factor
| exp ADD factor {
    $$.IsDouble = $1.IsDouble | $3.IsDouble; 
    $$.IntValue = $1.IntValue + $3.IntValue; 
    $$.DoubleValue = $1.DoubleValue + $3.DoubleValue; }
| exp MINUS factor {
    $$.IsDouble = $1.IsDouble | $3.IsDouble; 
    $$.IntValue = $1.IntValue - $3.IntValue; 
    $$.DoubleValue = $1.DoubleValue - $3.DoubleValue; }
;
factor: term
| factor MUL term {
    $$.IsDouble = $1.IsDouble | $3.IsDouble; 
    $$.IntValue = $1.IntValue * $3.IntValue; 
    $$.DoubleValue = $1.DoubleValue * $3.DoubleValue; }
| factor DIV term {
    $$.IsDouble = $1.IsDouble | $3.IsDouble; 
    $$.IntValue = $1.IntValue / $3.IntValue; 
    $$.DoubleValue = $1.DoubleValue / $3.DoubleValue; }
; 
term: expval
| expval EXPONENT term {
    $$.IsDouble = $1.IsDouble | $3.IsDouble; 
    $$.IntValue = pow($1.IntValue, $3.IntValue); 
    $$.DoubleValue = pow($1.DoubleValue, $3.DoubleValue); }
; 
expval: NUMBER
| LP exp RP {memcpy(&$$, &$2, sizeof(struct ValType)); }
| MINUS NUMBER {memcpy(&$$, &$2, sizeof(struct ValType)); $$.IntValue = -$$.IntValue; $$.DoubleValue = -$2.DoubleValue; }
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
