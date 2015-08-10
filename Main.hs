module Main where

import Control.Exception
import Control.Monad
import System.Directory
import System.Environment
import System.FilePath
import System.FilePath.Glob
import System.Posix.Files

zfill :: Int -> String
zfill n = let ns = show n in replicate (3-length ns) '0' ++ ns

listGenerations :: FilePath -> IO [Int]
listGenerations genname = do
  paths <- glob $ combine genname "[0-9][0-9][0-9]"
  let gens = map (read . takeFileName) paths  :: [Int]
  return gens

lastGeneration :: FilePath -> IO Int
lastGeneration genname = do
  gens <- listGenerations genname
  return $ foldr max 0 gens -- 0, if empty gdg

newSymbolicLink :: FilePath -> FilePath -> FilePath -> IO ()
newSymbolicLink gdgName target linkName = do
  let symlink = combine gdgName linkName
  ps <- getDirectoryContents gdgName
  when (elem linkName ps) $ do
    removeFile symlink
  createSymbolicLink target symlink

makeGeneration :: FilePath -> Int -> IO String
makeGeneration gdgName gen = do
  let newgen = combine gdgName $ zfill gen
  createDirectory newgen
  newSymbolicLink gdgName (zfill gen) "latest"
  when (gen > 1) $ do
    newSymbolicLink gdgName (zfill (gen-1)) "previous"
  cwd <- getCurrentDirectory
  return $ combine cwd newgen
  
main = do
  [gdgName] <- getArgs
  cc <- doesDirectoryExist gdgName
  when (not cc) $ do
    createDirectory gdgName
  lastGen <- lastGeneration gdgName
  newGen <- makeGeneration gdgName $ lastGen + 1
  putStrLn newGen
