# Efficient Text Formatting in Vim with Visual Selection and Regex Substitution


<!-- vim-markdown-toc Marked -->

* [**Vim `:s` Substitution Command - Tips & Tricks**](#**vim-`:s`-substitution-command---tips-&-tricks**)
    * [**Table of Contents**](#**table-of-contents**)
    * [**1. Introduction to `:s` Command** <a name="introduction"></a>](#**1.-introduction-to-`:s`-command**-<a-name="introduction"></a>)
    * [**2. General Syntax of `:s` Command** <a name="general-syntax"></a>](#**2.-general-syntax-of-`:s`-command**-<a-name="general-syntax"></a>)
    * [**3. Examples and Use Cases** <a name="examples-and-use-cases"></a>](#**3.-examples-and-use-cases**-<a-name="examples-and-use-cases"></a>)
        * [3.1 Moving `<leader>` to the End of the Line](#3.1-moving-`<leader>`-to-the-end-of-the-line)
        * [3.2 Swapping Words](#3.2-swapping-words)
        * [3.3 Select Words Ending with Optional Spaces](#3.3-select-words-ending-with-optional-spaces)
        * [3.4 Dynamic Replacement Based on Data Types](#3.4-dynamic-replacement-based-on-data-types)
    * [**4. Regular Expression Modifiers** <a name="regex-modifiers"></a>](#**4.-regular-expression-modifiers**-<a-name="regex-modifiers"></a>)
    * [**5. Capture Groups and Substitutions** <a name="capture-groups"></a>](#**5.-capture-groups-and-substitutions**-<a-name="capture-groups"></a>)
        * [Capturing Groups in Vim:](#capturing-groups-in-vim:)
    * [**6. Advanced Substitution Techniques** <a name="advanced-techniques"></a>](#**6.-advanced-substitution-techniques**-<a-name="advanced-techniques"></a>)
        * [Using `\=expr` for Dynamic Replacement](#using-`\=expr`-for-dynamic-replacement)
    * [**7. Summary and Key Takeaways** <a name="summary"></a>](#**7.-summary-and-key-takeaways**-<a-name="summary"></a>)
        * [Key Takeaways:](#key-takeaways:)
    * [**8. Notes and Best Practices**](#**8.-notes-and-best-practices**)
    * [**9. Reference Table for Flags**](#**9.-reference-table-for-flags**)
    * [**Conclusion**](#**conclusion**)
    * [What is one-eyed fighting Kirby?](#what-is-one-eyed-fighting-kirby?)
        * [1. Neovim or Vim Interpretation:](#1.-neovim-or-vim-interpretation:)
        * [2. Regex Interpretation:](#2.-regex-interpretation:)
        * [Hypothetical Example:](#hypothetical-example:)
        * [Conclusion:](#conclusion:)
    * [Referneces](#referneces)

<!-- vim-markdown-toc -->

Here’s a comprehensive note capturing all the **tips and tricks for Vim's `:s`
substitution command** along with the examples we discussed. I've organized it
with tables, summaries, highlights, and notes to serve as a detailed reference.

---

# **Vim `:s` Substitution Command - Tips & Tricks**

This note collects all the Vim `:s` substitution tips we've covered so far. It
provides examples, syntax explanations, and practical use cases. Use this as a
reference for working with substitutions in Vim or Neovim.

---

## **Table of Contents**

1. [Introduction to `:s` Command](#introduction)
2. [General Syntax of `:s`](#general-syntax)
3. [Examples and Use Cases](#examples-and-use-cases)
4. [Regular Expression Modifiers](#regex-modifiers)
5. [Capture Groups and Substitutions](#capture-groups)
6. [Advanced Substitution Techniques](#advanced-techniques)
7. [Summary and Key Takeaways](#summary)

---

## **1. Introduction to `:s` Command** <a name="introduction"></a>

The Vim `:s` command is used for **substitution** within lines of a file. It
allows you to match patterns using **regular expressions (regex)** and replace
them with desired text.

**Basic Structure:**

```vim
:[range]s/pattern/replacement/[flags]
```

- **range**: The part of the file to search (optional).
- **pattern**: The regex pattern to search.
- **replacement**: The text that will replace the matched pattern.
- **flags**: Additional options like `g` for global replacement.

---

## **2. General Syntax of `:s` Command** <a name="general-syntax"></a>

| **Component**   | **Explanation**                                            |
| --------------- | ---------------------------------------------------------- |
| `:%s/`          | Substitution over the entire file.                         |
| `/pattern/`     | The regex pattern to match.                                |
| `/replacement/` | The text that replaces the matched pattern.                |
| `g`             | Replaces all occurrences on a line (global).               |
| `\v`            | Enables **very magic** mode for easier regex syntax.       |
| `\1`, `\2`      | Refers to captured groups in the replacement.              |
| `\zs`, `\ze`    | Marks the start and end of the match to capture partially. |

---

## **3. Examples and Use Cases** <a name="examples-and-use-cases"></a>

### 3.1 Moving `<leader>` to the End of the Line

**Input:**

```vim
nnoremap("<leaderA>pv", ":Ex<CR>")
vnoremap("<leaderC>pv", ":Ex<CR>")
```

**Command:**

```vim
:%s/\v(\w)noremap\("<leader\w>pv",\s*(.*)\)/\1"pv", \2"<leader\w>"/g
```

**Output:**

```vim
n"pv", ":Ex<CR>"<leaderA>
v"pv", ":Ex<CR>"<leaderC>
```

---

### 3.2 Swapping Words

**Input:**

```text
banana apple cherry
```

**Command to Swap `banana` and `cherry`:**

```vim
:%s/\v(\w+)\s(\w+)\s(\w+)/\3 \2 \1/g
```

**Output:**

```text
cherry apple banana
```

---

### 3.3 Select Words Ending with Optional Spaces

**Input:**

```text
foo";
bar ";
baz";
```

**Command:**

```vim
:%s/\v(\w+)\s*";/\1/g
```

**Output:**

```text
foo
bar
baz
```

---

### 3.4 Dynamic Replacement Based on Data Types

**Input:**

```python
self.first_name: str = None
self.age: int = 0
self.salary: float = 0.0
```

**Command:**

```vim
:%s/\vself\.(\w+):\s*(str|int|float)\s*=\s*.+/\=submatch(2) == 'str' ? 'self.'.submatch(1).' = None' : submatch(2) == 'int' ? 'self.'.submatch(1).' = 0' : 'self.'.submatch(1).' = 0.0'/g
```

**Output:**

```python
self.first_name = None
self.age = 0
self.salary = 0.0
```

---

## **4. Regular Expression Modifiers** <a name="regex-modifiers"></a>

| **Modifier** | **Description**                              |
| ------------ | -------------------------------------------- |
| `\v`         | **Very magic**: Makes regex easier to write. |
| `\s`         | Matches any whitespace.                      |
| `\w`         | Matches any word character `[a-zA-Z0-9_]`.   |
| `\zs`        | Marks the start of the match.                |
| `\ze`        | Marks the end of the match.                  |

---

## **5. Capture Groups and Substitutions** <a name="capture-groups"></a>

### Capturing Groups in Vim:

- Enclose a part of your regex in parentheses `()` to **capture** it.
- Use `\1`, `\2`, etc., to refer to these captured groups in the replacement part.

**Example:**

```vim
:%s/\v(\w+)\s(\w+)/\2 \1/g
```

**Input:**

```
apple banana
```

**Output:**

```
banana apple
```

---

## **6. Advanced Substitution Techniques** <a name="advanced-techniques"></a>

### Using `\=expr` for Dynamic Replacement

The `\=` operator allows for **evaluating expressions** during substitution.

**Example:**

```vim
:%s/\v(\w+):\s*(int|str|float)/\=submatch(2) == 'int' ? submatch(1).' = 0' : submatch(1).' = None'/g
```

This dynamically replaces variable declarations based on their types.

---

## **7. Summary and Key Takeaways** <a name="summary"></a>

### Key Takeaways:

- **Use `\v`** to enable **very magic** mode and simplify your regex.
- **Capture groups** allow you to rearrange text easily using `\1`, `\2`, etc.
- **Dynamic substitutions** can be achieved with `\=expr` to evaluate logic
during replacement.
- **Global replacements** (`g` flag) ensure all occurrences are replaced in a
line.

---

## **8. Notes and Best Practices**

1. **Test your regex on small ranges first**: Use `:s` on a few lines before
   applying it to the entire file.
2. **Use `\v` mode** to avoid excessive escaping in your patterns.
3. **Backup your file**: When running complex replacements, consider saving a
   copy of your file before applying them.
4. **Use visual selection (`:'<,'>s/`)**: You can limit substitutions to
   specific parts of your text using visual mode.

---

## **9. Reference Table for Flags**

| **Flag** | **Description**                       |
| -------- | ------------------------------------- |
| `g`      | Global replacement on each line.      |
| `c`      | Confirm each replacement.             |
| `i`      | Ignore case during matching.          |
| `n`      | Show how many replacements were made. |

---

## **Conclusion**

With these tips, tricks, and examples, you now have a comprehensive
understanding of Vim's `:s` substitution command. Whether it's simple word
swaps, capturing groups, or dynamic replacements based on logic, these
techniques will help you efficiently manipulate text in Vim.

Feel free to refer back to this guide whenever you need to perform advanced
substitutions in your workflows!

---

## What is one-eyed fighting Kirby?

The term "one-eyed fighting Kirby" is not a standard or common term in Neovim
(or Vim) or in regex terminology. However, this might be a humorous or
metaphorical reference used in specific communities or discussions, potentially
referring to a particular pattern, technique, or issue that resembles something
quirky, playful, or unexpected, like the iconic video game character Kirby.

Here are a few possible interpretations:

### 1. Neovim or Vim Interpretation:

In Vim/Neovim communities, users often create nicknames for certain obscure or
tricky behaviors or keybindings. The phrase could be a humorous label for
something that is "fighting" you during editing, like a difficult-to-find error
or unexpected behavior in a keybinding or search.

### 2. Regex Interpretation:

In regex, there is no concept of a "one-eyed fighting Kirby." However, if the
term is being used metaphorically, it might refer to a regex pattern that is
unexpectedly matching (or not matching) things due to tricky edge cases, much
like Kirby's ability to adapt to various challenges in video games.

For example, regex patterns with unexpected matches, especially involving
greedy or non-greedy quantifiers, or tricky backreferences, could be likened to
something that behaves unpredictably, hence "fighting."

### Hypothetical Example:

If "one-eyed fighting Kirby" is referring to a regex pattern in Neovim that
behaves unexpectedly, it could be a playful term for something like:

```regex
.+
```

This pattern greedily matches everything on a line, which can sometimes lead to
unexpected results, especially when dealing with more complex patterns, making
it seem like you're "fighting" with the regex.

### Conclusion:

If this is a specific term you've encountered in a forum, plugin, or community,
it would help to have more context. Otherwise, it's likely a playful,
metaphorical term used to describe a quirky or unexpected behavior either in
Neovim or regex.

## Referneces

- [thoughts -200](https://waylonwalker.com/thoughts-200/)
