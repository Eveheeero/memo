{-# LANGUAGE ImportQualifiedPost #-}

module Folder (baseFolder) where

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
baseFolder = do
  folder <- baseFolder_
  exist <- doesDirectoryExist folder
  if not exist
    then do
      createDirectory folder
      return folder
    else return folder

baseFolder_ = do
  home <- homeFolder
  baseFolder__ home

homeFolder = System.Environment.getEnv "HOME"

baseFolder__ home = do
  if System.Info.os == "mingw32"
    then return (home ++ "\\AppData\\Roaming\\memo")
    else return (home ++ "/.config/memo")