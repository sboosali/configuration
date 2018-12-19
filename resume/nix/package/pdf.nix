##################################################
{ stdenv
, texlive
}:

##################################################
{ resume ? null
, basename
, options ? [ "-file-line-error" "-interaction=nonstopmode" ]
, useNixFiles ? true             
# ^ Whether to use the Nix-generated TeX/Cls files,
#   r the manually-written ones.
}:

#assert (builtins.isString );
#
assert (resume == null || resume ? tex);
assert (resume == null || resume ? cls);
assert (resume == null || builtins.isString resume.tex);
assert (resume == null || builtins.isString resume.cls);
#
assert (builtins.isString basename);
assert (builtins.isList   options);
assert (builtins.isBool   useNixFiles);

#TODO -output-directory=DIR

##################################################
let
##################################################

latexPackages = {

  inherit (texlive)
          chktex                      # 
          collection-fontsrecommended # 
          enumitem                    # 
          environ                     # 
          etoolbox                    # 
          euenc                       # 
          fancyhdr                    # 
          filehook                    # 
          fontspec                    # 
          geometry                    # 
          graphics                    # 
          hyperref                    # « hyperref » provides hyperlinks in PDFs.
          ifmtarg                     # 
          lastpage                    # 
          ms                          # 
          oberdiek                    # 
          parskip                     # 
          pgf                         # 
          scheme-basic                # 
          setspace                    # 
          sourcesanspro               # 
          tcolorbox                   # 
          tools                       # 
          trimspaces                  # 
          ucharcat                    # 
          unicode-math                # 
          upquote                     # 
          url                         # 
          xcolor                      # 
          xetex                       # 
          xifthen                     # 
          ;
};

# ^ Each attribute corresponds to a TeX Live package.

##################################################

texlive-combined = texlive.combine latexPackages;

##################################################

xelatex = ''${texlive-combined}/bin/xelatex'';

##################################################

options-string = builtins.toString options;

##################################################

src = builtins.filterSource isSrc ../../src;

##################################################

isSrc = path: type:

   ( isDirectory type
  ||  ( isRegularFile type
     && ( hasExtension "tex" path
       || hasExtension "cls" path
       || hasExtension "otf" path
        )
      )
   );

##################################################

isDirectory = type:
  type == "directory";

##################################################

isRegularFile = type:
  type == "regular"; 

##################################################

hasExtension = extension: filepath:

  let
  basename = builtins.baseNameOf filepath;

  extensionLength = builtins.stringLength extension;
  basenameLength  = builtins.stringLength basename;

  index  = basenameLength - extensionLength - 1;
  index' = if index < 0 then 0 else index;

  suffix = builtins.substring index' basenameLength basename;
  in

  suffix == ''.${extension}'';

##################################################
in
##################################################
stdenv.mkDerivation {

  ################################################

  name = ''${basename}-resume'';

  inherit src;

  ################################################

  buildInputs = [
    texlive-combined
  ];

  ################################################

  inherit xelatex;
  # ^ NOTE « buildInputs » registers each « $buildInput/bin » to the PATH.
  # thus, passing the compiler program as an attribute isn't necessary,
  # but it helps with clarity and extensibility.
  inherit options;

  ################################################

  inherit (resume) tex cls;
  passAsFile = [ "tex" "cls" ];
  # ^ NOTE « passAsFile = [ "item" ... ] » sets two environment variables for each item:
  # 
  #        * « $item » is a Bash string,
  #          whose value came from Nix as « builtins.toString item »;
  #        * « $itemPath » is a filepath,
  #          whose contents is the (untruncated) « $item ».

  #TODO inherit basename;

  ################################################

  unpackPhase = ''
    # unpack « .cls » files...
    cp ${if useNixFiles then ''"$clsPath"'' else ''"$src/tex/resume.cls"''} "resume.cls"

    # unpack « .tex » files...
    cp ${if useNixFiles then ''"$texPath"'' else ''"$src/tex/resume.tex"''} "resume.tex"

    # unpack « .otf » files...
    cp -r "$src/fonts" ./fonts
  '';

  buildPhase = ''
    $xelatex ${options-string} "resume.tex"
  '';

  # ^ These options make it easier to debug xelatex when something goes wrong and makes sure we don’t get xelatex doesn’t require any user input. It will produce a file called resume.pdf that we can use as a résumé.

  ################################################

  installPhase = ''
    mkdir -p $out

    cp "resume.pdf" "$out/${basename}.pdf"
  '';

  # ^ Copy the PDF into the « ./result » directory.

  ################################################
}
##################################################