module Main (main) where

import qualified Brick
import Lib ()

ui :: Brick.Widget ()
ui = Brick.str "Hello World"

main :: IO ()
main =
  do
    Brick.simpleMain ui
    return ()
