# Notes

Notes about my `home-manager` configuration and about `nixpkgs`.

## Links

overlays/emacs.nix (jwiegley/nix-config)>

<https://github.com/jwiegley/nix-config/blob/master/overlays/emacs/builder.nix emacs/builder.nix (jwiegley/nix-config)>

## `lib/fixed-points.nix`

https://github.com/NixOS/nixpkgs/blob/18.09/lib/fixed-points.nix

### `lib.fix`

Type: 

```haskell
fix :: (a -> a) -> a
```

Definition:

```nix
fix = f: 

  let x = f x
  in  x;
```

`fix f` "resolves" the fixed point of `f`

`f` is an "endormorphism" (i.e. `f :: a -> a`)

often, `f` is a "package extension"; an AttributeSet that "expects its final, non-recursive representation as an argument". e.g.:

```nix
f = self:

  { foo = "foo"; 
    bar = "bar"; 
    foobar = self.foo + self.bar; 
  }
```

the FixedPointProperty for a function `f` is `f x = x`.

`(fix f)` satisfies the FixedPointProperty for **any** "appropriate" function `f`, i.e. `(fix f) x = x`... where "appropriate" means its recursion is coherent under `fix`, i.e. that `(fix f)` terminates.

> Nix repeatedly evaluates this recursion until all references to `self` have been resolved. Once `self` gets resolved, the final result can be returned, and the FixedPointProperty `f x = x` holds:

     nix-repl> fix f
     { bar = "bar"; foo = "foo"; foobar = "foobar"; }

### `lib.extends`

Type: 

```haskell
extends :: (a -> a -> a) 
        -> (a -> a) 
        -> (a -> a) 
```

Definition (`nixpkgs`):

```nix
extends = f: rattrs: self: let super = rattrs self; in super // f self super;
```

Definition (mine):

```nix
extends = k: f:
          self:

  let super = f self;
      x     = k self super;
  in 
  
  super // x

```

Inputs:

* `f :: AttrSet -> AttrSet` is called an **"override"** or a "recursive attribute-set" (or, when the attributes represent packages, a "recursive package-set").
* `k :: AttrSet -> AttrSet -> AttrSet` is called an **"overlay"**.

NOTE the `f` in `(extends _ f)` and `(fix f)` share the same type:

```haskell
k :: a -> a -> a
f :: a -> a
```

as does the (saturated) `(extends _ _)` itself:

```haskell
extends k   :: (a -> a) -> (a -> a)

extends k f :: a -> a
```

NOTE `fix` and `extends` "resolve" recurisve-packages and multiple overlays into non-recurisve packages. i.e. given:

```haskell
f           :: (a -> a)
extends k   :: (a -> a) -> (a -> a)
fix         :: (a -> a) -> a
```

we evaluate to:

```haskell
     extends k f  :: a -> a
fix (extends k f) :: a

fix (extends k2 (extends k1 f)) :: a
```

Read `extends` as an infix operator and with arguments flipped. 
i.e. read `(extends f _)` as `"g extends f"` (this mimics the `Java` syntax).
Why flipped? For cascading multiple `extends`, e.g.:

```nix
g = extends k3
      (extends k2
        (extends k1 
          f))
```

> Modify the contents of an explicitly recursive attribute set in a way that
> honors `self`-references. This is accomplished with a function
>
>     g = self: super: { foo = super.foo + " + "; }
>
> that has access to the unmodified input (`super`) as well as the final
> non-recursive representation of the attribute set (`self`). 
>
> `extends` differs from the native `//` operator insofar as that it's
> applied *before* references to `self` are resolved:
>
>     nix-repl> fix (extends g f)
>     { bar = "bar"; foo = "foo + "; foobar = "foo + bar"; }
> 

## 