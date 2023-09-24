# Ranger in action

## ChangeLog

- `2023-09-23 16:32`: I have updated the ranger to open automatically the buffer for given file.

## Rnvimr
This library require to install the `ranger` using the `pip` not `brew`.
Including, read more here:

```sh
# ArchLinux install all requirements is extremely convenient
yay -S ranger python-pynvim ueberzug
# ~ `ueberzug` can be replaced with `ueberzugpp` ~
# pip
# macOS users please install ranger by `pip3 ranger-fm` instead of `brew install ranger`
# There're some issues about installation, such as https://github.com/ranger/ranger/issues/1214
# Please refer to the issues of ranger for more details
pip3 install ranger-fm pynvim
# Ueberzug/Ueberzugpp is not supported in macOS because it depends on X11
pip3 install ueberzug
```


## Reference
- [rnvimr lib](https://github.com/kevinhwang91/rnvimr)
- [how to change the default text editor in ranger](https://unix.stackexchange.com/questions/367452/how-to-change-the-default-text-editor-in-ranger)
