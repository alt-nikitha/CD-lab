
%start S

%{
    #include <stdio.h>
    #include <stdlib.h>
    int yyerror();
    int yywrap();
    extern int yylex();
%}

%%
S   : A C
    ;

A   : 'a' A 'b'
    | 
    ;

C   : 'b' C 'c'
    | 
    ;
%%

int yywrap() {}

int main() {
    printf("Enter string: ");
    yyparse();
    printf("Valid string\n");
}

int yyerror() {
    printf("Invalid string\n");
    exit(0);
}