%{
#include<stdio.h>
int kw=0, v=0, o=0, d=0;
%}

%%
\"(\\.|[^"\\])*\" ;
"int"|"char"|"bool"|"float"|"void"|"for"|"do"|"while"|"if"|"else"|"return"|"void" {kw++; printf("Keyword:%s\n", yytext);}
[A-Za-z_][A-Za-z]* {v++; printf("Variable:%s\n", yytext);}
"<"|">"|"<="|">="|"=="|"="|"+"|"*"|"/"|"%"|"++" { o++; printf("Operator:%s\n", yytext);}
[0-9] {d++; printf("Digit:%s\n", yytext);} 
. ;
%%

int main()
{
// printf("enter the string\n");
FILE *fp;
fp=fopen("inputprog.c", "r");
yyin = fp;
yylex();
printf("Keyword = %d\n, variables = %d\n, operators = %d\n, digits = %d\n",kw,v,o,d);
return 0;
}

// int yywrap()
// {
//     return 0;
// }