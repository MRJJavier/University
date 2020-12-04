import DataStructures.Graph.DiGraph
import DataStructures.Graph.DiGraphBFT
import Data.List


data Estado = J Int Int deriving (Eq, Ord, Show)

topeA = 5
topeB = 7

llenarA (J x y) = J topeA y
llenarB (J x y) = J x topeB

vaciarA (J x y) = J 0 y
vaciarB (J x y) = J x 0

volcarASobreB (J x y)
   | cabeB >= x = J 0 (x+y)
   | otherwise = J (x - cabeB) topeB 
    where
        cabeB = topeB - y

volcarBSobreA (J x y)
    | cabeA >= y = J (x+y) 0
    | otherwise = J topeA (y -cabeA)
    where
        cabeA = topeA - x

ops = [llenarA, llenarB, vaciarA, vaciarB, volcarBSobreA, volcarASobreB]

suc e = nub [ ne | op <- ops, let ne = op e, e /= ne]

jarras = mkDiGraphSuc undefined suc

solFinal (J x y) = x == 1 || y == 1

caminos = filter (\cs -> solFinal (last cs)) (bftPaths jarras (J 0 0))

solucion = minimumBy (\x y -> compare (length x) (length y)) caminos
