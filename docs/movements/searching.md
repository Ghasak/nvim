# How to search and Replace in NVIM

## Searching in Visual Model

Assume you have the following line that you want to change the `+` to `|`

```
| wow | this | make it so | another | great |
|-----+------+------------+---------+-------|
```

1. Visually select the line using `v`
2. Now, you can search using

:'<,'>s/+/|/cig

In the visual mode, it will allow us to select the string

- If you have this when replacing within a selected block of text, it may be
  because you mistakenly typed %s when you should only type `s`
- I had this happen by selecting a block, typing `: ` and at the prompt `:'<,'>`,
  typing `%s/something/other/` resulting in `:'<,'>%s/something/other/` when the
  proper syntax is `:'<,'>s/something/other/` without the percent.

## How to select/search mulitple words

There are two simple ways to highlight multiple words in vim editor.

1. Go to search mode i.e. type '/' and then type \v followed by the words you
   want to search separated by '|' (pipe). E.g.: /\vword1|word2|word3
2. Go to search mode and type the words you want to search separated by '\|'.
   E.g.: /word1\|word2\|word3

- Basically the first way puts you in the regular expression mode so that you
  do not need to put any extra back slashes before every pipe or other delimiters
  used for searching.

  ## References

  - [my vim replace wiht a regex](https://stackoverflow.com/questions/15842087/my-vim-replace-with-a-regex-is-throwing-a-e488-trailing-characters)
  - [Is there any way to highlight mutplie searches in vim](https://stackoverflow.com/questions/704434/is-there-any-way-to-highlight-multiple-searches-in-gvim)
