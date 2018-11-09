##################################################
{}:

##################################################
let



in
##################################################
rec {

  desktop-menu.show-icons                  = true;

  windowlist-menu.show                     = false;

  desktop-icons.style                      = 2;
  desktop-icons.icon-size                  = 36;
  desktop-icons.tooltip-size               = null;
  desktop-icons.show-hidden-files          = true;
  desktop-icons.single-click               = false;
  desktop-icons.use-custom-font-size       = true;
  desktop-icons.font-size                  = 36.000000;

  desktop-icons.file-icons.show-home       = true;
  desktop-icons.file-icons.show-filesystem = true;
  desktop-icons.file-icons.show-removable  = true;
  desktop-icons.file-icons.show-trash      = true;

}
##################################################
/*

--------------------------------------------------

  <property name="desktop-menu" type="empty">
    <property name="show-icons" type="bool" value="true"/>
  </property>

--------------------------------------------------

  <property name="windowlist-menu" type="empty">
    <property name="show" type="bool" value="false"/>
  </property>

--------------------------------------------------

    <property name="desktop-icons" type="empty">
    <property name="style" type="int" value="2"/>

   <property name="file-icons" type="empty">
      <property name="show-home" type="empty"/>
      <property name="show-filesystem" type="empty"/>
      <property name="show-removable" type="empty"/>
      <property name="show-trash" type="empty"/>
    </property>

    <property name="icon-size" type="uint" value="36"/>
    <property name="tooltip-size" type="empty"/>
    <property name="show-hidden-files" type="bool" value="true"/>
    <property name="single-click" type="bool" value="false"/>
    <property name="use-custom-font-size" type="bool" value="true"/>
    <property name="font-size" type="double" value="36.000000"/>

--------------------------------------------------

*/
##################################################
