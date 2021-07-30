%{
#include <stdlib.h>
extern int yylval;
#include "y.tab.h"
%}

%%

[0-9]+? {
    yylval=yytext[0];
    return NUM;
};
[a-zA-Z_][a-zA-Z0-9]* {
    yylval=yytext[0];
    return IDENT;
}
. return yytext[0];
\n return NL;
%%

int yywrap() {
    return 1;
}