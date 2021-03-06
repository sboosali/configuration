--- « .ghci » -*- eval: (progn (dante-mode -1) (flycheck-mode -1)) -*-

--------------------------------------------------
-- Settings (1/2) --------------------------------
--------------------------------------------------

:set prompt "λ> "

--------------------------------------------------
-- Imports (1/3) ---------------------------------
--------------------------------------------------

import qualified Prelude as P

--------------------------------------------------
-- Message ---------------------------------------
--------------------------------------------------

P.putStrLn "---------------------------------------"
P.putStrLn ""
P.putStrLn "~/.ghci"
P.putStrLn ""
P.putStrLn ":set"
P.putStrLn ""
P.putStrLn ":type"
P.putStrLn ""
P.putStrLn ":info"
P.putStrLn ""
P.putStrLn ":reload"
P.putStrLn ""
P.putStrLn ":sprint"
P.putStrLn ""
P.putStrLn ":{"
P.putStrLn "let f 0 = False" 
P.putStrLn "    f x = True"
P.putStrLn ":}"
P.putStrLn ""
P.putStrLn "---------------------------------------"

--------------------------------------------------
-- Settings (2/2) --------------------------------
--------------------------------------------------

-- show type of evaluated expressions
:set +t

-- enable multiline with :{ ... :}
:set +m

--------------------------------------------------
-- Extensions ------------------------------------
--------------------------------------------------

-- My Custom Extensions 
:set -XAutoDeriveTypeable
:set -XDeriveDataTypeable
:set -XDeriveGeneric
:set -XDeriveFunctor
:set -XDeriveFoldable
:set -XDeriveTraversable
:set -XLambdaCase 
:set -XEmptyCase
:set -XTypeOperators
:set -XPostfixOperators
:set -XViewPatterns 
:set -XBangPatterns
:set -XKindSignatures
:set -XNamedFieldPuns 
:set -XRecordWildCards
:set -XTupleSections
:set -XMultiWayIf 
:set -XDoAndIfThenElse
:set -XEmptyDataDecls
:set -XMultiParamTypeClasses 
:set -XFlexibleContexts
:set -XFlexibleInstances
:set -XFunctionalDependencies
:set -XScopedTypeVariables 
:set -XStandaloneDeriving
:set -XTupleSections 

-- :set -XTypeFamilies            -- .ghci warns something

-- Convenient Extensions:

:set -XOverloadedLists
:set -XOverloadedStrings

--------------------------------------------------
-- Imports (2/3) ---------------------------------
--------------------------------------------------

-- Base Modules:

import GHC.Generics    (Generic)
import Data.Data       (Data)
import Data.Function   ((&),on)
import Data.Foldable   (traverse_)
import Control.Arrow   ((>>>),(<<<))
import Data.Set        (Set)
import Data.Map        (Map)
import Numeric.Natural (Natural)
import Data.Proxy      (Proxy(..))
import Control.Monad.IO.Class (MonadIO(..))
import Control.Applicative
import Data.Semigroup  (Semigroup(..))

-- Standard (`ghc-boot`?) Modules:

:set -package bytestring
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString      as BS

type LazyByteString   = BL.ByteString
type StrictByteString = BS.ByteString

--------------------------------------------------
-- Imports (3/3) ---------------------------------
--------------------------------------------------

-- :set -package text
-- import qualified Data.Text.Lazy       as TL
-- import qualified Data.Text            as TS

-- -- Custom Prelude (`spiros` package) Modules 
-- :set -package spiros
-- :set -package deepseq
-- :set -package data-default-class
-- :set -package hashable
-- :set -package safe
-- import Data.Hashable   (Hashable(..))
-- import Control.DeepSeq (NFData(..))
-- -- import Safe            
-- import Data.Default.Class (Default(..))

-- Renaming 
-- type LazyText         = TL.Text
-- type StrictText       = TS.Text

--------------------------------------------------
-- Macros ----------------------------------------
--------------------------------------------------

:def hoogle \argument -> P.return P.$ ":! hoogle --count=15 \"" P.++ argument P.++ "\""

--------------------------------------------------
-- Notes -----------------------------------------
--------------------------------------------------

-- ":" starts commands like vim

-- Macros:
--
-- :def hoogle \str -> return $ ":! hoogle --count=15 \"" ++ str ++ "\""
-- let pasteCode_loop = do { l <- getLine; if l == "\^D" then return () else do appendFile "temporary.hs" (l++"\n"); loop }
-- :def pasteCode (\_ -> pasteCode_loop >> return ":load temporary.hs")

--------------------------------------------------
--------------------------------------------------