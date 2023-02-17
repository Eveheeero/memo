{-# LANGUAGE ImportQualifiedPost #-}

module Memo.Util.Folder (baseFolder) where

import System.Directory (createDirectory, doesDirectoryExist)
import System.Environment qualified
import System.Info qualified

-- | 프로필 홈폴더
homeFolder :: IO String

-- | 메모 기본폴더 경로 반환
--
-- 이때, 폴더가 존재하지 않으면 생성한다.
baseFolder :: IO String
baseFolder_ :: IO String
baseFolder__ :: Monad m => [Char] -> m [Char]

-- | 재귀적으로 폴더 생성
createFolterRecursive :: String -> IO ()

baseFolder = do
  folder <- baseFolder_
  exist <- doesDirectoryExist folder
  if not exist
    then do
      createDirectory folder
      return folder
    else return folder

{- baseFolder_ = homeFolder >>= if System.Info.os == "mingw32" then return . (++ "\\AppData\\Roaming\\memo") else return . (++ "/.config/memo") -}
baseFolder_ = homeFolder >>= baseFolder__

homeFolder = System.Environment.getEnv "HOME"

baseFolder__ home = do
  if System.Info.os == "mingw32"
    then return (home ++ "\\AppData\\Roaming\\memo")
    else return (home ++ "/.config/memo")

createFolterRecursive path = do
  return ()

-- 입력값을 / 이나 \ 기준으로 잘라서 폴더를 생성한다.
-- find이용해서 여러 리스트로 분리 후 tails로 확인할 폴더리스트 생성 ("home", "eveheeero", ".config") 이후에 ["home","eveheeero"], ["home", "eveheeero", ".config"] 이런식으로 모으기
-- 이후 재귀적으로 폴더 생성
