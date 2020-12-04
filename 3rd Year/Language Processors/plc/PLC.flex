import java_cup.runtime.*;
%%

/*  Declaraciones */   
   
%cup 

%%   

"="                  { return new Symbol(sym.ASIG);}
"+"                  { return new Symbol(sym.MAS);}
"-"                  { return new Symbol(sym.MENOS);}
"*"                  { return new Symbol(sym.POR);}
"/"                  { return new Symbol(sym.DIV);}
"("                  { return new Symbol(sym.AP);}
")"                  { return new Symbol(sym.CP);}
"{"                  { return new Symbol(sym.AC);}
"}"                  { return new Symbol(sym.CC);}
";"                  { return new Symbol(sym.PYC);}
"=="                 { return new Symbol(sym.EQ);}
"!="                 { return new Symbol(sym.NE);}
"<"                  { return new Symbol(sym.LT);}
"<="                 { return new Symbol(sym.LE);}
">"                  { return new Symbol(sym.GT);}
">="                 { return new Symbol(sym.GE);}
"&&"                 { return new Symbol(sym.AND);}
"||"                 { return new Symbol(sym.OR);}
"!"                  { return new Symbol(sym.NOT);}
if                   { return new Symbol(sym.IF);}
else                 { return new Symbol(sym.ELSE);}
do                   { return new Symbol(sym.DO);}
while                { return new Symbol(sym.WHILE);}
for                  { return new Symbol(sym.FOR);}
print                { return new Symbol(sym.PRINT);}
[a-zA-Z][a-zA-Z0-9]* { return new Symbol(sym.IDENT, yytext());}
0|[1-9][0-9]*        { return new Symbol(sym.NUMERO, yytext());}
\r|\n                { }
\ |\t|\f             { }
[^]                  { throw new Error("Illegal character <"+yytext()+">"); }
