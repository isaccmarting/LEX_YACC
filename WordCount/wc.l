/* Like Unix wc */
%option noyywrap
%{
    int chars = 0; 
    int words = 0; 
    int lines = 1; 
%}

%%

[a-zA-Z0-9\-_]+ {words++; chars += yyleng; }
\n {chars++; lines++; }
. {chars++; }

%%

int main(int argc ,char* argv[])
{
    yylex();
    printf("The number of chars is %d.\n", chars);
    printf("The number of words is %d.\n", words);
    printf("The number of lines is %d.\n", lines);
    return 0;
}
