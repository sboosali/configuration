##################################################
{}:

##################################################
let

tex = rec {

  ################################################

  /* In LaTeX, an « environment » declares a scope.
   *
   * Examples:
   *
   *     > tex.environment { name = "document"; body = [ "X" "Y" "Z" ]; }
   *     [ "\\begin{document}" "X" "Y" "Z" "\\end{document}" ]
   *
   *     > tex.environment { name = "document"; body = [ "X" "Y" "Z" ]; string = true; }
   *     "\\begin{document} X Y Z \\end{document}"
   *
   *     > (tex.environment { name = "document"; body = [ "X" "Y" "Z" ]; multiline = true; })
   *     [ "\\begin{document}" "  X" "  Y" "  Z" "\\end{document}" ]
   *
   *     > :p (tex.environment { name = "document"; body = [ "X" "Y" "Z" ]; multiline = true; string = true; })
   *     \begin{document}
   *       X
   *       Y
   *       Z
   *     \end{document}
   *
   */

  environment =    { name, body, indentation ? 0
                   , multiline ? false, string ? false
                   }:

    assert ( builtins.isString name
          && builtins.isList   body
          && builtins.isInt    indentation  
          && builtins.isBool   multiline
          && builtins.isBool   string
           );

    let
    beginLine  = indentOuter ''\begin{${name}}'';
    innerLines = builtins.map indentInner body;
    endLine    = indentOuter ''\end{${name}}'';

    indentOuter = indentBy (if multiline then indentation       else 0);
    indentInner = indentBy (if multiline then (2 + indentation) else 0);

    lines = builtins.concatLists
      [ [ beginLine ]
        innerLines
        [ endLine ]
      ];

    output =
      if   string
      then builtins.concatStringsSep separator lines
      else lines;

    separator = if multiline then "\n" else " ";
    in

    output;

  ################################################

  /* In LaTeX, a « command » is a macro call.
   *
   * It has positional arguments and (optional) options.
   *
   * Examples:
   *
   *     > tex.command { name = "F"; string = true; }
   *     "\\F"
   *
   *     > tex.command { name = "F"; arguments = [ "A" "B" "C" ]; options = [ "X" "Y" ]; string = true; }
   *     "\\F [X, Y] { A } { B } { C }"
   *
   *     > tex.command { name = "F"; arguments = [ "A" "B" "C" ]; options = [ "X" "Y" ]; multiline = true; string = true; }
   *     "\\F\n[X, Y]\n{ A }\n{ B }\n{ C }"
   *
   *     > tex.command { name = "F"; arguments = [ "A" "B" "C" ]; options = [ "X" "Y" ]; }     
   *     [ "\F [X, Y] { A } { B } { C }" ]
   *
   *     > tex.command { name = "F"; arguments = [ "A" "B" "C" ]; options = [ "X" "Y" ]; multiline = true; }
   *     [ "\\F" "[X, Y]" "{ A }" "{ B }" "{ C }" ]
   *
   */

  command = kwargs@{ name, arguments ? [], options ? []
                   , indentation ? 0, multiline ? false, string ? false
                   }:

    assert ( builtins.isString name
          && builtins.isList   arguments
          && builtins.isList   options
          && builtins.isInt    indentation
          && builtins.isBool   multiline
          && builtins.isBool   string
           );

    let
    #kwargs' = builtins.removeAttrs kwargs [ "multiline" "string" "indentation" ];
    kwargs' = { inherit name arguments options; };

    lines = builtins.map (indentBy (indentation))
      (if   multiline
       then multilineCommand kwargs'
       else onelineCommand   kwargs'
      );

    output =
      if   string
      then builtins.concatStringsSep "\n" lines
      else lines;

    in

    output;

  ################################################

  arguments = { separator ? " ", multiline ? false }:
              xs:

    let
    args = (builtins.map argument xs);

    args' = 
      (if   multiline
       then args
       else builtins.concatStringsSep separator args
      );

     output = args';
     in

     assert (!multiline -> builtins.isString output);
     assert (multiline  -> builtins.isList   output);
     output;

  ################################################

  argument = x:

    ''{ ${builtins.toString x} }'';

  ################################################

  options = { multiline ? false }:
            xs:

    let
    opts = builtins.concatStringsSep ", " xs;
    in

    ''[${opts}]'';

    #"[" + (builtins.concatStringsSep ", " xs) + "]";

  ################################################

  /* 
   *
   * Examples:
   *
   *      > tex.documentclass { }
   *      "\\documentclass [10pt] { article }"
   *
   *      > tex.documentclass { fontsize = 11; class = "resume"; string = false; }
   *      [ "\\documentclass" "[11pt]" "{ resume }" ]
   *      
   *
   */

  documentclass = { fontsize ? defaultFontsize, class ? defaultClass
                  , string ? true
                  }:

    tex.command
      { name      = "documentclass";
        options   = [ (toFontsizeString fontsize) ];
        arguments = [ (toClassString    class) ];

        inherit string;
        multiline = !string;
        indentation = 0;
      };

  ################################################

  defaultFontsize = "10pt";
  
  ################################################

  defaultClass = "article";
  
  ################################################

};

##################################################

onelineCommand = { name, arguments, options }:

    let
    args = if   arguments != []
           then " " + args'
           else "";

    opts = if   options != []
           then " " + opts'
           else "";

    args' = tex.arguments { multiline = false; separator = " "; } arguments;
    opts' = tex.options   { multiline = false;                  } options;
    in

    [ ''\${name}${opts}${args}''
    ];

##################################################

multilineCommand = { name, arguments, options }:

    let
    args = if   arguments != []
           then args'
           else [];

    opts = if   options != []
           then [ opts' ]
           else [];

    args' = tex.arguments { multiline = true; } arguments;
    opts' = tex.options   { multiline = true; } options;
    in

    builtins.concatLists
      [ [ ''\${name}'' ]
        opts
        args
      ];

##################################################

toFontsizeString = fontsize:

  if   builtins.isString fontsize
  then fontsize
  else

  if   builtins.isInt fontsize
  then ''${builtins.toString fontsize}pt''
  else

  # if   builtins.isFloat fontsize
  # then ''${builtins.toString fontsize}pt''
  # else

  abort ''« toFontsizeString » — « ${builtins.toString fontsize} » must either have type: « string » or « int »''; #TODO or « float ».'';

##################################################

toClassString = class:

  if   builtins.isString class
  then class
  else

  if   builtins.isPath class
  then ''${builtins.toString class}''     # TODO basename? strip cls ext?
  else

  abort ''« toClassString » — « ${builtins.toString class} » must either have type: « string » or « path »'';

##################################################

/*
 * 
 * Examples: 
 * 
 *     > indentBy 4 "xyz"
 *     "    xyz"
 * 
 * Laws:
 * 
 *     indentBy 0 ≡ id
 * 
 * 
 */

indentBy = indentation:
           s:

  let
  i =

    if   builtins.isInt indentation
    then (replicateSpaces indentation)
    else 

    if   builtins.isString indentation
    then indentation
    else

    s;                             # (silently ignore type error)

  in

  i + s;

##################################################

replicateSpaces = i:

  if i <= 0 then ""         else
  if i == 1 then " "        else
  if i == 2 then "  "       else
  if i == 3 then "   "      else
  if i == 4 then "    "     else
  if i == 5 then "     "    else
  if i == 6 then "      "   else
  if i == 7 then "       "  else
  if i == 8 then "        " else
                 "        ";

in
##################################################

tex

##################################################