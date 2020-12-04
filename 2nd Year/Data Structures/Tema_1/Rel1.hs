import Test.QuickCheck
--Relacion 1
--Ejercicio 1. x y z deben ser enteros positivos
--a
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z | x<=0 || y<=0 || z <=0 = error "Un argumento no es entero positivo"
              | x^2 + y^2 == z^2 = True
              | otherwise = False
--b
terna :: Integer -> Integer -> (Integer,Integer,Integer)
terna x y | x>0 && y>0 && x>y =(x^2-y^2,2*x*y,x^2+y^2)
          | otherwise = error "Un argumento no es entero positivo o el primer argumento es menor que el segundo"
--c
p_ternas x y = x>0 && y>0 && x>y ==> esTerna a b c
  where
    (a,b,c) = terna x y

--Ejercicio 2.
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)

--Ejercicio 3
--a
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x<y = (x,y)
              | otherwise = (y,x)

p1_ordena2 x y = enOrden (ordena2 (x,y))
  where enOrden (x,y) = x <=y

p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
  where mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z)
--b
ordena3 :: Ord a => (a,a,a) -> (a,a,a)
ordena3 (x,y,z) | x > y = ordena3 (y,x,z)
                | y > z = ordena3 (x,z,y)
                | otherwise = (x,y,z)
--c
p1_ordena3 x y z = enOrden (ordena3 (x,y,z))
  where enOrden (x,y,z)= x<=y && y<=z

--Ejercicio 4
--a
max2 :: Ord a => a -> a -> a
max2 x y | x>=y = x
         | otherwise = y
--b
p1_max2 x y = coincide x y (max2 x y)
  where coincide x y z = x==z || y==z
p2_max2 x y = mayIgu x y (max2 x y)
  where mayIgu x y z = z>=x && z>=y
p3_max2 x y = x>=y ==> max2 x y == x
p4_max2 x y = y>=x ==> max2 x y == y

--Ejercicio 5
entre :: Ord a => a -> (a,a) -> Bool
entre x (y,z) | y<=x && x<=z = True
              | otherwise = False

--Ejercicio 6
iguales3 :: Eq a => (a,a,a) -> Bool
iguales3 (x,y,z) | x==y && y==z = True
                 | otherwise = False

--Ejercicio 7
--a
type TotalSegundos = Integer
type Horas = Integer
type Minutos = Integer
type Segundos = Integer
descomponer :: TotalSegundos -> (Horas, Minutos, Segundos)
descomponer x = (horas, minutos, segundos)
  where horas = div (div x 60) 60
        minutos = mod (div x 60) 60
        segundos = mod x 60
--b
p_descomponer x = x>=0 ==> h*3600 + m*60 + s == x && entre m (0,59) && entre s (0,59)
  where (h,m,s) = descomponer x

--Ejercicio 8
unEuro :: Double
unEuro = 166.386
--a
pesetasAEuros :: Double -> Double
pesetasAEuros x = x/unEuro
--b
eurosAPesetas :: Double -> Double
eurosAPesetas x = x*unEuro
--c
p_inversas x = eurosAPesetas (pesetasAEuros x) == x

--Ejercicio 9
infix 4 ~=
(~=) :: Double -> Double -> Bool
x ~= y = abs (x-y) < epsilon
  where epsilon = 1/1000
p2_inversas x = eurosAPesetas (pesetasAEuros x) ~= x

--Ejercicio 10
--a
raices :: (Num a,Ord a,Fractional a,Floating a) => a -> a -> a -> (a,a)
raices x y z | y^2-4*x*z >= 0 = (r1,r2)
             | otherwise = error "Raices no reales"
  where
    r = sqrt (y^2-4*x*z)
    r1 = (-y+r)/(2*x)
    r2 = (-y-r)/(2*x)
--b
p1_raices a b c  = esRaíz r1 && esRaíz r2
    where
    (r1,r2) = raices a b c
    esRaíz r = a*r^2 + b*r + c ~= 0

p2_raices a b c = a>0 && b^2-4*a*c >= 0 ==> esRaíz r1 && esRaíz r2
  where
    (r1,r2) = raices a b c
    esRaíz r = a*r^2 + b*r + c ~= 0

--Ejercicio 11
esMultiplo :: Integral a => a -> a -> Bool
esMultiplo x y | mod x y == 0 = True
               | otherwise = False

--Ejercicio 12
infixl 1 ==>>
(==>>):: Bool -> Bool -> Bool
x ==>> y | x==True && y==False = False
         | otherwise = True

--Ejercicio 13
esBisiesto :: Integer -> Bool
esBisiesto x | mod x 4 == 0 && (mod x 100 == 0 ==>> mod x 400 == 0) = True
             | otherwise = False

--Ejercicio 14
--a
potencia :: (Num a,Ord a) => a -> a -> a
potencia x y | y==0 = 1
             | y==1 = x
             | otherwise = x * potencia x (y-1)
--b
potencia' :: (Num a, Ord a, Integral a) => a -> a -> a
potencia' x y | mod y 2 == 0 = (x^(div y 2))^2
              | otherwise = x * potencia' x (y-1)
--c
p_pot b n = n>=0 ==> potencia b n == sol && potencia' b n == sol
  where sol = b^n
--d
--La funcion potencia realiza y-1 productos cuando y != 0 y cuando y == 0 realiza 0 productos
--La funcion potencia' realiza y/2 productos cuando es par y y/2 + 1 productos cuando es impar

--Ejercicio 15
factorial :: Integer -> Integer
factorial x | x==0 = 1
            | x==1 = 1
            | x>1 = x * factorial (x-1)
            | otherwise = error "Numero negativo"

--Ejercicio 16
--a
divideA :: (Num a,Eq a, Integral a) => a -> a -> Bool
divideA x y | mod y x == 0 = True
            | otherwise = False
--b
p1_divideA x y = y/=0 && y `divideA` x ==> div x y * y == x
--c
p2_divideA x y z = x/=0 && divideA x y && divideA x z ==> divideA x (y+z)

--Ejercicio 17
mediana :: Ord a => (a,a,a,a,a) -> a
mediana (x,y,z,t,u) | x>y = mediana (y,x,z,t,u)
                    | y>z = mediana (x,z,y,t,u)
                    | z>t = mediana (x,y,t,z,u)
                    | t>u = mediana (x,y,z,u,t)
                    | otherwise = z
