# Contributing to `home-manager`

## Coding

### Linting

Bad:

``` nix
```

Good:

``` nix
```

### Utilities

Make sure.

## Documenting

### “Docstring”s

`home-manager`'s docs are fromatted with *XML-`docbook` markup* (the same markup language as `NixOS` (and `Nixpkgs`). NOTE, documentation is generated only for *option descriptions* (i.e. under the `description` field of `mkOption { descriptions = '' ... '; ...'); in particular, not for other bindings (i.e. in comments of a top-level binding '/* */`). Thus, if you add an *option* (or a *module* of options), if you want it to look nice in <https://rycee.gitlab.io/home-manager/options.html>, make sure you use the appropriate markup elements; and that the documentation builds, which involves concatenating all the `description`s together, and parsing and rendering the `xml`.

#### XML Elements

Useful markup elements include:

* `<link>`           — Links! 
* `<para>`           — Linebreak. Abbreviates "paragraph".
* `<code>`           — Code Block. Renders in Monospace. Same as HTML `<code> ... </code>` or Markdown `` `...` `` (i.e. backticks).
* `<literal>`
* `<filename>`
* `<varname>`
* `<command>`
* `<parameter>`
* `<variablelist>`   — List of terms or values, and their definitions or meanings. Renders as a list with indentation. Same as HTML *Definition List* (e.g. `<dl> <dt>"0"</dt> <dd>The default.</dd> ... </dl>`). See the <https://rycee.gitlab.io/home-manager/options.html> ` ` option> for an example.
* `<programlisting>` — Code Block, multi-line. Same as Markdown `` ``` ... ``` `` (i.e. triple-backticks).
* `<citerefentry>`
* `<envar>`

At a minimum, use the `<link>` and `<code>` tags!

#### `<citerefentry>` Element

For example, this `docbook` markup:

``` xml
```

renders as:

#### Semantic `<code>`-like Elements

Examples include:

* `<> </>`
* `<envar>HOME</envar>`
* `<filename>~/.config/nixpkgs/home.nix</filename>`
* `<> </>`
* `<> </>`
* `<literal>null</literal>`
* `<literal>false</literal>`
* `<literal>true</literal>`
* `<literal>1/literal>`
* `<literal>"yes"</literal>`

For example, this `docbook` markup:

``` xml
```

renders as:

#### `<>` Element

For example, this `docbook` markup:

``` xml
```

renders as:

#### `<programlisting>` Element

For example, this `docbook` markup:

``` xml
<programlisting language="nix">
  home.sessionVariables = {
    FOO = "Hello";
    BAR = "$FOO World!";
  };
</programlisting>
```

renders as:

``` nix
home.sessionVariables = {
  FOO = "Hello";
  BAR = "$FOO World!";
};
```

i.e. as this `markdown` markup:

```
\`\`\` nix
home.sessionVariables = {
  FOO = "Hello";
  BAR = "$FOO World!";
};
\`\`\`
```

#### `<variablelist>` Element

For example, this markup (indentation is optional, it's included for readability):

``` xml
The options are:

<variablelist>

<varlistentry>
  <term><literal>always</literal></term>
  <listitem><para>Always show tray icon.</para></listitem>
</varlistentry>

<varlistentry>
  <term><literal>auto</literal></term>
  <listitem><para>
Show tray icon only when there is a device available.
  </para></listitem>
</varlistentry>

<varlistentry>
  <term><literal>never</literal></term>
  <listitem><para>Never show tray icon.</para></listitem>
</varlistentry>

</variablelist>
```

renders as:

> The options are
> 
> `always`
>    Always show tray icon.
> 
> `auto`
>    Show tray icon only when there is a device available.
> 
> `never`
>   Never show tray icon.
> 

See the
        <citerefentry>
          <refentrytitle>compton</refentrytitle>
          <manvolnum>1</manvolnum>
        </citerefentry>
        man page










<envar>HOME</envar>



### 

<term>${1:<literal>null</literal>}</term>
<listitem><para>{2:the default}</para></listitem>

<varlist>
  <varentry>
    <term>${1:<literal>null</literal>}</term>
    <listitem><para>{2:The default.}</para></listitem>
  <varentry>
  $0
</varlist>



<varlist>
  <varentry>
    <term><literal>null</literal></term>
    <listitem><para></para></listitem>
  <varentry>
  $0
</varlist>


The options are:

<varlist>

  <varentry>
    <term><literal>""</literal></term>
    <listitem><para>.</para></listitem>
  <varentry>


• <code>"xbindkeys"<code/> — then use <varname>config</varname> and <varname>extraConfig</varname>.
• <code>"guile"<code/> — then use <varname>configGuile</varname> and <varname>extraConfigGuile</varname>.

Otherwise (if <code>null<code/>), guess given the first non-<code>null</code> value among <varname>config</varname> and <varname>configGuile</varname>, or among <varname>extraConfig</varname> and <varname>extraConfigGuile</varname>.


  <varentry>
    <term><literal>null</literal></term>
    <listitem><para>guess given the first non-<code>null</code> value among <varname>config</varname> and <varname>configGuile</varname>, or among <varname>extraConfig</varname> and <varname>extraConfigGuile</varname>.</para></listitem>
  <varentry>

</varlist>


        <programlisting language="nix">
          home.sessionVariables = {
            FOO = "Hello";
            BAR = "$FOO World!";
          };
        </programlisting>


          <informaltable frame="none"><tgroup cols="1"><tbody>
          ${concatStringsSep "\n" (
            mapAttrsToList (n: v: ''
              <row>
                <entry><varname>${n}</varname></entry>
                <entry>${v.description}</entry>
              </row>
            '') knownSettings
          )}
          </tbody></tgroup></informaltable>









          <informaltable frame="none"><tgroup cols="1"><tbody>
          ${concatStringsSep "\n" (
            mapAttrsToList (n: v: ''
              <row>
                <entry><varname>${n}</varname></entry>
                <entry>${v.description}</entry>
              </row>
            '') knownSettings
          )}
          </tbody></tgroup></informaltable>






          You can use <code>%1</code>, <code>%2</code>, and
          <code>%3</code> to refer respectively to:
          <orderedlist numeration="arabic">
            <listitem><para>file name</para></listitem>
            <listitem><para>server name</para></listitem>
            <listitem><para>socket ID</para></listitem>
          </orderedlist>




          Launch application on a particular workspace. DEPRECATED:
          Use <varname><link linkend="opt-xsession.windowManager.i3.config.assigns">xsession.windowManager.i3.config.assigns</link></varname>
          instead. See <link xlink:href="https://github.com/rycee/home-manager/issues/265"/>.

<!-- secret convenience templates (for contributors to this document)... -->

<!-- Bad:    -->
<!--         -->
<!-- ``` nix -->
<!-- ```     -->
<!--         -->
<!-- Good:   -->
<!--         -->
<!-- ``` nix -->
<!-- ```     -->

<!-- #### `<>` Element                   -->
<!--                                     -->
<!-- For example, this `docbook` markup: -->
<!--                                     -->
<!-- ``` xml                             -->
<!-- ```                                 -->
<!--                                     -->
<!-- renders as:                         -->
<!--                                     -->
<!--                                     -->

