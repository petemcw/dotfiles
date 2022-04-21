# Dotfiles

Dotfiles are used to configure and personalize your command-line environment. This is the collection of files I use when spinning up a new machine (MacOS or Ubuntu).

**Before you use this repository**, browse the contents and see how all the components work together and mesh with your needs. Then go ahead and [fork it](https://github.com/petemcw/dotfiles/fork), remove what you don't need, and tweak the rest to create your own flavor.

## Installation

To install, run the appropriate command for your system.

:warning: **WARNING** :warning: running the `dotties.sh` command on a configured system could potentially overwrite or break your existing configuration.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/petemcw/dotfiles/master/dotties.sh)"
```

:sparkles: All done! :sparkles:

## Testing (via Docker)

```bash
docker build -t ghcr.io/petemcw/dotfiles .
docker run -it --rm -v $PWD:/root/.dotfiles ghcr.io/petemcw/dotfiles /bin/bash -c "/home/linuxbrew/.dotfiles/dotties.sh"
```

## Thanks

So much inspiration, code, and ideas have been gleaned from many talented people over the years, including but not limited to:

* [Cătălin Mariș](https://github.com/alrra)
* [Ben Hilburn](https://github.com/bhilburn)
* [Ryan Bates](https://github.com/ryanb)
* [Andrei Zmievski](https://github.com/andreiz)
* [Zach Holman](https://github.com/holman)
* [Nick Nisi](https://github.com/nicknisi)
* [Martin Grenfell](https://github.com/scrooloose)

## License

This code uses the [MIT license](https://github.com/petemcw/dotfiles/blob/master/LICENSE).
