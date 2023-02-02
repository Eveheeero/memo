import Memo.Folder (baseFolder)

main :: IO ()
main =
  do
    baseFolder >>= putStrLn
