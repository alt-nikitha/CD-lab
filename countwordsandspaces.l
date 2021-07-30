%{
int s=0,w=0;
%}
%%
([ ])+ s++;
([a-zA-Z0-9])* w++;
.;
\n return 0;
%%
int main()
{
printf("Enter the string: ");
yylex();
printf("No. of spaces = %d\nNo. of words = %d\n",s,w);
}