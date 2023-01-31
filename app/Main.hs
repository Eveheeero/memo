{-# LANGUAGE ImportQualifiedPost #-}

module Main (main) where

import Brick ((<=>))
import Brick qualified
import Brick.Widgets.Border qualified
import Brick.Widgets.Center qualified
import Lib ()

str :: String -> Brick.Widget ()
str = Brick.str

vBox :: [Brick.Widget n] -> Brick.Widget n
vBox = Brick.vBox

hBox :: [Brick.Widget n] -> Brick.Widget n
hBox = Brick.hBox

out :: Ord n => Brick.Widget n -> s -> IO s
out widget status = do
  let wrapped = (Brick.Widgets.Border.border . center) widget
  let app = Brick.simpleApp wrapped
  Brick.defaultMain app status

center :: Brick.Widget n -> Brick.Widget n
center = Brick.Widgets.Center.center

main :: IO ()
main =
  do
    let left_menu = (Brick.Widgets.Border.border . vBox) [str "Hello 1", str "Hello 2"]
    let frame = hBox [left_menu, str "Hello 3"]
    out frame ()
