module Lib
    ( uncapitalize
    ) where

import Data.Char (toLower)

uncapitalize :: String -> String
uncapitalize = \xs -> toLower (head xs) : (tail xs)
