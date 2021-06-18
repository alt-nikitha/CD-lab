%{
#include <stdio.h>
#include <stdlib.h>
extern yylineno;
extern FILE *yyin;
extern int yylex();
int yyerror();
%}
%token INT FLOAT CHAR DOUBLE VOID
%token FOR WHILE
%token IF ELSE PRINTF
%token STRUCT
%token NUM ID
%token INCLUDE
%token DOT
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT
%%
start: Function
    |Declaration
;
Declaration: Type Assignment ';'
    |Assignment ';'
    |FunctionCall ';'
    |ArrayUsage ';'
    |Type ArrayUsage ';'
    |StructStmt ';'
;
FunctionCall: ID '(' ')'
    |ID '(' Assignment ')'
;

ArrayUsage: ID '[' Assignment ']'
;
Function: Type ID '(' ArgListOpt ')' CompoundStmt
;
ArgListOpt: ArgList
    |
;
ArgList: ArgList ',' Arg
    |Arg
;
Arg: Type ID
;
CompoundStmt: '{' StmtList '}'
;
StmtList: StmtList Stmt
|
;
Stmt: WhileStmt
    |Declaration
    |ForStmt
    |IfStmt
    |PrintFunc
    |StructStmt
    |Type Assignment
    |';'
;
Type: INT
    |FLOAT
    |CHAR
    |DOUBLE
    |VOID
;
WhileStmt: WHILE '(' Expr ')' Stmt
    |WHILE '(' Expr ')' CompoundStmt
;

ForStmt: FOR '(' Expr ';' Expr ';' Expr ')' Stmt
    |FOR '(' Expr ';' Expr ';' Expr ')' CompoundStmt
    |FOR '(' Expr ')' Stmt
    |FOR '(' Expr ')' CompoundStmt
;
IfStmt: IF '(' Expr ')' Stmt
    |IF '(' Expr ')' CompoundStmt
    |IfStmt ElseStmt
;
ElseStmt: ELSE Stmt
    |ELSE CompoundStmt
;
StructStmt: STRUCT ID CompoundStmt
;
PrintFunc: PRINTF '(' Expr ')' ';'
;
Expr:
    |Expr LE Expr
    |Expr GE Expr
    |Expr NE Expr
    |Expr EQ Expr
    |Expr GT Expr
    |Expr LT Expr
    |Assignment
    |ArrayUsage
;
Assignment: ID '=' Assignment
    |ID '=' FunctionCall
    |ID '=' ArrayUsage
    |ArrayUsage '=' Assignment
    |ID ',' Assignment
    |NUM ',' Assignment
    |ID '+' Assignment
    |ID '-' Assignment
    |ID '*' Assignment
    |ID '/' Assignment
    |NUM '+' Assignment
    |NUM '-' Assignment
    |NUM '*' Assignment
    |NUM '/' Assignment
    |'\'' Assignment '\''
    |'(' Assignment ')'
    |'-' NUM
    |'-' ID
    |NUM
    |ID
;
%%
int count = 0;
int main(int argc, char *argv[])
{
yyin = fopen(argv[1], "r");
if(!yyparse())
printf("\nParsing Complete\n");
else
printf("\nParsing failed\n");
fclose(yyin);
return 0;
}
int yyerror(char *s)
{
printf("Invalid definition! Error at line number %d\n\n", yylineno);
}