%{
    #include <stdio.h>
    #include <stdlib.h>
    int yyerror();
    extern int yylex();

%}
%token NUM
%left '+' '-'
%left '/' '*'

%%
S : I {printf("result is %d\n",$$);}
;
I : I'+'I {$$=$1+$3;}
|I'-'I {$$=$1-$3;}
|I'*'I {$$=$1*$3;}
|I'/'I {
    if($3==0)
    {
        yyerror();
    }
    else
    $$=$1/$3;}
| '('I')' {$$=$2;}
| NUM;
%%

int yyerror() {
printf("Invalid statement\n");
exit(1);
}


    int main()
{
yyparse();
printf("\n Valid string\n");
}