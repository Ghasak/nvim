# How to patch Nerd Font

There are several steps to be taken to patch your favoriate font, patching
means it will add all the `nerdfont` four selected font. Here is how I did it

1. Install

```shell
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
```
2. Install fontforge


```shell
brew install fontforge
```
3. Download the font you want to patch, in my case `VictorMono`. I want all the
   icons and also supporting `nerd-font v.3.0`

4. Apply the command,

```shell
fontforge --script ./font-patcher --complete VictorMono-Regular.otf
```



## Reference
- [Nerd Fonts Patcher](https://github.com/ryanoasis/nerd-fonts)
- []()
