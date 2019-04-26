##################################################
{ lib
, pkgs
}: 

##################################################
let
#------------------------------------------------#

T = lib.types;

#------------------------------------------------#
in
##################################################
{

  enable = lib.mkEnableOption "the XBindKeys daemon";

  #----------------------------#

  language = lib.mkOption {

    type = T.nullOr (T.enum [ "xbindkeys" "guile" ]);

    default = null;
    example = "guile";

    description = ''
The options are:

<varlist>
  <varentry>
    <term><literal>"xbindkeys"</literal></term>
    <listitem><para>.</para></listitem>
  </varentry>
  <varentry>
    <term><literal>"guile"</literal></term>
    <listitem><para>.</para></listitem>
  </varentry>
  <varentry>
    <term><literal>null</literal></term>
    <listitem><para>guess given the first non-<code>null</code> value among <varname>config</varname> and <varname>configGuile</varname>, or among <varname>extraConfig</varname> and <varname>extraConfigGuile</varname>.</para></listitem>
  </varentry>
</varlist>

• <code>"guile"<code/> — then use <varname>configGuile</varname> and <varname>extraConfigGuile</varname>.

Otherwise (if <code>null<code/>), guess given the first non-<code>null</code> value among <varname>config</varname> and <varname>configGuile</varname>, or among <varname>extraConfig</varname> and <varname>extraConfigGuile</varname>.
'';

  };

  #----------------------------#

  fileConfigGuile = lib.mkOption {

    type = T.nullOr (T.either T.path T.str);

    default = ''"$XDG_CONFIG_HOME"/xbindkeys/xbindkeysrc.scm'';

    description = ''
    '';

  };

  #----------------------------#

  fileConfigXkb = lib.mkOption {

    type = T.nullOr (T.either T.path T.str);

    default = ''"$XDG_CONFIG_HOME"/xbindkeys/xbindkeysrc'';

    description = ''


    '';

  };

  #----------------------------#

  extraConfigGuile = lib.mkOption {

    type = T.lines;

    default = [];
    example = ''
(define (run-xbindkeys_show) 
  (run-command "xbindkeys_show"))

;; Run « xbindkeys_show » when you press « C-S-q »:

(xbindkey-function '(control alt shift q) 
                   run-xbindkeys_show)
'';

    description = ''
Keybindings for XBindKeys, in the Guile-Scheme programming language.
</para><para>
These expressions are appended to <filename>~/.config/xbindkeys/xbindkeysrc.scm</filename>.
</para><para>
<varname>extraConfigGuile</varname> is mutually-exclusive with <varname>extraConfig</varname>.
</para><para>
See <link xlink:href="https://www.gnu.org/software/guile"/> for Guile examples.
'';

  };

  #----------------------------#

  extraConfigXkb = lib.mkOption {

    type = T.lines;

    default = [];
    example = ''
# Run « xbindkeys_show » when you press « C-S-q »:

"xbindkeys_show" 
  control+shift + q
'';

   description = ''

See <filename>/usr/include/X11/keysymdef.h</filename> for your system's (default) <code>keysym⇄keycode</code> mapping.

    '';

  };

#------------------------------------------------#

  finalLanguage = lib.mkOption {
    type = T.nullOr (T.enum [ "xbindkeys" "guile" ]);
    visible = false;
    readOnly = true;
    description = ''The (resolved) XBindKeys config language.'';
  };

  #----------------------------#

  finalConfig = lib.mkOption {
    type = T.string;
    visible = false;
    readOnly = true;
    description = ''The (resolved) XBindKeys config file.'';
  };

  #----------------------------#
}