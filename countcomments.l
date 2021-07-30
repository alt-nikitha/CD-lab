%{
#include<stdio.h>
int c=0,b=0;
%}
%%
[//].*  c++;
[/*](\\.|[^[*/]\\])*[*/] c++;
. ;
%%

int main()
{
	FILE *fp;
    fp=fopen("inputprog.c", "r");
    yyin = fp;
	yylex();
	printf("Number of Comments: %d\n",c+b);
	return 0;
}
