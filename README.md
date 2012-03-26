# Dotfiles

Your dotfiles are how you personalize your system. I liked Holman's idea of 
breaking these files up in a topical fashion. It makes managing these files 
easier. [Read his post on the subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## Install

- `git clone git://github.com/petemcw/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `git submodule init`
- `git submodule update`
- `rake install`
- `chsh -s /bin/zsh`

The install rake task will symlink the appropriate files in `.dotfiles` to 
your home directory. Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change is `zsh/zshrc.symlink`, which sets up a few 
paths that'll be different across your machines.

## Topical

Everything's built around topic areas. If you're adding a new area to your 
dotfiles - say, "PHP" - you can simply add a `php` directory and put files in 
there. Anything with an extension of `.symlink` will get symlinked without 
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

## Add-ons

There are a few things we use to make our lives awesome. They're not a required
dependency, but if you install them they'll make your life better too.

- If you install the excellent [rvm](http://beginrescueend.com) to manage
  multiple rubies, your current branch will show up in the prompt.

## Thanks

I've formed these dotfiles over many iterations and borrowed ideas from many 
super smart dudes:

* [Ryan Bates](https://github.com/ryanb)
* [Andrei Zmievski](https://github.com/andreiz)
* [Zach Holman](https://github.com/holman)
* [Martin Grenfell](https://github.com/scrooloose)
* [Tim Pope](https://github.com/tpope)

And others!