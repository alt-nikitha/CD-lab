%{
#include<stdio.h>
int p=0,s=0;
%}
%%
"printf" {fprintf(yyout, "writef"); p++;}
"scanf" {fprintf(yyout, "readf"); s++;}
%%

int main()
{
	FILE *fp, *fp1;
    fp=fopen("inputprog.c", "r");
    yyin = fp;
	fp1=fopen("outputprog.c", "w");
	yyout = fp1;

	
	yylex();
	printf("Number of Printfs: %d\n Number of Scanfs: %d\n",p,s);
	return 0;
}
