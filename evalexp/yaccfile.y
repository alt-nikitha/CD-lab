%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
%}
%token NUM
%left '+''-'
%left '/''*'
%%
S:T {printf("Answer : %d\n",$$);}
;
T:

    T '+' T { $$ = $1 + $3; }
    | T '-' T { $$ = $1 - $3; }
    | T '*' T { $$ = $1 * $3; }
    | T '/' T { if($3!=0)$$ = $1 / $3; else {yyerror();}}
    |'('T')' {$$=$2;}
    | NUM
    | '-'NUM {$$=-$2;}
    ;
%%
int main()
{
yyparse();
printf("Expression is valid\n");
}
int yyerror()
{
printf("Expression is invalid\n");
exit(0);
}