# Notes about Nix, Bash, Linux, etc (for `home-manager`)


## Nix

### `lib._`

#### `lib.strings._`

##### `lib.strings.substring`:

```nix
>>> lib.strings.substring 0 3 "abcdef"
"abc"

>>> lib.strings.substring 0 9 "abcdef"
"abcdef"
```

##### `lib.strings.replaceStrings`:

```nix
lib.strings.replaceStrings = builtins.replaceStrings
```

```nix
>>> lib.strings.replaceStrings [ "x" "y" "z" ] [ "y" "x" "" ] "xxxyyyzzz"
"yyyxxx"
```

##### `lib.strings.hasInfix`:

```nix
>>> lib.strings.hasInfix "def" "abcdefghi"
true

>>> lib.strings.hasInfix "adg" "abcdefghi"
false
```

##### `lib.strings.splitString`:

```nix
>>> lib.strings.splitString "/" "/usr/local/bin/"
[ "" "usr" "local" "bin" "" ]
```

##### `lib.strings.optionalString`:

```nix
>>> lib.strings.optionalString false "xyz"
""

>>> lib.strings.optionalString true "xyz"
"xyz"
```

##### `lib.strings.enableFeature`:

```nix
>>> lib.strings.enableFeature true "tests"
"--enable-tests"

>>> lib.strings.enableFeature false "tests"
"--disable-tests"
```

##### `lib.strings.escape`:

```nix
>>> lib.strings.escape ["(" ")"] "(foo)"
"\\(foo\\)"
```

> Escape occurrence of the elements of `list` in `string` by prefixing it with a backslash.

##### `lib.strings.escapeShellArgs`:

```nix
# :: string -> string

escapeShellArgs = concatMapStringsSep " " escapeShellArg;
```

##### `lib.strings.escapeNixString`:

```nix
>>> lib.strings.escapeNixString "xyz"
"\"xyz\""

>>> lib.strings.escapeNixString ''"x" "y" "z"''
"\"\\\"x\\\" \\\"y\\\" \\\"z\\\"\""
```

##### `lib.strings.escapeShellArg`:

```nix
>>> lib.strings.escapeShellArg "esc'ape\nme"
"'esc'\\''ape\nme'"
```

##### `lib.strings.makeSearchPath`:

```nix
>>> lib.strings.makeSearchPath "" [ "~/bin" "~/.local/bin" ]
"~/bin/:~/.local/bin/"
```

> a Unix-style (colon-separated) search path.

`lib.strings.makeSearchPath` :: string -> [string] -> string

##### `lib.strings.fixedWidthNumber`:

```nix
>>> lib.strings.fixedWidthNumber 3 9
"009"

>>> lib.strings.fixedWidthNumber 3 789
"789"

>>> lib.strings.fixedWidthNumber 3 56789
trace: fixedWidthString: requested string length (3) must not be shorter than actual length (5)
error: assertion failed at ...
```

##### `lib.strings.nameFromURL`:

```nix
>>> lib.strings.nameFromURL "https://github.com/NixOS/nixpkgs.git" "."
nixpkgs

>>> lib.strings.nameFromURL "https://github.com/NixOS/nixpkgs.git" " "
error: assertion failed

>>> lib.strings.nameFromURL "https://github.com/NixOS/nixpkgs.git" ""
error: stack overflow (possible infinite recursion)
```

##### `lib.strings.toInt`:

```nix
>>> lib.strings.toInt "123"
123

>>> lib.strings.toInt "xyz" 
error: unrecognised JSON value
```

##### `lib.strings.fileContents`:

```sh
$ echo "1.0" > ./version.txt

$ nix repl

>>> lib.strings.fileContents ./version.txt
"1.0"
```

> Read the contents of a file removing the trailing \n

`lib.strings.fileContents` :: path -> string

##### `lib.strings.`:

```nix
>>> lib.strings.
```



## 

