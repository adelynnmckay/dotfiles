#!/bin/bash

set -oue pipefail

if [ ! -d "$HOME/.local/share/ade/dotfiles" ]; then
    mkdir -p "$HOME/.local/share/ade/"
    git clone https://github.com/adelynnmckay/dotfiles.git "$HOME/.local/share/ade/dotfiles"
fi

if [ "${PWD}" != "$HOME/.local/share/ade/dotfiles" ]; then
    echo "Updating dotfiles in ~/.local/share/ade/dotfiles..."
    cd "$HOME/.local/share/ade/dotfiles"
    git pull
fi

cd ./src
src_root="$(pwd)"
dst_root="$HOME"

# First pass: check and backup if needed
find . -type f | while read -r src_file; do
  rel_path="${src_file#./}"  # remove leading ./
  dst_file="$dst_root/$rel_path"
  bak_file="$dst_file.bak"

  if [ -e "$dst_file" ]; then
    if [ ! -L "$dst_file" ] || [ "$(readlink -- "$dst_file")" != "$(realpath -- "$src_root/$rel_path")" ]; then
      if [ -e "$bak_file" ]; then
        echo "Error: Backup file already exists: $bak_file"
        exit 1
      fi
      echo "Backing up $dst_file to $bak_file"
      mkdir -p "$(dirname "$bak_file")"
      cp -a -- "$dst_file" "$bak_file"
    fi
  fi
done

# Second pass: create symlinks
find . -type f | while read -r src_file; do
  rel_path="${src_file#./}"  # remove leading ./
  dst_file="$dst_root/$rel_path"
  target_path="$(realpath -- "$src_root/$rel_path")"

  echo "Linking $target_path -> $dst_file"
  mkdir -p "$(dirname "$dst_file")"
  ln -sf -- "$target_path" "$dst_file"
done

echo "Done!"