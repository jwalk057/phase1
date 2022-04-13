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
/* RESERVED WORDS */
"function"  {printf("FUNCTION\n"); currPos += yyleng;} 
"beginparams" {printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams" {printf("END_PARAMS\n"); currPos += yyleng;}
"beginlocals" {printf("BEGIN_LOCALS\n"); currPos += yyleng;}
"endlocals" {printf("END_LOCALS\n"); currPos += yyleng;}
"beginbody" {printf("BEGIN_BODY\n"); currPos += yyleng;}
"endbody" {printf("END_BODY\n"); currPos += yyleng;}
"integer" {printf("INTEGER\n"); currPos += yyleng}
"array" {printf("ARRAY\n"); currPos += yyleng;}
"enum" {printf("ENUM\n"); currPos += yyleng;}
"of" {printf("OF\n"); currPos += yyleng;}
"if" {printf("IF\n"); currPos += yyleng;}
"then" {printf("THEN\n"); currPos += yyleng;}
"endif" {printf("ENDIF\n"); currPos += yyleng;}
"else" {printf("ELSE\n"); currPos += yyleng;}
"for" {printf("FOR\n"); currPos += yyleng;}
"while" {printf("WHILE\n"); currPos += yyleng;}
"do" {printf("DO\n"); currPos += yyleng;}
"beginloop" {printf("BEGINLOOP\n"); currPos += yyleng;}
"endloop" {printf("ENDLOOP\n"); currPos += yyleng;}
"continue" {printf("CONTINUE\n"); currPos += yyleng;}
"read" {printf("READ\n"); currPos += yyleng;}
"write" {printf("WRITE\n"); currPos += yyleng;}
"and" {printf("AND\n"); currPos += yyleng;}
"or" {printf("OR\n"); currPos += yyleng;}
"not" {printf("NOT\n"); currPos += yyleng;}
"true" {printf("TRUE\n"); currPos += yyleng;}
"false" {printf("FALSE\n"); currPos += yyleng;}
"return" {printf("RETURN\n"); currPos += yyleng;}

/* ARITHMETIC OPERATORS */
"-" {printf("SUB\n"); currPos += yyleng;}
"+" {printf("ADD\n"); currPos += yyleng;}
"*" {printf("MULT\n"); currPos += yyleng;}
"/" {printf("DIV\n"); currPos += yyleng;}
"%" {printf("MOD\n"); currPos += yyleng;}

/* NUMBERS AND IDENTIFIERS */
{DIGIT}+    {printf("NUMBER %s\n", yytext); currPos += yyleng;}
{LETTERS}(_?({LETTERS}|{DIGIT}))*  {printf("IDENT %s\n", yytext); currPos += yyleng;}

/* SPECIAL SYMBOLS */
";"         {printf("SEMICOLON\n"); currPos += yyleng;}

/* ERRORS */
{DIGIT}(_?({LETTERS}|{DIGIT}))* {printf("ERROR at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);} /* Catches identifiers that start with digits */
{LETTERS}(_?({LETTERS}|{DIGIT})_?)* {printf("ERROR at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);} /* Catches identifiers that end with underscore */
.	{printf("ERROR at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
