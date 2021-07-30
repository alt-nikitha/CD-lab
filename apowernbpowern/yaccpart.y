%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
%}
%%
S:'a'S'b'
|
;
%%
int main()
{
yyparse();
printf("\n Valid string\n");
}
int yyerror()
{
printf("INVALID!!!\n");
exit(0);
}