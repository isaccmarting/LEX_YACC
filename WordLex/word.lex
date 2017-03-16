%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

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

%Start COMMENT
%%
<INITIAL>[" "\t]                                {adjust(); continue;}
\n                                              {adjust(); EM_newline(); printf("\n"); continue;}
<INITIAL>"//"(.)*                               {adjust(); printf("%s", yytext); continue;}
<INITIAL>"#"(.)*                                {adjust(); printf("%s", yytext); continue;}
<INITIAL>"if"                                   {adjust(); return IF;}
<INITIAL>"then"                                 {adjust(); return THEN;}
<INITIAL>"else"                                 {adjust(); return ELSE;}
<INITIAL>"while"                                {adjust(); return WHILE;}
<INITIAL>"for"                                  {adjust(); return FOR;}
<INITIAL>"to"                                   {adjust(); return TO;}
<INITIAL>"do"                                   {adjust(); return DO;}
<INITIAL>"let"                                  {adjust(); return LET;}
<INITIAL>"in"                                   {adjust(); return IN;}
<INITIAL>"end"                                  {adjust(); return END;}
<INITIAL>"of"                                   {adjust(); return OF;}
<INITIAL>"break"                                {adjust(); return BREAK;}
<INITIAL>"nil"                                  {adjust(); return NIL;}
<INITIAL>"int"                                  {adjust(); return INT;}
<INITIAL>"short"                                {adjust(); return SHORT;}
<INITIAL>"long"                                 {adjust(); return LONG;}
<INITIAL>"unsigned"                             {adjust(); return UNSIGNED;}
<INITIAL>"float"                                {adjust(); return FLOAT;}
<INITIAL>"double"                               {adjust(); return DOUBLE;}
<INITIAL>"char"                                 {adjust(); return CHAR;}
<INITIAL>"return"                               {adjust(); return RETURN;}
<INITIAL>\'.\'                                  {adjust(); yylval.sval = yytext; return CHARACTER;}
<INITIAL>\".*\"                                 {adjust(); yylval.sval = yytext; return STRING;}
<INITIAL>"."                                    {adjust(); return DOT;}
<INITIAL>","                                    {adjust(); return COMMA;}
<INITIAL>";"                                    {adjust(); return SEMICOLON;}
<INITIAL>":"                                    {adjust(); return COLON;}
<INITIAL>"("                                    {adjust(); return LPAREN;}
<INITIAL>")"                                    {adjust(); return RPAREN;}
<INITIAL>"["                                    {adjust(); return LBRACK;}
<INITIAL>"]"                                    {adjust(); return RBRACK;}
<INITIAL>"{"                                    {adjust(); return LBRACE;}
<INITIAL>"}"                                    {adjust(); return RBRACE;}
<INITIAL>"+"                                    {adjust(); return PLUS;}
<INITIAL>"-"                                    {adjust(); return MINUS;}
<INITIAL>"*"                                    {adjust(); return TIMES;}
<INITIAL>"/"                                    {adjust(); return DIVIDE;}
<INITIAL>"&"                                    {adjust(); return BIT_AND;}
<INITIAL>"|"                                    {adjust(); return BIT_OR;}
<INITIAL>"^"                                    {adjust(); return BIT_XOR;}
<INITIAL>"=="                                   {adjust(); return EQ;}
<INITIAL>"!="                                   {adjust(); return NEQ;}
<INITIAL>"<="                                   {adjust(); return LE;}
<INITIAL>"<"                                    {adjust(); return LT;}
<INITIAL>">="                                   {adjust(); return GE;}
<INITIAL>">"                                    {adjust(); return GT;}
<INITIAL>"!"                                    {adjust(); return BANG;}
<INITIAL>"&&"                                   {adjust(); return AND;}
<INITIAL>"||"                                   {adjust(); return OR;}
<INITIAL>"="                                    {adjust(); return ASSIGN;}
<INITIAL>[a-zA-Z]+[a-zA-Z0-9_]*                 {adjust(); yylval.sval = yytext; return ID; }
<INITIAL>([0-9]+"."[0-9]*)|([0-9]*"."[0-9]+)    {adjust(); yylval.fval=atof(yytext); return REAL;}
<INITIAL>[0-9]+[a-zA-Z_]+                       {adjust(); EM_error(EM_tokPos,"illegal token");}
<INITIAL>[0-9]+                                 {adjust(); yylval.ival=atoi(yytext); return NUM;}
<INITIAL>"/*"                                   {adjust(); printf("%s", yytext); BEGIN COMMENT; }
<INITIAL>.                                      {adjust(); EM_error(EM_tokPos,"illegal token");}
<COMMENT>"*/"                                   {adjust(); printf("%s", yytext); BEGIN INITIAL; }
<COMMENT>.                                      {adjust(); printf("%s", yytext); }
.                                               {BEGIN INITIAL; yyless(1); }


