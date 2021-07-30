%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>

void three_address_code();
char add_to_table(char ,char, char);
int yyerror(char *);
int yylex();

int idx = 0;
char tvar = '1';
struct instruction {
    char op1;
    char op2;
    char opr;
};
%}

%token IDENT NUM
%type expr
%left '+'
%left '*''/'
%left '-'
%%

statement: IDENT '=' expr ';' { add_to_table((char)$1, (char)$3, '='); }
         | expr ';'
         ;

expr: expr '+' expr {$$ = add_to_table((char)$1, (char)$3, '+');}
    | expr '-' expr {$$ = add_to_table((char)$1, (char)$3, '-');}
    | expr '*' expr {$$ = add_to_table((char)$1, (char)$3, '*');}
    | expr '/' expr {$$ = add_to_table((char)$1, (char)$3, '/');}
    | '(' expr ')' {$$ = (char)$2;}
    | NUM {$$ = (char)$1;}
    | IDENT {$$ = (char)$1;}
    | '-' expr {$$ = add_to_table((char)$2, (char)'\t', '-');}
    ;

%%

int yyerror(char *s) {
    printf("ERROR: %s",s);
    exit(0);
}

struct instruction ops[20];

char add_to_table(char op1, char op2, char opr) {
    ops[idx].op1 = op1;
    ops[idx].op2 = op2;
    ops[idx].opr = opr;
    idx++;
    return tvar++;
}

void three_address_code() {
    int count = 0;
    char temp = '1';
    while(count < idx) {
        if(ops[count].opr != '=') {
            printf("t%c=", temp++);
        }
        if(isalpha(ops[count].op1)) {
            printf("%c",ops[count].op1);
        } else if(ops[count].op1 >='1' && ops[count].op1 <='9') {
            printf("t%c",ops[count].op1);
        }

        printf("%c",ops[count].opr);

        if(isalpha(ops[count].op2)) {
            printf("%c\n",ops[count].op2);
        } else if(ops[count].op2 >='1' && ops[count].op2 <='9') {
            printf("t%c\n",ops[count].op2);
        }
        count++;
    }
}

int main() {
    yyparse();
    three_address_code();
}
