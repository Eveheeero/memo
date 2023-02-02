{-# LANGUAGE ImportQualifiedPost #-}

module Main (main) where

import Brick ((<+>))
import Brick qualified
import Brick.Widgets.Border qualified
import Brick.Widgets.Center qualified
import Brick.Widgets.Table qualified
import Control.Monad (unless, when)
import Memo ()
import System.Environment qualified

str :: String -> Brick.Widget ()
str = Brick.str

hBox :: [Brick.Widget n] -> Brick.Widget n
hBox = Brick.hBox

vLimit :: Int -> Brick.Widget n -> Brick.Widget n
vLimit = Brick.vLimit

out :: Ord n => Brick.Widget n -> s -> IO s
out widget status = do
  let app = Brick.simpleApp widget
  Brick.defaultMain app status

border :: Brick.Widget n -> Brick.Widget n
border = Brick.Widgets.Border.border

center :: Brick.Widget n -> Brick.Widget n
center = Brick.Widgets.Center.center

vCenter :: Brick.Widget n -> Brick.Widget n
vCenter = Brick.Widgets.Center.vCenter

table :: [Brick.Widget n] -> Brick.Widget n
table = Brick.Widgets.Table.renderTable . Brick.Widgets.Table.table . reverseList . reverse

reverseList :: [a] -> [[a]]
reverseList x
  | length x == 1 = [x]
  | otherwise = [last x] : reverseList (init x)

strTable :: [String] -> [Brick.Widget ()]
strTable x
  | length x == 1 = [str (head x)]
  | otherwise = str (head x) : strTable (tail x)

iteractive :: IO ()
iteractive =
  do
    out frame ()
  where
    left_menu = vLimit 20 ((vCenter . table . strTable) ["FirstMenu", "SecondMenu"])
    right = (border . center . hBox) [str "First", str "Second"]
    frame = left_menu <+> right

main :: IO ()
main =
  do
    args <- System.Environment.getArgs
    when (null args) (putStrLn "옵션 표시하기")
    unless
      (null args)
      ( do
          let argLength = length args
          case args !! 0 of
            "--interactive" -> iteractive
            _ ->
              ( do
                  putStrLn "옵션 표시하기"
                  putStrLn "키워드 기반 메모 작성"
                  putStrLn "어떤 키워드였는지 검색"
              )
      )
