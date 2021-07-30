%{
#include<stdio.h>
int pi=0, ni=0, pf=0, nf=0, zero=0;
%}

%%
[0][.]?[0]* { zero++; printf("Zero:%s\n", yytext);}
[+]?[0-9]+[/][0]+ {printf("Divide by zero:%s\n", yytext);}
-[0-9]+[/][0]+ {printf("Divide by zero:%s\n", yytext);}
[+]?[0-9]*\.[0-9]+ {pf++; printf("PF:%s\n", yytext);}
[+]?[0-9]+[/][0-9]+ {pf++; printf("PF:%s\n", yytext);}
-[0-9]*\.[0-9]+ {nf++; printf("NF:%s\n", yytext);}
-[0-9]+[/][0-9]+ {nf++; printf("NF:%s\n", yytext);}
[+]?[0-9]+ {pi++; printf("PI:%s\n", yytext);}
-[0-9]+ {ni++; printf("NI:%s\n", yytext);}


. ;
\n return 0;
%%

int main()
{
	printf("Enter the numbers\n");

	
	yylex();
	printf("Number of pos ints: %d\n Number of neg ints: %d\n Number of pos fracts: %d\n Number of neg fracts: %d\n Number of zeroes: %d\n",pi,ni,pf,nf, zeroes);
	return 0;
}