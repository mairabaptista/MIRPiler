/****************************************************/
/* File: cminus.l                                   */
/* Lexical analyzer for C- compiler                 */
/****************************************************/

%{
    #include "globals.h"
    #include "util.h"
    #include "scan.h"
    /* lexeme of identifier or reserved word */
    int comentario = 0;
    char tokenString[MAXTOKENLEN+1];
    static int yylex(void);
%}

%option noyywrap

digit           [0-9]
number          {digit}+
letter          [a-zA-Z_]
letterOrNumber  [a-zA-Z_0-9]
identifier      {letter}+ 
newline         \n
whitespace      [ \t]+ 

%x C_COMMENT

%%

"/*"            {BEGIN(C_COMMENT);}
<C_COMMENT>"*/" {BEGIN(INITIAL);}
<C_COMMENT>"\n" {lineno++;}
<C_COMMENT>.    {}

"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"return"        { return RETURN; }
"int"           { return INT; }
"void"          { return VOID; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }

"="             { return ASSIGN; }

"<"             { return LT; }
"<="            { return LE; }
">"             { return GT; }
">="            { return GE; }
"=="            { return EQ; }
"!="            { return NEQ; }


";"             { return SEMI; }
","             { return COMMA; }
"("             { return OPAREN; }
")"             { return CPAREN; }
"["             { return OBRACKET; }
"]"             { return CBRACKET; }
"{"             { return OCURLY; }
"}"             { return CCURLY; }

{number}        { return NUM; }
{identifier}    { return ID; }
{newline}       { lineno++; }
{whitespace}    { /* skip whitespace */ }

.               { return ERROR; }

%%

TokenType getToken(void)
{ static int firstTime = TRUE;
  TokenType currentToken;
  if (firstTime)
  { firstTime = FALSE;
    lineno++;
    yyin = source;
    yyout = listing;
  }
  currentToken = yylex();
  
  strncpy(tokenString,yytext,MAXTOKENLEN);
  if (TraceScan) {
    fprintf(listing,"\t%d: ",lineno);
    printToken(currentToken,tokenString);
  }
  if(currentToken == ERROR){
    fprintf(listing,"Lexical error at line %d:\n",lineno);
    fprintf(listing,"Current token: ");
    printToken(currentToken,tokenString);
    yyterminate();
  }
  return currentToken;
}
