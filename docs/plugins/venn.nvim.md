# VENN.NVIM

A plugin to draw digrams intractivly with neovim.

## How to use it

- The diagram can be created using the following steps

1. In `INSERT` mode as I have specified in the lazy.nvim hub which I use for
   loading all my plugins. Activate the `venn.nvim` plugin using `<leader>v`.
2. Once you write your word for example `START` which as a a starting point for my digram.
3. Highlight using `C-v` but take some margins before the word and after of it and also on top of it and bottom of it.
4. Use `f` to create a box, and `JKHL` for creat the arrow direction.

```sh
       ┌─────────────┐
       │  local host │◄─────────────────┐
       └──────┬──────┘                  └──┐
              │                            └──────────────────┐
             ◄┼─────┐                                         │
              │     │                                         │
              │     │                ┌─────────────────────┐  │
              └─────┼────────────►   │go to the next stage ├──┘
                    └────────────┐   └─────────────────────┘
    ┌─────────────┐              └─────┐
    │this is a tes├────────────────────┘
    └─────────────┘                                                                                     ┌─────────────────────────────────────────┐
                                                                                                        │   ┌────────┐                            │
┌───────────────────────────────────────────────────────────┐                                           │   │ Multi  │                            │
│      ┌────────┐                                           │                                           │   │ Select │                            │
│      │ Multi  │                                ┌───────+  │                                           │   └─────┬──┘                            │
│      │ Select │    ┌───────┐                   │ Entry │  │                                           │         │                               │
│      └─────┬──*    │ Entry │    ┌────────+     │ Maker │  │                                           │         │        ┌──────┐               │
│            │   ┌───│Manager│────│ Sorter │┐    └───┬───*  │                                           │         └─────▶  │Picker│               │
│            ▼   ▼   └───────*    └────────┘│        │      │                                           │                  └───┬──┘               │
│            1────────┐                 2───┴──┐     │      │                                           │                      │                  │
│      ┌─────│ Picker │                 │Finder│◀────┘      │◀──────────────────────────────────────────┤                      │                  │
│      ▼     └───┬────┘                 └──────*            │                                           │                      │                  │
│ ┌────────┐     │       3────────+         ▲               │                                           │                      └─────▶            │
│ │Selected│     └───────│ Prompt │─────────┘               │                                           │                                         │
│ │ Entry  │             └───┬────┘                         │                                           │                                         │
│ └────────*             ┌───┴────┐  ┌────────┐  ┌────────┐ │                                           │                                         │
│     │  ▲    4─────────┐│ Prompt │  │(Attach)│  │Actions │ │                                           └─────────────────────────────────────────┘
│     ▼  └──▶ │ Results ││ Buffer │◀─┤Mappings│◀─┤User Fn │ │
│5─────────┐  └─────────┘└────────┘  └────────┘  └────────┘ │
││Previewer│                                                │
│└─────────┘                   telescope.nvim architecture  │
└───────────────────────────────────────────────────────────┘


```

```sh
-- symbols (-,|,^,<,>,/,\)
local venn_hint_ascii   = [[
 - and | moves^^   Confirmation moves^^^^
 ^ ^ _K_ ^ ^ ^ ^   _<C-h>_: ◀ , _<C-j>_: ▼
 _H_ ^ ^ _L_ ^ ^   ^     ^       ^   ^  ^
 ^ ^ _J_ ^ ^ ^ ^   _<C-k>_: ▲, _<C-l>_: ►
◀  + ▲ = \ ^ ^ ^   ◄ + ◄ / ► + ► = - / -
 ► + ▲ = / ^ ^ ^   ▲ + ▲ / ▼ + ▼ = | / |
◀  + ▼ = \ ^ ^ ^   other followup symbol
 ► + ▼ = / ^ ^ ^   + ◄▼▲► = <v^> and ▼ = nop      <-------------------------------------+
 _F_: surround^^   _f_: surround     ^^ ^                                               |<───────────────────────────────────────┐
 + corners ^  ^^   overwritten corners                                                  |<──────┐                                │
                              _<C-c>_                                                   |       │                                │
]]                                                                                      |       │                                │
                                                                                        |       │                                │
                                                                                        |       │                                │
up = '▲', down = '▼', left = '◄', right = '►',                                          |       │  ┌──────────────────────────┐  │
                                                                                        |       │  │ANOTHERDEA IS GIVEN HERE├──┘
      ▲                                                                                 |       │  └───────┼───────┬──────────┘
    ◀   ▶                                                                               |       │          │       │
      ▼                                                                                 |       │          │       │
                                                                                        |       │          │       │
                                                           +----------------------+     |       │          │       │
                                                           |ASSUME RIGHT DIRECTION|-----+       │          │       │
                                                           +----------------------+             │          │       │
                                                ┌────────────────────┐                          │          │       │
                                                │ for starting point ├──────────────────────────┘          │       │
                                                └────────────────────┘                           ┌─────────┘       │
                                                     ┌───────────────┐                           │                 │
                                                     │ STARTING POINT├───────────────────────────┘                 │
                                                     └───────────────┘                                             │
                                              ┌──────────────┐                                                     │
                                              │  FORMULATE   ├─────────────────────────────────────────────────────┘
                                              └─────────────┘
                                                    ^    ▲
                                                    |    │
                                                    |    └─────────────────────────────────────┐
                                                    |                                          │
                                                    |                                          │
                                                    +-------------------------+                │◀────────┐
                                                                              |                │         │
                                                                              |                │         │
                                                  +----------------+          |                │         │
                                                  | STARTING POINT |----------+                │         │
                                                  +----------------+                           │         │  this diagram is going to be very handy to my work.
                                                                                               │         │
                                                 ┌──────────────────────────────┬──────────────┘         │
                                                 └──────────────────────────────┘                        │
                                                    ┌──────────────────┐                                 │
                                                    │  STAETING POINT  ├─────────────────────────────────┘
                                                    └──────────────────┘

```
