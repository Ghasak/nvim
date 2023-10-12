# Latex with Nvim

Assume you have th compiled `.pdf` and the `.tex` file are located at same
directory, which are sharing same name. ## Steps

### 1. Run the latex file using

```shell
vim <file_name.tex>
# E.g.,
# vim gh.tex
```

### 2. Run tracker (mylatex)

```shell
mylatex <file_name.tex>
# E.g.,
mylatex gh.tex
```

### 3. Run zathura (PDF READER)

Get into the compliled version of same name as your `.tex` file, which is compiled at first time.

```shell
command zathura <file_name.pdf>
# commmand zathura gh.pdf
```

## REFERENCES
