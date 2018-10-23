# `@sboosali`'s `home-manager` Configuration

## Dependencies



### non-`nixpkgs` Dependencies

#### `Paper` Icons & Themes

Install:

```sh
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt-get install paper-icon-theme
```

```sh
$ cd ./usr/share/icons/Paper

$ find . -type f -name '*.theme'

./cursor.theme
./index.theme

$ find . -type f -name '*.png' | wc -l
6744
```

Load:

```sh
$ xfce4-appearance-settings &
```

### 


## Files

### `xfce` config files

```sh
$ cd ~/.config/xfce4/xfconf/xfce-perchannel-xml

$ find .
.
./xfce4-power-manager.xml
./xfce4-desktop.xml
./thunar.xml
./xfwm4.xml
./xfce4-mime-settings.xml
./xfce4-keyboard-shortcuts.xml
./keyboards.xml
./keyboard-layout.xml
./xsettings.xml
./xfce4-session.xml
./xfce4-settings-manager.xml
./xfce4-panel.xml
./displays.xml
./accessibility.xml
./xfce4-settings-editor.xml
```

`xsettings.xml` stores, for example, the `DPI` setting.

### Fonts

#### `Iosevka`

<https://be5invis.github.io/Iosevka/>

the `Iosevka` font is an open-source font for programs; it's fixed-width, with tall (visually-distinct) capitals.

Installation:

```sh
$ wget https://github.com/be5invis/Iosevka/releases/download/v2.0.1/01-iosevka-2.0.1.zip

# TODO
```

Files:

```
iosevka-bolditalic.ttf
iosevka-boldoblique.ttf
iosevka-bold.ttf
iosevka-extrabolditalic.ttf
iosevka-extraboldoblique.ttf
iosevka-extrabold.ttf
iosevka-extralightitalic.ttf
iosevka-extralightoblique.ttf
iosevka-extralight.ttf
iosevka-heavyitalic.ttf
iosevka-heavyoblique.ttf
iosevka-heavy.ttf
iosevka-italic.ttf
iosevka-lightitalic.ttf
iosevka-lightoblique.ttf
iosevka-light.ttf
iosevka-mediumitalic.ttf
iosevka-mediumoblique.ttf
iosevka-medium.ttf
iosevka-oblique.ttf
iosevka-regular.ttf
iosevka-semibolditalic.ttf
iosevka-semiboldoblique.ttf
iosevka-semibold.ttf
iosevka-thinitalic.ttf
iosevka-thinoblique.ttf
iosevka-thin.ttf
```

### 


