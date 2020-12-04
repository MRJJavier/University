

%%

%%

(0|[1-9][0-9]*)                             |
(0)[0-7]+                        	    |
(0x)[0-9a-fA-F]+                            {
                                                return new Yytoken(Yytoken.TOKEN_CTE_ENTERO, yytext());    
                                            }
(0|[1-9][0-9]*)(L|l)                        |
(0)[0-7]+(L|l)                   	    |
(0x)[0-9a-fA-F]+(L|l)                       {
                                                return new Yytoken(Yytoken.TOKEN_CTE_ENTERO_LARGO, yytext());
                                            }
[0-9]*\.[0-9]+(E(\+|-)?[0-9]+)?(D|d)?       |
[0-9]+\.[0-9]*(E(\+|-)?[0-9]+)?(D|d)?       |
[0-9]+E(\+|-)?[0-9]+(D|d)? 		    |
[0-9]+(D|d)			    {
                                                return new Yytoken(Yytoken.TOKEN_CTE_REAL_LARGO, yytext());
                                            }
[0-9]*\.[0-9]+(E(\+|-)?[0-9]+)?(F|f)        |
[0-9]+\.[0-9]*(E(\+|-)?[0-9]+)?(F|f)        |
[0-9]+E(\+|-)?[0-9]+(F|f) 		    |
[0-9]+(F|f)			    {
                                                return new Yytoken(Yytoken.TOKEN_CTE_REAL_CORTO, yytext());
                                            }
[-a-zA-Z0-9\+\*\.]+                         { 
                                                return new Yytoken(Yytoken.TOKEN_ERROR, yytext());
                                            }
[^]                                         {
					    }

            
    
