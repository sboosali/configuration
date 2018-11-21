--- « .ghci » -*- eval: (progn (dante-mode 0) (flycheck-mode 0)) -*-

--------------------------------------------------

:set prompt "λ> "

-- show type of evaluated expressions
:set +t

-- enable multiline with :{ ... :}
:set +m

--------------------------------------------------

:set -XBangPatterns
:set -XDoAndIfThenElse
:set -XEmptyCase
:set -XEmptyDataDecls
:set -XKindSignatures
:set -XLambdaCase 
:set -XMultiWayIf 
:set -XNamedFieldPuns 
:set -XPackageImports
:set -XPostfixOperators
:set -XRecordWildCards
:set -XTupleSections
:set -XTupleSections 
:set -XTypeOperators
:set -XViewPatterns 

--------------------------------------------------

import qualified "base" Prelude as P

--------------------------------------------------

import          "base" Prelude

--------------------------------------------------

:def hoogle \argument -> P.return P.$ ":! hoogle --count=15 \"" P.++ argument P.++ "\""

--------------------------------------------------
