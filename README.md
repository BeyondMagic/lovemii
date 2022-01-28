<h1 align="center">Xorg</h1>

---

<h3 align="center">MaGiCK SDPP - Super Duper Party People</h3>

---

<img align="center" src="/.github/sdpp/lovemii.jpg">
<img align="center" src="/.github/sdpp/lovemii_menu.jpg">
<img align="center" src="/.github/sdpp/lovemii_rofi.jpg">
<img align="center" src="/.github/sdpp/lovemii_neovim.jpg">
<img align="center" src="/.github/sdpp/lovemii_ncmpcpp.jpg">
<img align="center" src="/.github/sdpp/lovemii_terminal.jpg">
<img align="center" src="/.github/sdpp/lovemii_neovim_edit.jpg">
<img align="center" src="/.github/sdpp/lovemii_tags_preview.jpg">

### sddm

<p align="center">
  <img src="/.github/sddm.png" alt="Preview of the lock screen manager, sddm.">
</p>

Run this to link the `xsessions` folder and add `lovemii` executable, then pass all the configuration of sddm to the current system.

```zsh
# cp "$HOME/git/config/lovemii" /usr/bin/
# mkdir -p /usr/share/xsessions
# cp -rf "$HOME/git/config/usr/share/xsessions/*" /usr/share/
# cp -rf "$HOME/git/config/usr/share/sddm/themes/*" /usr/share/sddm/themes/
# cp -rf "$HOME/git/config/etc/sddm.conf" /etc/sddm.conf
```

### NeoVim

<p align="center">
  <img src="/.github/neovim.png" alt="Preview of NeoVim">
</p>


### Firefox (Beta)

<p align="center">
  <img src="/.github/firefox.png" alt="Preview of home page of Firefox">
</p>

Install the following add-ons:
+ [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us/)
+ [ClearURLs](https://addons.mozilla.org/en-US/firefox/addon/clearurls/)
+ [Search by Image](https://addons.mozilla.org/en-US/firefox/addon/search_by_image/)
+ [Sidebery](https://addons.mozilla.org/en-US/firefox/addon/sidebery/)
+ [SponsorBlock for Youtube - Skip Sponsorships](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)
+ [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
+ [Universal Bypass](https://addons.mozilla.org/en-US/firefox/addon/universal-bypass/)
+ [Bypass Paywalls Clean](https://addons.mozilla.org/en-US/firefox/addon/bypass-paywalls-clean/)
+ [GitHub Gloc](https://addons.mozilla.org/en-US/firefox/addon/bypass-paywalls-clean/)

Enable the following in `about:config`:
```
config.trim_on_minimize
gfx.webrender.enabled
toolkit.legacyUserProfileCustomizations.stylesheets
layout.css.backdrop-filter.enabled
layout.css.color-mix.enabled
browser.tabs.loadBookmarksInTabs
browser.urlbar.maxRichResults 25
```

Disable the following in `about:config`:

```
strict_origin_policy
extensions.htmlaboutaddons.recommendations.enabled
```

On `about:support` click on `Open Directory` for **Local Directory**:

Set the homepage to [mod-startpage](https://github.com/BeyondMagic/mod-startpage).

### Keyboard

On `/etc/vconsole.conf`, to set Portuguese (ABNT2):

```zsh
KEYMAP=abnt2
```

---

<h1 align="center">WayLand</h1>

TODO:: new life
+ EFL
+ WayLand
+ (some window manager that is very modular and lightweight)
+ ...
