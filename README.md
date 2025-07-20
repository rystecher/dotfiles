# dotfiles

Dotfiles and setup scripts to automate macOS setup.

[Homebrew](https://brew.sh/) is used for package management and
[mise](https://mise.jdx.dev/) for managing programming languages.

## Install

```bash
git clone git@github.com:rystecher/dotfiles.git ~/dotfiles
~/dotfiles/setup/mac
```

Run `rcup` after adding new files to the directory to properly symlink them.

## Settings

* System
  * Remap caps lock to control

* Trackpad
  * Look up & data detectors: Yes
  * Swipe between pages: 3 fingers
  * Swipe between full-screen apps: 4 fingers
  * Mission control: 4 fingers
  * App Expose: Down w/ 4 fingers

* Terminal
  * [Dracula](https://draculatheme.com/) color theme
  * Use option as Meta key

## Acknowledgements

Many thanks to [Thoughtbot](https://thoughtbot.com/) for their
[laptop](https://github.com/thoughtbot/laptop) and
[dotfiles](https://github.com/thoughtbot/dotfiles) repos, which served as the
starting point for this repo.
