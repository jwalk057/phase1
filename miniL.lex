   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   int currLine =1, currPos=1;
%}

   /* some common rules */
LETTERS  [A-Za-z]
DIGIT    [0-9]
%%
   /* specific lexer rules in regex */
[ \t]+         {currPos += yyleng;}/*Ignores single spaces*/
"function"  {printf("FUNCTION\n"); currPos += yyleng;}  
";"         {printf("SEMICOLON\n"); currPos += yyleng;}
{DIGIT}+    {printf("NUMBER %s\n", yytext); currPos += yyleng;}
{LETTERS}(_?({LETTERS}|{DIGIT}))*  {printf("IDENT %s\n", yytext); currPos += yyleng;}
{DIGIT}(_?({LETTERS}|{DIGIT}))* {printf("ERROR at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}
{LETTERS}(_?({LETTERS}|{DIGIT})_?)* {printf("ERROR at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);}
.	{printf("ERROR at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
