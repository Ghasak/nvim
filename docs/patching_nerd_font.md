# How to patch Nerd Font

<!-- vim-markdown-toc GitLab -->

* [Font selector](#font-selector)
* [How to do](#how-to-do)
* [Reference](#reference)

<!-- vim-markdown-toc -->

## Font selector

- Currently I am using the font `fantasque-sans`, which support nerod icons, install it using:

```sh
brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew install --cask font-fantasque-sans-mono
```

- [fantasque-sans](https://github.com/belluzj/fantasque-sans)

There are several steps to be taken to patch your favoriate font, patching
means it will add all the `nerdfont` four selected font. Here is how I did it

## How to do

1. Install

```sh
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
```

2. Install fontforge

```sh
brew install fontforge
```

3. Download the font you want to patch, in my case `VictorMono`. I want all the
   icons and also supporting `nerd-font v.3.0`

4. Apply the command,

```sh
fontforge --script ./font-patcher --complete VictorMono-Regular.otf
```

5. I have created a script that easily can forge any font (font must be
   mono/fixed size) using the script below.

```bash
#!/usr/bin/env bash

default_directory="$HOME/Desktop/nerd_font_patcher/source_font/VictorMonoAll/OTF/"
default_output_directory="$HOME/Desktop/nerd_font_patcher/output_font/"

# Set input directory based on command-line argument or default
directory="${1:-$default_directory}"

# Set output directory based on command-line argument or default
output_directory="${2:-$default_output_directory}"

# Check if the directory exists
if [ ! -d "$directory" ]; then
  echo "Directory not found: $directory"
  exit 1
fi

# Check if the output directory exists
if [ ! -d "$output_directory" ]; then
  echo "Output directory not found: $output_directory"
  exit 1
fi

# Loop over files in the directory with .otf or .ttf extensions
for file in "$directory"/*.otf "$directory"/*.ttf; do
  if [ -f "$file" ]; then
    echo "Processing file: $file"
    fontforge --script ./font-patcher --complete "$file" -out "$output_directory"
    echo "Completed processing file: $file"
  fi
done


```

## Reference

- [Nerd Fonts Patcher](https://github.com/ryanoasis/nerd-fonts)
