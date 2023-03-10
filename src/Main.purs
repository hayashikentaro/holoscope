module Main where

import Prelude
import Control.Plus (empty)
import Data.List (List(..), filter, head)
import Data.Maybe (Maybe)

calc :: Int -> Int
calc a = a + 1

appText :: String
appText = (show <<< calc) 2
