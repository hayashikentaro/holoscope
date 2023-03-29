module Main where

import Prelude
import Control.Plus (empty)
import Data.List (List(..), filter, head)
import Data.Maybe (Maybe)
import Effect.Console (log)

calc :: Int -> Int
calc a = a + 1

appText :: String
appText = (show <<< calc) 2

main = do
  log ("The answer is " <> show appText)
