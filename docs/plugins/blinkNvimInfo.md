# Blink Nvim Plugin and Extension

Similar to the `cmp.nvim` the `blink.nvim` also uses several types of
extensions that support several types of services that will be integrated with
the `blink.nvim`.

## Extensions

1. Git source for blink.cmp completion plugin. This makes it possible to query
   pull requests, issues, and users from GitHub or GitLab. This is very useful
   when you are writing a commit with nvim.

   - [blink-cmp-git](https://github.com/Kaiser-Yang/blink-cmp-git)

2. Dictionary source for blink.cmp completion plugin. This makes it possible to query a dictionary without leaving the editor.

   - [blink-cmp-dictionary](https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2)

3. Rainbow highlighting and auto-pairs for Neovim. Uses a custom parser
   internally which takes ~2ms to parse a 400k character file, and ~0.15ms for
   subsequent incremental updates. See the roadmap for the current status,
   contributions welcome!

- [blink-pairs](https://github.com/Saghen/blink.pairs
