# dotfiles

My dofiles.

## Install

To install, just run

```sh
make install
```

The install procedure will

- Check if [github.com/adelynnmckay/dotfiles](https://github.com/adelynnmckay/dotfiles) is cloned to `~/.local/share/ade/dotfiles`, and clone it if not.
- Symlink all files in `~/.local/share/ade/dotfiles/src` to their corresponding path under `~/`.
- If a file already exists at the path, and it's not a symlink to a file in `~/.local/share/ade/dotfiles/src`, then it is backed up in with a `.bak` extension.
- If a `.bak` file already exist, the script throws an error.