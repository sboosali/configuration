##################################################
{}:

##################################################
let

customKeyboardShortcuts = {

  "<Alt>Print".command           = "xfce4-screenshooter -w";
  "<Primary><Alt>Delete".command = "xflock4";
  "XF86Explorer".command         = "exo-open --launch FileManager";
  "<Super>e".command             = "mousepad";
  "<Super>f".command             = "exo-open --launch FileManager";

  "<Alt>F3".command              = "xfce4-appfinder";
  "<Alt>F3".startup-notify       = true;
};

in
##################################################
rec {

commands.default = null;
commands.custom = customKeyboardShortcuts;

}
##################################################
/*

« "&lt;Alt&gt;F1" » ≡ « Alt+F1 »

--------------------------------------------------

  <property name="commands" type="empty">

    <property name="default" type="empty">
    ...
    </property>

    <property name="custom" type="empty">
      <property name="&lt;Alt&gt;Print"                 type="string" value="xfce4-screenshooter -w"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="string" value="xflock4"/>
      <property name="XF86Explorer"                     type="string" value="exo-open --launch FileManager"/>
      <property name="&lt;Super&gt;e"                   type="string" value="mousepad"/>
      <property name="&lt;Super&gt;f"                   type="string" value="exo-open --launch FileManager"/>
      <property name="&lt;Alt&gt;F3"                    type="string" value="xfce4-appfinder">
                <property name="startup-notify" type="bool" value="true"/>
      </property>
    ...
    <property name="override" type="bool" value="true"/>
  </property>

--------------------------------------------------



--------------------------------------------------

*/
##################################################
