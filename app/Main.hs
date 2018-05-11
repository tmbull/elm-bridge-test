{-# LANGUAGE TemplateHaskell #-}

import Data.Aeson (FromJSON, ToJSON)
import Data.Proxy

import Elm.Derive
import Elm.Module

import Lib (uncapitalize)

data Size
  = Small
  | Medium
  | Large
  deriving (Show, Eq)

deriveBoth defaultOptions ''Size

data DogProps = DogProps
  { dogHasSpots :: Bool
  , dogSize :: Size
  , dogName :: String
  } deriving (Show, Eq)

deriveBoth defaultOptions {fieldLabelModifier = uncapitalize . drop 3} ''DogProps

data Breed
  = Calico
  | Siamese
  | Tabby
  deriving (Show, Eq)

deriveBoth defaultOptions ''Breed

data CatProps = CatProps
  { catHasClaws :: Bool
  , catBreed :: Breed
  , catName :: String
  } deriving (Show, Eq)

deriveBoth defaultOptions {fieldLabelModifier = uncapitalize . drop 3} ''CatProps

data Animal
  = Dog DogProps
  | Cat CatProps
  deriving (Show, Eq)

deriveBoth defaultOptions ''Animal

data Foo
   = Foo
   { f_name :: String
   , f_blablub :: Int
   , f_animal :: Animal
   } deriving (Show, Eq)

deriveBoth defaultOptions {fieldLabelModifier = uncapitalize . drop 2} ''Foo

main :: IO ()
main =
    putStrLn $ makeElmModule "Foo"
    [ DefineElm (Proxy :: Proxy Size)
    , DefineElm (Proxy :: Proxy DogProps)
    , DefineElm (Proxy :: Proxy Breed)
    , DefineElm (Proxy :: Proxy CatProps)
    , DefineElm (Proxy :: Proxy Animal)    
    , DefineElm (Proxy :: Proxy Foo)
    ]
