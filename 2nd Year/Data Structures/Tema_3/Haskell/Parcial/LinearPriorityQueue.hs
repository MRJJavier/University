-------------------------------------------------------------------------------
-- Linear implementation of Priority Queues
--
-- Data Structures. Grado en Informática. UMA.
-------------------------------------------------------------------------------

module DataStructures.PriorityQueue.LinearPriorityQueue
  ( PQueue
-- basicas
  , empty    -- 0.25
  , isEmpty  -- 0.25
  , first    -- 0.25
  , dequeue  -- 0.25
  , enqueue  -- 1.00
-- extras
  , mkPQ     -- 1.00 (1.00 con plegado. 0.75 en otro caso)
  , mapPQ    -- 1.00 (1.00 con plegado. 0.75 en otro caso)
  , filterPQ -- 1.00
  , foldrPQ  -- 1.00
  , fromPQ   -- 1.00 (1.00 recursiva. 0.25 con filterPQ)
  , toPQ     -- 1.00 (1.00 recursiva. 0.25 con filterPQ)
  , toList   -- 1.00 (1.00 con plegado. 0.75 en otro caso)
  ) where

import Data.List(intercalate)
import Test.QuickCheck

data PQueue a = Empty | Node a (PQueue a)
-- empty. Crea una cola de prioridad vacia.
-- 0.25
empty ::PQueue a
empty = Empty

-- isEmpty. Comprueba si una cola de prioridad esta vacia.
-- 0.25
isEmpty ::PQueue a -> Bool
isEmpty Empty = True
isEmpty _  = False

-- enqueue. Encola un elemento en una cola de prioridad.
-- 1.00
enqueue :: (Ord a) => a ->PQueue a -> PQueue a
enqueue x Empty  = Node x Empty
enqueue x (Node y ys) | x>y = Node y (enqueue x ys)
                      | otherwise = Node x (Node y ys)

-- first. Devuelve el primer elemento de una cola de prioridad.
-- 0.25
first :: PQueue a -> a
first Empty = error "First on empty priority queue."
first (Node x xs) = x

-- dequeue. Desencola el primer elemento de una cola de prioridad.
-- 0.25
dequeue :: PQueue a -> PQueue a
dequeue Empty = error "Dequeue on empty priority queue"
dequeue (Node x xs) = xs

-- mkPQ. Crea una cola de prioridad con los elementos de la lista.
-- 1.00 (1.00 con plegado. 0.75 en otro caso)
mkPQ :: (Ord a) => [a] -> PQueue a
mkPQ xs = foldr enqueue Empty xs

-- mapPQ. Transforma una cola de prioridad en otra aplicando la
-- funcion dada a cada elemento.
-- Cuidado con esta función. Hay que mantener que sea cola de prioridad
-- 1.00 (1.00 con plegado, 0.75 en otro caso)
mapPQ :: (Ord a, Ord b) => (a -> b) -> PQueue a -> PQueue b
--mapPQ f Empty  = Empty
--mapPQ f (Node x xs) = enqueue (f x) (mapPQ f xs)
mapPQ f (Node x xs) = foldrPQ (\y ys -> enqueue (f y) ys) Empty (Node x xs)
-- filterPQ. Crea una cola de prioridad con los elementos de la cola
-- de prioridad dada que cumplen el predicado.
-- 0.50
filterPQ :: Ord a => (a -> Bool) -> PQueue a -> PQueue a
filterPQ f Empty = Empty
filterPQ f (Node x xs) | f x = enqueue x (filterPQ f xs)
                       | otherwise = filterPQ f xs

-- foldrPQ. Realiza un plegado por la derecha de la cola de prioridad
-- usando la funcion y el caso base dados
-- 1.00
foldrPQ :: (Ord a) => (a -> b -> b) -> b -> PQueue a -> b
foldrPQ f x Empty = x
foldrPQ f x (Node y ys) = y `f` foldrPQ f x ys

-- fromPQ. Devuelve una cola a partir de los elementos que son mayores
-- o iguales a uno dado
-- No es buena solución hacerlo usando filterPQ
-- 1.00 (1.00 recursiva. 0.25 con filterPQ)
fromPQ :: Ord a => a -> PQueue a -> PQueue a
fromPQ _ Empty = Empty
fromPQ x (Node y ys) | x > y = fromPQ x ys
                     | otherwise = (Node y ys)

-- toPQ. Devuelve una cola hasta los elementos menores que uno dado.
-- No es buena solución hacerlo usando filterPQ
-- 1.00 (1.00 recursiva. 0.25 con filterPQ)
toPQ :: Ord a => a -> PQueue a -> PQueue a
toPQ _ Empty = Empty
toPQ x (Node y ys) | x > y = enqueue y (toPQ x ys)
                   | otherwise = Empty

-- toList. Devuelve una lista con los elementos de la cola
-- Es buena solución hacerlo con un plegado
-- 1.00 (1.00 con plegado. 0.75 en otro caso)
toList :: Ord a => PQueue a -> [a]
-- toList Empty = []
-- toList (Node x xs) = x : toList xs
toList xs = foldrPQ (:) [] xs
-- p_pqinversa. Propiedad que comprueba que mkPQueue y toList son inversas una
-- de la otra
-- 0.50
p_pqinversa :: (Ord a) => [a] -> Bool
p_pqinversa xs = xs == toList (mkPQ xs)

-- Tabla de complejidades
-- Completar en la hoja del examen
-- 0.50

-- quitar estos comentarios para probar

-- ===============
-- Ejemplos de uso
-- ===============
s1 = mkPQ [2,5,4,7,9,8,1,6,8,5,7]
-- LinearPQueue(1,2,4,5,5,6,7,7,8,8,9)

s2 = enqueue 10 (enqueue 3 (enqueue 0 s1))
-- LinearPQueue(0,1,2,3,4,5,5,6,7,7,8,8,9,10)

s3 = dequeue s2
-- LinearPQueue(1,2,3,4,5,5,6,7,7,8,8,9,10)

s4 = mapPQ (\x -> x `mod` 5) s3
-- LinearPQueue(0,0,0,1,1,2,2,2,3,3,3,4,4)

s5 = filterPQ even s4
-- LinearPQueue(0,0,0,2,2,2,4,4)

s6 = foldrPQ (-) 0 s5
-- -2

s7 = foldrPQ (\e s -> even e && s) True s5
-- True

s8 = fromPQ 5 s1
-- LinearPQueue(5,5,6,7,7,8,8,9)

s9 = toPQ 5 s1
-- LinearPQueue(1,2,4,5,5)

s10 = toList s1
-- [1,2,4,5,5,6,7,7,8,8,9]












-- ===============================================
--   NO TOCAR ESTA PARTE
-- ===============================================

-- Showing a priority PQueue
instance (Show a) => Show (PQueue a) where
  show q = "LinearPQueue(" ++ intercalate "," (aux q) ++ ")"
    where
     aux Empty      =  []
     aux (Node x q) =  show x : aux q

-- Priority Queue equality
instance (Eq a) => Eq (PQueue a) where
  Empty      == Empty           =  True
  (Node x q) == (Node x' q')    =  x==x' && q==q'
  _          == _               =  False

-- This instance is used by QuickCheck to generate random Priority Queues
instance (Ord a, Arbitrary a) => Arbitrary (PQueue a) where
    arbitrary =  do
      xs <- listOf arbitrary
      return (foldr enqueue empty xs)
