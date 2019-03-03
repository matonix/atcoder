{-# LANGUAGE TemplateHaskell #-}
module Main (main) where

import Import
import Run
import RIO.Process
import Options.Applicative.Simple
import qualified Paths_scraper_atcoder

main :: IO ()
main = do
  (options, ()) <- simpleOptions
    $(simpleVersion Paths_scraper_atcoder.version)
    "The scraper for atcoder"
    ""
    (Options
      <$> switch 
        ( long "verbose"
        <> short 'v'
        <> help "Verbose output?"
        )
      <*> (optional $ strOption 
        ( long "contest"
        <> short 'c'
        <> help "Contest name"
        <> metavar "CONTEST_NAME"
        ))
      <*> (optional $ option (str >>= parseStringList) 
        ( long "files"
        <> short 'f'
        <> help "Problem HTML files"
        <> metavar "\"TASK1_FILEPATH ...\""
        ))
      <*> (optional $ strOption 
        ( long "url"
        <> short 'r'
        <> help "Problem URL"
        <> metavar "URL" 
        ))
      <*> (optional $ strOption
        ( long "username"
        <> short 'u'
        <> help "Username"
        <> metavar "USERNAME"
        ))
      <*> (optional $ strOption
        ( long "password"
        <> short 'p'
        <> help "Password"
        <> metavar "PASSWORD"
        )))
    empty
  lo <- logOptionsHandle stderr (optionsVerbose options)
  pc <- mkDefaultProcessContext
  withLogFunc lo $ \lf ->
    let app = App
          { appLogFunc = lf
          , appProcessContext = pc
          , appOptions = options
          }
     in runRIO app run

parseStringList :: Monad m => String -> m [String]
parseStringList = return . words