module InFix where
  import Test.QuickCheck
  import DataStructures.Stack.LinearStack as S
  import Expression


  evaluateInFix :: Expression -> Integer
  evaluateInFix [] s1 s2 = top s1
  evaluateInFix (Value t : ts) s1 s2 = evaluateInFix ts (push t s1) s2
  evaluateInFix ( op : ts) s1 s2 = evaluateInFix ts s1 (push op s2)
  evaluateInFix (LeftP : ts) s1 s2 = evaluateInFix ts s1 s2
  evaluateInFix (RightP : ts) s1 s2 = evaluateInFix ts (push (value oper arg1 arg2) s1ss) s2s
    where
      s1 = S.empty
      s2 = S.empty
      arg1 = top s1
      s1s = pop s1
      arg2 = top s1s
      s1ss = pop s1s
      oper = top s2
      s2s = pop s2
