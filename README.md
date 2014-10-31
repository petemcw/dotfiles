# Dotfiles

Your dotfiles are how you personalize your system. I liked Holman & Nisi's idea
of breaking these files up in a topical fashion. It makes managing these files
easier. [Read his post on the subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

**UPDATE: I have incorporated a hybrid version of the above idea while still using
Oh-my-zsh.**

Check everything out in the file browser above and see what components mesh up
with your needs. [Fork it](https://github.com/petemcw/dotfiles/fork), remove what
you don't use, and build on what you do use.

## Install

Installation will symlink the appropriate files from `.dotfiles` to your home
directory. Everything is configured and tweaked within `~/.dotfiles`.

The `dots` script is a simple installer for some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dots` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `~/.bin/`.

### Automatic Installation

```bash
chsh -s /bin/zsh
curl -L https://raw.github.com/petemcw/dotfiles/master/script/bootstrap | bash -s stable
```

### Manual Install

```bash
chsh -s /bin/zsh
git clone --recursive https://github.com/petemcw/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

## Topical Organization

Everything is built around topic areas. If you're adding a new area to your
forked dotfiles - say, "PHP" - you can simply add a `php` directory and put
files in there. Anything with an extension of `.symlink` will get symlinked
without the extension into `$HOME` when you run `script/bootstrap`.

## Components

There are a few special files in the hierarchy.

- **home/bin.symlink/**: Anything in `home/bin.symlink/` will get added to your
  `$PATH` and be made available everywhere.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`.

## Thanks

I've formed these dotfiles over many iterations and borrowed ideas from many
super smart dudes:

* [Ryan Bates](https://github.com/ryanb)
* [Andrei Zmievski](https://github.com/andreiz)
* [Zach Holman](https://github.com/holman)
* [Nick Nisi](https://github.com/nicknisi/dotfiles)
* [Martin Grenfell](https://github.com/scrooloose)
* [Tim Pope](https://github.com/tpope)

And others!
