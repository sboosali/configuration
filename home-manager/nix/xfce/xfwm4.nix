##################################################
{}:

##################################################
let

in
##################################################
rec {

  general.activate_action                = null;
  general.box_move                       = null;
  general.box_resize                     = null;
  general.button_layout                  = "MH|OC";
  general.button_offset                  = null;
  general.button_spacing                 = null;
  general.click_to_focus                 = null;
  general.cycle_apps_only                = null;
  general.cycle_draw_frame               = null;
  general.double_click_distance          = null;
  general.double_click_time              = null;
  general.focus_delay                    = null;
  general.focus_new                      = null;
  general.frame_opacity                  = null;
  general.full_width_title               = null;
  general.maximized_offset               = null;
  general.mousewheel_rollup              = null;
  general.placement_mode                 = null;
  general.raise_delay                    = null;
  general.raise_on_click                 = null;
  general.raise_on_focus                 = null;
  general.repeat_urgent_blink            = null;
  general.scroll_workspaces              = null;
  general.shadow_delta_height            = null;
  general.shadow_delta_width             = null;
  general.shadow_delta_x                 = null;
  general.shadow_delta_y                 = null;
  general.shadow_opacity                 = null;
  general.show_app_icon                  = null;
  general.show_dock_shadow               = null;
  general.show_frame_shadow              = null;
  general.show_popup_shadow              = null;
  general.snap_to_border                 = null;
  general.snap_to_windows                = null;
  general.snap_width                     = null;
  general.theme                          = "Default-xhdpi";
  general.title_alignment                = "right";
  general.title_font                     = "Noto Sans Bold 36";
  general.title_horizontal_offset        = null;
  general.title_shadow_active            = null;
  general.title_shadow_inactive          = null;
  general.title_vertical_offset_active   = null;
  general.title_vertical_offset_inactive = null;
  general.urgent_blink                   = null;
  general.use_compositing                = null;
  general.workspace_count                = null;
  general.workspace_names                = null;
  general.wrap_resistance                = null;
  general.wrap_windows                   = null;
  general.wrap_workspaces                = null;
  general.borderless_maximize            = true;
  general.cycle_hidden                   = true;
  general.cycle_minimum                  = true;
  general.cycle_preview                  = true;
  general.cycle_tabwin_mode              = 0;
  general.cycle_workspaces               = false;
  general.double_click_action            = "maximize";
  general.easy_click                     = "Alt";
  general.focus_hint                     = true;
  general.horiz_scroll_opacity           = false;
  general.inactive_opacity               = 100;
  general.move_opacity                   = 100;
  general.placement_ratio                = 20;
  general.popup_opacity                  = 100;
  general.prevent_focus_stealing         = false;
  general.raise_with_any_button          = true;
  general.resize_opacity                 = 100;
  general.snap_resist                    = false;
  general.sync_to_vblank                 = false;
  general.tile_on_move                   = true;
  general.titleless_maximize             = false;
  general.toggle_workspaces              = false;
  general.unredirect_overlays            = true;
  general.wrap_cycle                     = true;
  general.wrap_layout                    = true;
  general.zoom_desktop                   = true;

}
##################################################
/*

<channel name="xfwm4" version="1.0">
  <property name="general"                          type="empty">
    <property name="activate_action"                type="empty"/>
    <property name="box_move"                       type="empty"/>
    <property name="box_resize"                     type="empty"/>
    <property name="button_layout"                  type="string" value="MH|OC"/>
    <property name="button_offset"                  type="empty"/>
    <property name="button_spacing"                 type="empty"/>
    <property name="click_to_focus"                 type="empty"/>
    <property name="cycle_apps_only"                type="empty"/>
    <property name="cycle_draw_frame"               type="empty"/>
    <property name="double_click_distance"          type="empty"/>
    <property name="double_click_time"              type="empty"/>
    <property name="focus_delay"                    type="empty"/>
    <property name="focus_new"                      type="empty"/>
    <property name="frame_opacity"                  type="empty"/>
    <property name="full_width_title"               type="empty"/>
    <property name="maximized_offset"               type="empty"/>
    <property name="mousewheel_rollup"              type="empty"/>
    <property name="placement_mode"                 type="empty"/>
    <property name="raise_delay"                    type="empty"/>
    <property name="raise_on_click"                 type="empty"/>
    <property name="raise_on_focus"                 type="empty"/>
    <property name="repeat_urgent_blink"            type="empty"/>
    <property name="scroll_workspaces"              type="empty"/>
    <property name="shadow_delta_height"            type="empty"/>
    <property name="shadow_delta_width"             type="empty"/>
    <property name="shadow_delta_x"                 type="empty"/>
    <property name="shadow_delta_y"                 type="empty"/>
    <property name="shadow_opacity"                 type="empty"/>
    <property name="show_app_icon"                  type="empty"/>
    <property name="show_dock_shadow"               type="empty"/>
    <property name="show_frame_shadow"              type="empty"/>
    <property name="show_popup_shadow"              type="empty"/>
    <property name="snap_to_border"                 type="empty"/>
    <property name="snap_to_windows"                type="empty"/>
    <property name="snap_width"                     type="empty"/>
    <property name="theme"                          type="string" value="Default-xhdpi"/>
    <property name="title_alignment"                type="string" value="right"/>
    <property name="title_font"                     type="string" value="Noto Sans Bold 36"/>
    <property name="title_horizontal_offset"        type="empty"/>
    <property name="title_shadow_active"            type="empty"/>
    <property name="title_shadow_inactive"          type="empty"/>
    <property name="title_vertical_offset_active"   type="empty"/>
    <property name="title_vertical_offset_inactive" type="empty"/>
    <property name="urgent_blink"                   type="empty"/>
    <property name="use_compositing"                type="empty"/>
    <property name="workspace_count"                type="empty"/>
    <property name="workspace_names"                type="empty"/>
    <property name="wrap_resistance"                type="empty"/>
    <property name="wrap_windows"                   type="empty"/>
    <property name="wrap_workspaces"                type="empty"/>
    <property name="borderless_maximize"            type="bool"   value="true"/>
    <property name="cycle_hidden"                   type="bool"   value="true"/>
    <property name="cycle_minimum"                  type="bool"   value="true"/>
    <property name="cycle_preview"                  type="bool"   value="true"/>
    <property name="cycle_tabwin_mode"              type="int"    value="0"/>
    <property name="cycle_workspaces"               type="bool"   value="false"/>
    <property name="double_click_action"            type="string" value="maximize"/>
    <property name="easy_click"                     type="string" value="Alt"/>
    <property name="focus_hint"                     type="bool"   value="true"/>
    <property name="horiz_scroll_opacity"           type="bool"   value="false"/>
    <property name="inactive_opacity"               type="int"    value="100"/>
    <property name="move_opacity"                   type="int"    value="100"/>
    <property name="placement_ratio"                type="int"    value="20"/>
    <property name="popup_opacity"                  type="int"    value="100"/>
    <property name="prevent_focus_stealing"         type="bool"   value="false"/>
    <property name="raise_with_any_button"          type="bool"   value="true"/>
    <property name="resize_opacity"                 type="int"    value="100"/>
    <property name="snap_resist"                    type="bool"   value="false"/>
    <property name="sync_to_vblank"                 type="bool"   value="false"/>
    <property name="tile_on_move"                   type="bool"   value="true"/>
    <property name="titleless_maximize"             type="bool"   value="false"/>
    <property name="toggle_workspaces"              type="bool"   value="false"/>
    <property name="unredirect_overlays"            type="bool"   value="true"/>
    <property name="wrap_cycle"                     type="bool"   value="true"/>
    <property name="wrap_layout"                    type="bool"   value="true"/>
    <property name="zoom_desktop"                   type="bool"   value="true"/>
  </property>
</channel>

*/
##################################################
