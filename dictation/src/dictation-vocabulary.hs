#!/usr/bin/env cabal

{- cabal:

  build-depends: base   ^>= 4.12
               , spiros ^>= 0.3
               , split

               , haskell-src-exts
  --           , haskell-src-meta

-}

--------------------------------------------------
--- Extensions -----------------------------------
--------------------------------------------------

-- syntax extensions:

{-# LANGUAGE PackageImports        #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE OverloadedLists       #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE RecordWildCards       #-}
{-# LANGUAGE BlockArguments        #-}
{-# LANGUAGE ApplicativeDo         #-}
{-# LANGUAGE DuplicateRecordFields #-}

-- type extensions:

{-# LANGUAGE FlexibleContexts #-}

{-| 

-}

module Main where

--------------------------------------------------
--- Imports --------------------------------------
--------------------------------------------------

import qualified "base"   Prelude
import           "spiros" Prelude.Spiros

--------------------------------------------------

import qualified "haskell-src-exts" Language.Haskell.Exts as Haskell
import           "haskell-src-exts" Language.Haskell.Exts (Extension(..), Language(..))

--import qualified "haskell-src-meta" Language.Haskell.Meta as H

--------------------------------------------------

import "split" Data.List.Split

--------------------------------------------------

import qualified "optparse-applicative" Options.Applicative      as P
import qualified "optparse-applicative" Options.Applicative.Help as P hiding (fullDesc)

--------------------------------------------------

import qualified "text" Data.Text as Text
import           "text" Data.Text (Text)

--------------------------------------------------

import qualified "base" System.IO          as IO
import qualified "base" System.Environment as IO
import qualified "base" Data.Version       as Version
import qualified "base" Control.Exception  as E

import           "base" System.Exit
import           "base" Data.Maybe

--------------------------------------------------
--- Main -----------------------------------------
--------------------------------------------------

main = do

  filenames <- IO.getArgs

  results <- parseFile `traverse` filenames

  print `traverse_` results

--------------------------------------------------
--- Types ----------------------------------------
--------------------------------------------------

--------------------------------------------------
-- Functions -------------------------------------
--------------------------------------------------

parseFile :: FilePath -> IO (Haskell.Module Haskell.SrcSpanInfo)
parseFile path = go path

 where
 go
   = map Haskell.fromParseResult
   . Haskell.parseFileWithMode (config { Haskell.parseFilename = path })

--------------------------------------------------

parseString :: (Haskell.Parseable ast) => String -> ast
parseString
 = Haskell.fromParseResult
 . Haskell.parseWithMode config

--------------------------------------------------
-- Constants -------------------------------------
--------------------------------------------------

config :: Haskell.ParseMode
config = Haskell.defaultParseMode

 { Haskell.baseLanguage = Haskell2010
 , Haskell.extensions   = Haskell.EnableExtension <$> extensions
 }

--------------------------------------------------

extensions :: [Haskell.KnownExtension]
extensions = [minBound..maxBound]
-- []

--------------------------------------------------
-- Utilities -------------------------------------
--------------------------------------------------

--------------------------------------------------
-- Notes -----------------------------------------
--------------------------------------------------
{-



-}