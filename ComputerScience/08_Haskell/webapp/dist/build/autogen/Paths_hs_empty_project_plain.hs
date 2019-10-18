module Paths_hs_empty_project_plain (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/dominik/Haskell/Repo/Haskell/webapp/.cabal-sandbox/bin"
libdir     = "/home/dominik/Haskell/Repo/Haskell/webapp/.cabal-sandbox/lib/x86_64-linux-ghc-7.10.3/hs-empty-project-plain-0.1.0.0-4zVqq24rL6o8315TResALA"
datadir    = "/home/dominik/Haskell/Repo/Haskell/webapp/.cabal-sandbox/share/x86_64-linux-ghc-7.10.3/hs-empty-project-plain-0.1.0.0"
libexecdir = "/home/dominik/Haskell/Repo/Haskell/webapp/.cabal-sandbox/libexec"
sysconfdir = "/home/dominik/Haskell/Repo/Haskell/webapp/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hs_empty_project_plain_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hs_empty_project_plain_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hs_empty_project_plain_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hs_empty_project_plain_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hs_empty_project_plain_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
