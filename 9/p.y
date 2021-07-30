%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>

void apply(char);
void load_num(char);
void load_var(char *);
void store_var(char *);
int yytext();
int yyerror(char *);
int yylex();
int reg_count=0;

char cur_str[100];

struct instruction {
    char op1;
    char op2;
    char opr;
};
%}

%token IDENT NUM NL
%type expr
%left '+'
%left '*''/'
%left '-'
%%

start: statement NL start
     | NL

statement: IDENT {
            strcpy(cur_str, yytext);
         } '=' expr {
            printf("ST %s, R%d\n", cur_str, reg_count-1);
         }
         ;

expr: expr '+' expr {apply('+');}
    | expr '-' expr {apply('-');}
    | expr '*' expr {apply('*');}
    | NUM {
        printf("LD R%d, #%c\n", reg_count++, atoi(yytext));
    }
    | IDENT {
        printf("LD R%d, %s\n", reg_count++, yytext);
    }
    ;

%%

void apply(char opr) {
    switch(opr) {
        case '+': 
            printf("ADD ");
            break;
        case '-': 
            printf("SUB ");
            break;
        case '*': printf("MUL ");
    }
    printf("R%d, R%d, R%d\n", reg_count-2, reg_count-2, reg_count-1);
}

void load_num(char num) {
    printf("LD R%d, #%c\n", reg_count++, num);
}

void load_var(char *var) {
    printf("LD R%d, %s\n", reg_count++, var);
}

void store_var(char* var) {
    printf("ST %s, R%d\n", var, reg_count-1);
}

int yyerror(char *s) {
    printf("ERROR: %s",s);
    exit(0);
}

int main() {
    yyparse();
}