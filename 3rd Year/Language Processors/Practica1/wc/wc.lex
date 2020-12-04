
%%

%%
\n|\r  { 
            return new Yytoken(Yytoken.LINEA,yylength());
        }
[^\ ]   {
            return new Yytoken(Yytoken.PALABRA,yylength());
        }
.       {}
