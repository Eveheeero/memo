module Lib
  ( someFunc,
  )
where

import Folder (baseFolder)

someFunc :: IO ()
someFunc =
  do
    base <- baseFolder
    let out = show base
    putStrLn out
