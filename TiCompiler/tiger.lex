/*  */
%{

#include "errormsg.h"
#include "tokens.h"

#define MAX_STRING_LEN 100 

char temp[MAX_STRING_LEN]; 
int i; 
int charPos=1;

int yywrap(void)
{
 charPos=1;
 return 1;
}


void adjust(void)
{
 EM_tokPos=charPos;
 charPos+=yyleng;
}

%}

WhiteSpace [ \t]
Identifier [a-zA-Z][a-zA-Z0-9_]*
Integer    [0-9]+

%x COMMENT
%x LSTRING

%%

<INITIAL>{
{WhiteSpace}            {adjust(); continue; }
\n                      {adjust(); EM_newline(); continue; }

","                     {adjust(); return COMMA; }
":"                     {adjust(); return COLON; }
";"                     {adjust(); return SEMICOLON; }
"("                     {adjust(); return LPAREN; }
")"                     {adjust(); return RPAREN; }
"["                     {adjust(); return LBRACK; }
"]"                     {adjust(); return RBRACK; }
"{"                     {adjust(); return LBRACE; }
"}"                     {adjust(); return RBRACE; }
"."                     {adjust(); return DOT; }
"+"                     {adjust(); return PLUS; }
"-"                     {adjust(); return MINUS; }
"*"                     {adjust(); return TIMES; }
"/"                     {adjust(); return DIVIDE; }
"="                     {adjust(); return EQ; }
"<>"                    {adjust(); return NEQ; }
"<"                     {adjust(); return LT; }
"<="                    {adjust(); return LE; }
">"                     {adjust(); return GT; }
">="                    {adjust(); return GE; }
"&"                     {adjust(); return AND; }
"|"                     {adjust(); return OR; }
":="                    {adjust(); return ASSIGN; }

type                    {adjust(); return TYPE; }
var                     {adjust(); return VAR; }
int                     {adjust(); return INT; }
string                  {adjust(); return STRING; }
array                   {adjust(); return ARRAY; }
of                      {adjust(); return OF; }
function                {adjust(); return FUNCTION; }
nil                     {adjust(); return NIL; }
if                      {adjust(); return IF; }
then                    {adjust(); return THEN; }
else                    {adjust(); return ELSE; }
while                   {adjust(); return WHILE; }
for                     {adjust(); return FOR; }
to                      {adjust(); return TO; }
do                      {adjust(); return DO; }
break                   {adjust(); return BREAK; }
let                     {adjust(); return LET; }
in                      {adjust(); return IN; }
end                     {adjust(); return END; }

{Identifier}            {adjust(); yylval.sval = yytext; return ID; }
{Integer}               {adjust(); yylval.ival = atoi(yytext); return INTEGER; }

\"                      {adjust(); BEGIN LSTRING; i = 0; }
"/*"                    {adjust(); BEGIN COMMENT; }
}

<COMMENT>{
.|\n                    {adjust(); continue; }
"*/"                    {adjust(); BEGIN INITIAL; }
}

<LSTRING>{
\"                      {adjust(); temp[i] = 0; yylval.sval = strdup(temp); BEGIN INITIAL; return SSTRING; }
\\\"                    {adjust(); temp[i++] = '\"'; }
\\\'                    {adjust(); temp[i++] = '\''; }
\\n                     {adjust(); temp[i++] = '\n'; }
\\t                     {adjust(); temp[i++] = '\t'; }
\\[0-9]{3}              {adjust(); temp[i++] = atoi(yytext+1); }
\\[0-9]{2}              {adjust(); temp[i++] = atoi(yytext+1); }
\\[0-9]{1}              {adjust(); temp[i++] = atoi(yytext+1); }
\\\\                    {adjust(); temp[i++] = '\\'; }

\n                      {adjust(); EM_newline(); }
{WhiteSpace}            {adjust(); temp[i++] = *yytext; continue; }
.                       {adjust(); temp[i++] = *yytext; }
}

%%
