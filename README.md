# Dotfiles

Dotfiles are used to configure and personalize your computer environment. This is the collection of files I use when spinning up a new machine (MacOS or Ubuntu).

**Before you use these**, browse the contents of the repository and see how all the components work together and mesh with your needs. Then go ahead and [fork it](https://github.com/petemcw/dotfiles/fork), [remove](https://github.com/petemcw/dotfiles/blob/master/README.md#forks) what you don't need, and build on the rest to create your own flavor.

# Installation

To install, run the appropriate command for your system.

:warning: **DO NOT** run the `setup.sh` command if you don't fully understand how it works. It can cause trouble on an already configured system.

## MacOS

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/petemcw/dotfiles/master/src/os/setup.sh)"
```

## Ubuntu

```bash
bash -c "$(wget -qO - https://raw.githubusercontent.com/petemcw/dotfiles/master/src/os/setup.sh)"
```

:sparkles: All done! :sparkles:

# Updates

To update the repository with any new changes and re-run the setup process, simply run the [`setup.sh` script](https://github.com/petemcw/dotfiles/blob/master/src/os/setup.sh). You can also update a particular component by running the appropriate script.

# Customize

You can easily extend the functionality provided by this repository on a local, per-environment basis using the following files.

## Git Settings

The `~/.gitconfig.local` file will be created for you during installation. It's contents are up to you and will be included after content from `~/.gitconfig` allowing you to overwrite and add to the default config.

**Example:** Use `~/.gitconfig.local` to store sensitive information such as credentials:

```bash
[commit]
    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/
    gpgsign = true

[user]
    signingkey = XXXXXXXX
```

## Shell Settings

The `~/.localrc` file will be created for you during installation. It's contents are up to you and will be sourced after all other [Zsh related files](https://github.com/petemcw/dotfiles/tree/master/src/shell/zsh) allowing you to overwrite and add to the default config.

**Example:** Use `~/.localrc` to store sensitive information such as credentials:

```bash
#!/usr/local/bin/zsh

# Set environment
export HOMEBREW_GITHUB_API_TOKEN='XXXXXXXX'
export DIGITAL_OCEAN_TOKEN='XXXXXXXX'

# Path additions
export PATH="$PATH:$HOME/.bin"
```

## Vim Settings

The `~/.vimrc.local` file will be created for you during installation. It's contents are up to you and will be sourced after content from `~/.vimrc` allowing you to overwrite and add to the default config.

## Prompt Theme

Shown with Solarized Dark color scheme and Powerline-patched Inconsolata 18pt (Unicode) / Powerline-patched DejaVu Sans Mono 14pt (Non-ASCII) in iTerm 2.

![Theme Sample](https://cloud.githubusercontent.com/assets/131408/20852751/2d4a779a-b8ad-11e6-9643-40cedc878d05.png)

### Additional Setup:

Install one of the [patched fonts](https://github.com/powerline/fonts) from [Powerline](https://powerline.readthedocs.org/en/latest/installation/linux.html#fonts-installation) or patch your own for the special characters. Optionally set `DEFAULT_USER` in `~/.zshenv` to your username to hide the `user on hostname` info when you’re logged in as yourself on your local machine.

### background_jobs

| Variable | Default Value | Description |
|----------|---------------|-------------|
|`DOUBLEUP_VERBOSE_BG_JOBS`|`true`|If there is more than one background job, this segment will show the number of jobs. Set this to `false` to turn this feature off.|

### status

This segment shows the return code of the last command.

| Variable | Default Value | Description |
|----------|---------------|-------------|
|`DOUBLEUP_VERBOSE_STATUS`|`false`|Set to `true` if you wish to show actual return code when the last command fails.|

### time

| Variable | Default Value | Description |
|----------|---------------|-------------|
|`DOUBLEUP_TIME_FORMAT`|'H:M:S'|ZSH time format to use in this segment.|

As an example, if you wanted a reversed time format, you would use this:

```
# Reversed time format
DOUBLEUP_TIME_FORMAT='%D{%S:%M:%H}'
```

### vcs

By default, the `vcs` segment will provide quite a bit of information. Further customization is provided via:

| Variable | Default Value | Description |
|----------|---------------|-------------|
|`DOUBLEUP_VCS_HIDE_TAGS`|`true`|Set to `false` to allow tags being displayed in the segment.|
|`DOUBLEUP_VCS_SHOW_CHANGESET`|`false`|Set to `true` to display the hash in the segment.|
|`DOUBLEUP_VCS_INTERNAL_HASH_LENGTH`|`8`|How many characters of the hash to display in the segment.|

# Components

The `setup.sh` script is a simple installer that will prompt for some info, check dependencies, set default preferences, install common apps, and so on.

Here's what happens during install:

* The [repository is cloned](https://github.com/petemcw/dotfiles/blob/master/src/os/setup.sh#L50) into your home folder at `~/.dotfiles`
  * If this isn't the first run, you'll be asked if you want to update the repository with an new commits
* Some [additional directories](https://github.com/petemcw/dotfiles/blob/master/src/os/create_directories.sh) will be created
* Files with [user-provided content](https://github.com/petemcw/dotfiles/blob/master/src/os/copy_files.sh) will be copied
  * Any file or directory name ending in `.copy` will get linked into the home directory
* Symlinks for [Git](https://github.com/petemcw/dotfiles/tree/master/src/git), [Shell](https://github.com/petemcw/dotfiles/tree/master/src/shell), and [Vim](https://github.com/petemcw/dotfiles/tree/master/src/vim) configurations will created in `~/`
  * Any file or directory name ending in `.symlink` will get linked into the home directory
* Applications and command-line tools are installed for [MacOS](https://github.com/petemcw/dotfiles/tree/master/src/os/install/macos) & [Ubuntu](https://github.com/petemcw/dotfiles/tree/master/src/os/install/ubuntu)
  * Python-powered [Powerline](https://github.com/petemcw/dotfiles/blob/master/src/os/install/powerline.sh) will be installed
  * [Vim plugins](https://github.com/petemcw/dotfiles/blob/master/src/os/install/vim.sh) are installed
* Sane preferences are set for [MacOS](https://github.com/petemcw/dotfiles/tree/master/src/os/preferences/macos) & [Ubuntu](https://github.com/petemcw/dotfiles/tree/master/src/os/preferences/ubuntu)
* Finally, `zsh` will be set as the [default shell](https://github.com/petemcw/dotfiles/blob/master/src/os/configure_zsh.sh)

# Testing

## MacOS

Unfortunately you won't be able to test your `~/.dotfiles` natively on MacOS using Docker. Instead you'll need to build a VirtualBox machine or try it out in a separate user account on your existing system.

## Linux

A great way to test changes to your `~/.dotfiles` on Linux is by using Docker.

### Build & Run a Test Container

This repository contains a simple configuration for a basic Ubuntu container. Assuming your host system has Docker & Docker Compose properly installed:

#### Build a Container

```bash
docker compose build
```

#### Run a Container

To test the online installation, create a self-removing container like so:

```bash
docker run -it --rm petemcw/dotfiles
```

To test a local `dotfiles` repository, mount as a volume in your self-removing container:

```bash
docker run -it --rm -v $PWD:/root/.dotfiles petemcw/dotfiles
```

# Forks

If you fork this project for your own use, awesome! Just don't forget to update/customize the following:

* Links in this [README.md](https://github.com/petemcw/dotfiles/blob/master/README.md#installation)
* Environment variables in the [`setup.sh` script](https://github.com/petemcw/dotfiles/blob/master/src/os/setup.sh#L5)
* [Login Window](https://github.com/petemcw/dotfiles/blob/master/src/os/preferences/macos/ui_ux.sh#L18) text preference

# Thanks

So much inspiration and code has been gleaned from many talented people over the years, including but not limited to:

* [Cătălin Mariș](https://github.com/alrra)
* [Ben Hilburn](https://github.com/bhilburn)
* [Ryan Bates](https://github.com/ryanb)
* [Andrei Zmievski](https://github.com/andreiz)
* [Zach Holman](https://github.com/holman)
* [Nick Nisi](https://github.com/nicknisi)
* [Martin Grenfell](https://github.com/scrooloose)

# License

The code uses the [MIT license](https://github.com/petemcw/dotfiles/blob/master/LICENSE).
