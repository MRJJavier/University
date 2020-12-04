module Expression
    (
    Item (..),
    Expression,
    value,
    showExpr,
    sample1,
    ) where

      data Item = Add | Dif | Mul | Value Integer | LeftP | RightP deriving Show

      type Expression = [Item]

      -- sample1 corresponde con 5 + (6 - 2) * 3
      sample1 = [ Value 5, Add, LeftP, Value 6, Dif, Value 2, RightP, Mul, Value 3 ]
    
      sample :: Expression
      sample = [ LeftP, LeftP, Value 4, Mul, Value 5, RightP, Dif, Value 6, RightP]
      -- sample se corresponde con la expresión ( (4 * 5) - 6)      
    
      value :: Item -> Integer -> Integer -> Integer
      value Add x y = x+y
      value Dif x y = x-y
      value Mul x y = x*y

      showExpr :: Expression -> String
      showExpr (Value x : ts) = show x ++ showExpr ts
      showExpr (Add : ts) = '+' : showExpr ts
      showExpr (Dif : ts) = '-' : showExpr ts
      showExpr (Mul : ts) = '*' : showExpr ts
      showExpr (LeftP : ts) = '(' : showExpr ts
      showExpr (RightP : ts) = ')' : showExpr ts
      showExpr ts = []
