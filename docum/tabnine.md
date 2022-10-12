# TabNine and nvim
The following plugin for nvim with tabnine `tzachar/cmp-tabnine`, will crash
when you have a `virtualenv` with python, due to the problem with the
compatibilities required to be installed.


```shell
Error executing vim.schedule lua callback: Vim:E475: Invalid value for argument
cmd:
'/Users/gmbp/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/binaries/4.4.149/x86_64-appl
e-darwin/TabNine' is not executable
stack traceback:
        [C]: in function 'jobstart'
        ...e/pack/packer/opt/cmp-tabnine/lua/cmp_tabnine/source.lua:273: in function 'on_exit'
        ...e/pack/packer/opt/cmp-tabnine/lua/cmp_tabnine/source.lua:141: in function 'new'
        ...ite/pack/packer/opt/cmp-tabnine/lua/cmp_tabnine/init.lua:20: in function <...ite/pack/packer/opt/cmp-tabnine/lua/cmp_tabnine/init.lua:19>
```

# How to fix with virtualenv
You need to provide the following:
`x86_64-apple-darwin/`, this is the directory that the `virtualenv` is compatable with the python version.

1. In your default python (shipped with the Mac M1) using the `cmp-tabnine`, Use `PackerSync` to install `cmp-tabnine`
2. Go to the directory:

```shell
~/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/binaries/4.4.149
```
3. Create a directory called `x86_64-apple-darwin`. at `4.4.149`
4. Copy the content (exactly the same), inside the directory `4.4.149` which called
   `aarch64-apple-darwin` the one we created `x86_64-apple-darwin`.


### Note
The content of `x86_64-apple-darwin` is exactly the same `aarch64-apple-darwin`
just that the `virtualenv` needs this directory to run the `TabNine` binary.


- [Image 01](./assets/IMAGE01.png)
