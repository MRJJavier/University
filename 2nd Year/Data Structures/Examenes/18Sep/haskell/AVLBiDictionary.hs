-------------------------------------------------------------------------------
-- Apellidos, Nombre:
-- Titulacion, Grupo:
--
-- Estructuras de Datos. Grados en Informatica. UMA.
-------------------------------------------------------------------------------

module AVLBiDictionary( BiDictionary
                      , empty
                      , isEmpty
                      , size
                      , insert
                      , valueOf
                      , keyOf
                      , deleteByKey
                      , deleteByValue
                      , toBiDictionary
                      , compose
                      , isPermutation
                      , orbitOf
                      , cyclesOf
                      ) where

import qualified DataStructures.Dictionary.AVLDictionary as D
import qualified DataStructures.Set.BSTSet               as S

import           Data.List                               (intercalate, nub,
                                                          (\\),length)
import           Data.Maybe                              (fromJust, fromMaybe,
                                                          isJust)
import           Test.QuickCheck


data BiDictionary a b = Bi (D.Dictionary a b) (D.Dictionary b a)

-- | Exercise a. empty, isEmpty, size

empty :: (Ord a, Ord b) => BiDictionary a b
empty = Bi D.empty D.empty

isEmpty :: (Ord a, Ord b) => BiDictionary a b -> Bool
isEmpty (Bi dictKv dictVk) = D.isEmpty dictKv && D.isEmpty dictVk

size :: (Ord a, Ord b) => BiDictionary a b -> Int
size (Bi dictKv dictVk) = div (D.size dictKv + D.size dictVk) 2

-- | Exercise b. insert

insert :: (Ord a, Ord b) => a -> b -> BiDictionary a b -> BiDictionary a b
insert x y (Bi dictKv dictVk) = Bi (D.insert x y dictKv) (D.insert y x dictVk)

-- | Exercise c. valueOf

valueOf :: (Ord a, Ord b) => a -> BiDictionary a b -> Maybe b
valueOf x (Bi dictKv dictVk) = D.valueOf x dictKv

-- | Exercise d. keyOf

keyOf :: (Ord a, Ord b) => b -> BiDictionary a b -> Maybe a
keyOf x (Bi dictKv dictVk) = D.valueOf x dictVk

-- | Exercise e. deleteByKey

deleteByKey :: (Ord a, Ord b) => a -> BiDictionary a b -> BiDictionary a b
deleteByKey x bi@(Bi dictKv dictVk)
  | not $ D.isDefinedAt x dictKv = bi
  | otherwise = Bi dictKv' dictVk'
  where
    Just y = valueOf x bi
    dictKv' = D.delete x dictKv
    dictVk' = D.delete y dictVk

-- | Exercise f. deleteByValue

deleteByValue :: (Ord a, Ord b) => b -> BiDictionary a b -> BiDictionary a b
deleteByValue x bi@(Bi dictKv dictVk)
  | not $ D.isDefinedAt x dictVk = bi
  | otherwise = Bi dictKv' dictVk'
  where
    Just y = keyOf x bi
    dictKv' = D.delete y dictKv
    dictVk' = D.delete x dictVk

-- | Exercise g. toBiDictionary

toBiDictionary :: (Ord a, Ord b) => D.Dictionary a b -> BiDictionary a b
toBiDictionary dict | not inyectivo = error "No es inyectivo"
                    | otherwise = toBiDictionaryAux kv empty
  where
    valores = [ v | v <- D.values dict]
    valores' = nub valores
    inyectivo = length valores == length valores'
    kv = [(k,v) | (k,v) <- D.keysValues dict]

toBiDictionaryAux :: (Ord a, Ord b) => [(a,b)] -> BiDictionary a b -> BiDictionary a b
toBiDictionaryAux [] bi = bi
toBiDictionaryAux (x:xs) bi = toBiDictionaryAux xs (insert k v bi)
  where
    (k,v) = x

-- | Exercise h. compose

compose :: (Ord a, Ord b, Ord c) => BiDictionary a b -> BiDictionary b c -> BiDictionary a c
compose (Bi dictab dictba) (Bi dictbc dictcb) = toBiDictionaryAux kv empty
  where
    kv = [ (x,z) | (x,y) <- D.keysValues dictab, (y',z) <- D.keysValues dictbc, y==y']

-- | Exercise i. isPermutation

isPermutation :: Ord a => BiDictionary a a -> Bool
isPermutation (Bi dictKv dictVk) = minus == []
  where
    keys = [ x | x <- D.keys dictKv]
    values = [ y | y <- D.keys dictVk]
    minus =  (\\) keys values



-- |------------------------------------------------------------------------


-- | Exercise j. orbitOf

orbitOf :: Ord a => a -> BiDictionary a a -> [a]
orbitOf x bi | not $ isPermutation bi = error "No es permutacion"
             | otherwise = orbitOfAux x bi []

orbitOfAux :: Ord a => a -> BiDictionary a a -> [a] -> [a]
orbitOfAux x bi@(Bi dictKv dictVk) list
  | taml == taml' = orbitOfAux sig bi (x:list)
  | otherwise = init list
    where
      Just sig = D.valueOf x dictKv
      taml = length list
      taml' = length $nub list
-- | Exercise k. cyclesOf

--No consigo quitar las repetidas
cyclesOf :: Ord a => BiDictionary a a -> [[a]]
cyclesOf bi@(Bi dictKv dictVk)= cycles
  where
    keys = [ x | x <- D.keys dictKv]
    orbits = [ y | x <- keys, let y = orbitOf x bi]
    cycles = foldr (\\) orbits []
-- |------------------------------------------------------------------------


instance (Show a, Show b) => Show (BiDictionary a b) where
  show (Bi dk dv)  = "BiDictionary(" ++ intercalate "," (aux (D.keysValues dk)) ++ ")"
                        ++ "(" ++ intercalate "," (aux (D.keysValues dv)) ++ ")"
   where
    aux kvs  = map (\(k,v) -> show k ++ "->" ++ show v) kvs
