self: super:

{

  ghc7103 = super.haskell.compiler.ghc7103;

  lens = super.haskell.packages.ghc7103.lens;

}
