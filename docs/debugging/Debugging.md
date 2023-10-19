# Debugging Process

The following is not for `Rust` execlusivly, you still can use same for
`C/C++`, `Objective-C` ..etc.

## Using Terminal

Following the steps to debug our current project. Assume you have already
installed `lldb` for `macOS` users or `gdp` for `linux` users.

- Be sure about the `linenumber` that you will set your `breakpoint` might be
  change if you add more code, it wont accept a line number that is out of a
  function for example.
- I configured the `lldb` using something called `lldbinit` which will color
  the memeory output in terminal. Based on two files need in the `home`
  directory. First file is `~/.lldbinit` and also `~/lldbinit.py` both are
  obtained from [LLDBINIT](https://github.com/gdbinit/lldbinit).
- `lldb` in terminal using `cmd` also has a `GUI` client, after you set a
  breakpoint you can use the `gui` to open it.

### Steps in lldb

We are using `lldb-1403.0.17.64 Apple Swift version 5.8 (swiftlang-5.8.0.124.2
clang-1403.0.22.11.100)` as our current `lldb` version to use it for current
debugging.

1. Build your solution for latest code changes, deployed using `cargo run` or `cargo-watch -c -x run --quiet`
2. At the root directory of our `Crate`,  We run in terminal session the command `lldb`.
3. Run the target inside the `lldb` using

```shell
lldb> target create ./target/debug/rusthub
-- Output
Current executable set to '/host_name/devCode/rust_fundamentals/rusthub/target/debug/rusthub' (arm64).
```

4. Create a breakpoint and there are several ways to do that (see inside lldb> b help)

   - By specifying the module name with the line number. Assume we want to set our
     breakpoint at `structs_traits_and_implementation.rs` under the following
     directory `./src/concepts/ch03/structs_traits_and_implementation.rs`. The code in that file
     ```rust
        /// Rust struct, Traits and implementations
        /// # Concepts and fundamental function
        /// ## Notes
        /// - for demonstration purposes only.
        pub fn rust_structs_traits_and_implementation_fn() {
            let var: i8 = 1;
            let mut sum: i8 = 0;
            for i in 0..10 {
                println!("{sum:#?}");
                sum +=i; //<- here I want to set the breakpoint (at line 10)
            }
        }
     ```
   - The `lldb` will knows the directory as you specified in the `mod` and `use` keywords through `Rust`.

     ```shell
     # FORMULA
     (lldb) break set -f <file_name>.extension -l <line_number>
     (lldb) br s -f <file_name>.extension -l <line_numer>
     (lldb) b <file_name>.extension:<line_number>
     break s -f structs_traits_and_implementation.rs -l 10
     or
     br s -f structs_traits_and_implementation.rs -l 10
     or
     b structs_traits_and_implementation.rs:10
     ```

   - You can also specify the method/function name and set the breakpoint.

5. Now, you can run the command `run` and it will show you

```shell
Process 95231 launched: '/Users/gmbp/Desktop/devCode/rust_fundamentals/rusthub/target/debug/rusthub' (arm64)
0
Process 95231 stopped
* thread #1, name = 'main', queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100001e94 rusthub`rusthub::concepts::ch03::structs_traits_and_implementation::rust_structs_traits_and_implementation_fn::hb00f8563377f3ff0 at structs_traits_and_implementation.rs:10:9
   7   	    let mut sum: i8 = 0;
   8   	    for i in 0..10 {
   9   	        println!("{sum:#?}");
-> 10  	        sum +=i;
   11  	    }
   12  	}
Target 0: (rusthub) stopped.
```

6. Now you can investigate the rest of commands for the `lldb debugger server`

```shell
(lldb) frame variable
(lldb) n for next, c for continue, s for step in ..etc.
```

## Current workflow for investigate variables

I used the following verifiction to understand more about the memory allocation.

- I have created a file at `./src/concepts/ch03/structs_traits_and_implementation.rs` that has the following

```rust

// struct ByteBuf<'a>(&'a [u8]);
//
// impl<'a> std::fmt::LowerHex for ByteBuf<'a> {
//     fn fmt(&self, fmtr: &mut std::fmt::Formatter) -> Result<(), std::fmt::Error> {
//         for byte in self.0 {
//             fmtr.write_fmt(format_args!("{:02x}", byte));
//         }
//         Ok(())
//     }
// }
/// Rust struct, Traits and implementations
/// # Concepts and fundamental function
/// ## Notes
/// - for demonstration purposes only.

pub fn rust_structs_traits_and_implementation_fn() {
    let var: i8 = 123;
    let mut sum: i8 = 0;
    for i in 0..10 {
        println!("{sum:#?}");
        sum +=i;          //<- I set the breakpoint here
    }
    // 123 -> 7b00
    // let mut buff = [0_u8; 2];
    // buff[0] = 123;
    //
    // println!("{:x}", ByteBuf(&buff));
}
```

- first I uncommented the `struct` above to print the memory allocation of the
  variable `buff` which is a `stack array` with two elements [0,_] contains
  `0` and `0` of type `u8`. Then I assigned for first element `0`-> 123 value.
  The struct will help us to write it in `hex` to the terminal.
- Then I run to find out that the element of `123` of `u8` type is actually `7b00` in hex.
- Now we will uncomment this struct and its usage and focus only on our current code

```rust

pub fn rust_structs_traits_and_implementation_fn() {
    let var: i8 = 123;
    let mut sum: i8 = 0;
    for i in 0..10 {
        println!("{sum:#?}");
        sum +=i;          //<- I set the breakpoint here, linenumber here is (21)
    }
```

- I run in terminal

```shel
lldb
```

- Then, set the target inside the `lldb` shell

```
(lldb) target create ./target/debug/rusthub
```

- Then I set a breakpoint at line 21 of the file `./src/concepts/ch03/structs_traits_and_implementation.rs`

```rust
(lldb) br s -f structs_traits_and_implementation.rs -l 21
```

- Now, lets view the memeory of the same variable which I will examine the same
  variable we know its value in `hex` this variable now called `var` (see the
  code above), its value is `123` and we know its `hex` value is `7b00` of two
  bytes `7b` and `00` to store the variable `123`. The command to view memeory
  is `mem read &<variable_name>`. You will notice in the result (`7b 00`) at
  this memeory address.

```shell
(lldb) mem read &var
0x16fdfe29e: 7b 00 b0 e2 df 6f 01 00 00 00 44 21 00 00 01 00  {....o....D!....
```

- You can see in another format also

```shell
(lldb) mem read --size 4 --format x &var
0x16fdfe29e: 0xe2b0007b 0x00016fdf 0x21440000 0x00010000
0x16fdfe2ae: 0xe2d00000 0x00016fdf 0x20d00000 0x00010000
```

- You can use after (`n`:next, `s`: step-in, `c`:continue ..etc.). Also, you
  can use the command `run`. [read more
  here](https://lldb.llvm.org/use/map.html)

- There is also `frame info`, Most important is `bt` `backtracer` will show you
  all the current frames created for debugging. Then you can select the number
  you want to view and run. `framenumber` is taken from the `bt` command. `bt`
  is read from bottom to top, as a `stack`.

```shell
(lldb) frame select <fram_number>
```

## Using Nvim

In `nvim` its strightforward as shown below. We use the command `mem read &var`
to debug and check the memory.

- Installing the `lldb` for `nvim` is done using the `dap` module with `mason`
  and you can find the configurations located at `dap_rust_setting.lua` module
  in our nvim with the following config

```lua
    local install_root_dir = vim.fn.stdpath "data" .. "/mason"
    local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
```

- The adapter for debugging in nvim is located here
  `~/.local/share/nvim/mason/packages/codelldb/extension/lldb/bin/lldb`.
- ![Image01](./docs/assets/m02.png)

## Using vscode

Also its strightforward, using `vscode memeory veiwer` and also you will need
`lldbvm` library. The `lldb` is installed at
`~/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/lldb/bin/lldb` with current
version `lldb version 16.0.0-custom rust-enabled`

- ![Image01](./docs/assets/m03.png)

## References

- [lldb manual](https://lldb.llvm.org/use/map.html)
- [Referenc_01](https://www.classes.cs.uchicago.edu/archive/2018/winter/15200-3/assigns/week5/lldb.html)
- [Referenc_02](https://aaronbloomfield.github.io/pdr/tutorials/02-lldb/index.html)
- [Referenc_03](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/lldb-terminal-workflow-tutorial.html)
- [Referenc_04](https://www.youtube.com/watch?v=v_C1cvo1biI)
- [Referenc_05](https://www.youtube.com/watch?v=2GV0K9Y2MKA)
- [Referenc_06](https://www.youtube.com/watch?v=S3TB2pDOEWY)
- [Debugging, Printing and logging](https://learn.udacity.com/courses/ud774)
