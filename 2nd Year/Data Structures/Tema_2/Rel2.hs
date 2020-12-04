import Test.QuickCheck
import Data.List
--Ejercicio 1
data Direction = North | South | East | West deriving (Eq, Enum, Show)
--a
(<<) :: Direction -> Direction -> Bool
(<<) x y | fromEnum x < fromEnum y = True
         | otherwise = False
p_menor x y = (x < y) == (x << y)
instance Arbitrary Direction where
  arbitrary = do
    n <- choose (0,3)
    return $ toEnum n
--b
instance Ord Direction where
  North <= _     = True
  South <= North = False
  South <= _     = True
  East  <= North = False
  East  <= South = False
  East  <= _     = True
  West  <= North = False
  West  <= South = False
  West  <= East  = False
  West  <= _     = True

--Ejercicio 2
--a
maximoYresto :: Ord a => [a] -> (a, [a])
maximoYresto xs = (maximum xs, filter (\x -> maximum xs /= x) xs)

--Ejercicio 3
reparte :: [a] -> ([a],[a])
reparte [] = ([],[])
reparte [x] = ([x],[])
reparte (x:y:xs) = (x:u,y:v)
  where
    (u,v)=reparte xs

--Ejercicio 4
distintos :: Eq a => [a] -> Bool
distintos [] = True
distintos [_] = True
distintos [x,y] = x/=y
distintos (x:y:xs)  =  x /= y && distintos (x:xs) && distintos (y:xs)

--Ejercicio 5
--a
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' x y = y : replicate' (x-1) y
--b
p_replicate' n x = n >= 0 && n <= 1000 ==> length (filter (==x) xs) == n && length (filter (/=x) xs) == 0
  where
    xs = replicate' n x

--Ejercicio 6
divisores :: (Num a, Eq a, Integral a, Enum a) => a -> [a]
divisores 0 = []
divisores x = filter (divideA) (y:ys)
  where
    divideA y = mod x y == 0
    (y:ys) =[1..x]

divisores' :: (Num a, Eq a, Integral a, Enum a) => a -> [a]
divisores' x| x == 0 = []
            | x >  0 = filter (divideA) (y:ys)
            | x <  0 = filter (divideA) (z:zs)
    where
      divideA y = mod x y == 0
      (y:ys) = [1..x]
      (z:zs) = [x..(-1)] ++ [1..(-x)]

--Ejercicio 7
--a
mcd :: Int -> Int -> Int
mcd x y = maximum [s | s<-divisores' x , t<- divisores' y, s==t]
--b
p_mcd x y z = x/=0 && y/=0 && z/=0 ==> mcd (z*x) (z*y) == abs z * mcd x y
--c
mcm :: Int -> Int -> Int
mcm x y = div (x*y) (mcd x y)

--Ejercicio 8
--a
esPrimo :: Integral a => a -> Bool
esPrimo x | x==0 = False
          | x==1 = False
          | x>1  = length (drop 1 (divisores x)) == 1
--b
primosHasta :: Integral a => a -> [a]
primosHasta x = [y | y <-[1..x], esPrimo y]
--c
primosHasta' :: Integral a => a -> [a]
primosHasta' x = filter esPrimo [1..x]
--d
p_primos x = primosHasta x == primosHasta' x

--Ejercicio 9
goldbach :: Integral a => a -> [(a,a)]
goldbach x | even x && x>2 = [(u,v)]
           | otherwise = error "El numero es impar o es menor o igual que 2"
  where
    xs = primosHasta' x
    v = if x-(maximum xs) /=1 then maximum xs else maximum (init xs)
    u = head (filter (==(x-v)) xs)
--a
pares :: Integral a => a ->[(a,a)]
pares x = [(u,v) | u <- primosHasta' x, v <- primosHasta' x, u+v==x && u<=v]
--b
cumpleGoldbach :: Integral a => a -> Bool
cumpleGoldbach x | even x && not (null (goldbach x)) = True
                 | otherwise = False
--c
goldbachHasta :: Integral a => a -> Bool
goldbachHasta x | x>3 && and xs = True
                | otherwise = False
  where
    xs = [cumpleGoldbach u | u<-[4,6..x]]
--d goldbachDebilHasta

--Ejercicio 10
--a
esPerfecto :: Integral a => a -> Bool
esPerfecto x | foldr (+) 0 [y | y<-[1..(x-1)], mod x y == 0 ] == x = True
             | otherwise = False
--b
perfectosMenoresQue :: Integral a => a -> [a]
perfectosMenoresQue x = [y | y<-[1..x], esPerfecto y]

--Ejercicio 11
--a
take' :: Int -> [a] ->[a]
take' n xs = [ x | (p,x)<- zip [0..(length xs)] xs, p<n]
--b
drop' :: Int -> [a] -> [a]
drop' n xs = [x | (p,x)<- zip[0..(length xs)] xs, p>=n]
--c
p_takedrop n xs = n>=0 ==> take' n xs ++ drop' n xs == xs

--Ejercicio 12
--a
concat' :: [[a]] -> [a]
concat' xss = foldr (++) [] xss
--b
concat'' :: [[a]] -> [a]
concat'' xss = [ x | xs <- xss, x<-xs]

--Ejercicio 13
desconocida :: (Ord a) => [a] -> Bool
desconocida xs = and [x<=y | (x,y) <- zip xs (tail xs)]

--Ejercicio 14
--a
inserta :: Ord a => a -> [a] -> [a]
inserta x xs = takeWhile (<x) xs ++ x : dropWhile (<x) xs
--b
inserta' :: Ord a => a -> [a] -> [a]
inserta' n [] = [n]
inserta' n (x:xs) = if n<x then n:x:xs else x:inserta' n xs
--c
p_inserta x xs = desconocida xs ==> desconocida (inserta x xs)
--e
ordena :: Ord a => [a] -> [a]
ordena [] = []
ordena (x:xs) = foldr inserta [] (x:xs)
--f
p_ordena xs = desconocida (ordena xs)

--Ejercicio 15
--a
geometrica :: Integral a => a -> a -> [a]
geometrica x y = iterate (*y) x
--b
p_geometrica x r = x>0 && r>0 ==> and [ div z y == r | (y,z) <- zip xs (tail xs)]
  where xs = take 100 (geometrica x r)
--c
multiplosDe :: Integral a => a -> [a]
multiplosDe x = iterate (+x) 0
--d
potenciasDe :: Integral a => a -> [a]
potenciasDe x = iterate (*x) 1

--Ejercicio 16
--a
--Ya esta hecha
--b
primeroComun :: Ord a => [a] -> [a] -> a
primeroComun (x:xs) (y:ys) | x<y = primeroComun xs (y:ys)
                           | x>y = primeroComun (x:xs) ys
                           | x==y = x
                           | otherwise = error "No hay ninguno común"
--c
mcm' :: Integral a => a -> a -> a
mcm' x y = primeroComun  (take 100 (tail (multiplosDe x)))  (take 100 (tail (multiplosDe y)))
--d
p_mcm x y = x>=1 && y>=1 ==> mcm' x y == lcm x y

--Ejercicio 17
primeroComunDeTres :: Ord a => [a] -> [a] -> [a] -> a
primeroComunDeTres (x:xs) (y:ys) (z:zs)
  | x > y = primeroComunDeTres (x:xs) ys (z:zs)
  | y > z = primeroComunDeTres (x:xs) (y:ys) zs
  | z > x = primeroComunDeTres xs (y:ys) (z:zs)
  | otherwise = x

--Ejercicio 34
type Izdo = Double
type Dcho = Double
type Epsilon = Double
type Función = Double -> Double
bipartición :: Función -> Izdo -> Dcho -> Epsilon -> Double
bipartición f a b epsilon
  | long <= epsilon    = c
  | f c == 0 = c
  | (f b < 0 && f c >=0) || (f c < 0 && f b >=0) = bipartición f a c epsilon
  | otherwise = bipartición f c b epsilon

-- sigue aqui
  where
      long = b - a
      c = long/2 + a
-- sigue aqui
