# Dotfiles

Your dotfiles are how you personalize your system. I liked Holman & Nisi's idea
of breaking these files up in a topical fashion. It makes managing these files
easier. [Read his post on the subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

UPDATE: I have incorporated a hybrid version of the above idea while still using Oh-my-zsh.

## Install

### Automatic Installation

```bash
curl -L https://raw.github.com/petemcw/dotfiles/master/tools/install.sh | bash -s stable
```

Preferably, enable `zsh`:

```bash
chsh -s /bin/zsh
```

### Manual Install

- `git clone https://github.com/petemcw/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `git submodule init`
- `git submodule update`
- `rake backup`
- `rake install`
- `chsh -s /bin/zsh`

## Topical Organization

Everything's built around topic areas. If you're adding a new area to your
dotfiles - say, "PHP" - you can simply add a `php` directory and put files in
there. Anything with an extension of `.symlink` will get symlinked without the
extension into `$HOME` when you run `rake install`.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of them versioned in your dotfiles
  but still keep them autoloaded in your home directory. These get symlinked
  in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after Zsh autocomplete functions are setup.

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
