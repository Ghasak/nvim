# **Comprehensive Regex Guide**

Here’s a thorough explanation of regex metacharacters and quantifiers,
including detailed examples that fit them all. This version includes a **table
format** and covers **common regex patterns** with examples, use cases, and a
sample regex for email validation.

<!-- vim-markdown-toc Marked -->

* [**Table of Metacharacters and Quantifiers**](#**table-of-metacharacters-and-quantifiers**)
* [**Quantifiers**](#**quantifiers**)
* [**Sample Regular Expressions and Use Cases**](#**sample-regular-expressions-and-use-cases**)
    * [1. **Email Validation**](#1.-**email-validation**)
    * [2. **Matching a US Phone Number**](#2.-**matching-a-us-phone-number**)
    * [3. **Extracting Words from Text**](#3.-**extracting-words-from-text**)
    * [4. **Validating a Date in `YYYY-MM-DD` Format**](#4.-**validating-a-date-in-`yyyy-mm-dd`-format**)
* [**Regex Behavior Across Tools**](#**regex-behavior-across-tools**)
* [**Summary and Key Takeaways**](#**summary-and-key-takeaways**)
* [**How to Use OR (`|`) in Regex**](#**how-to-use-or-(`|`)-in-regex**)
    * [**Basic Syntax:**](#**basic-syntax:**)
* [**Examples of OR (`|`) Usage**](#**examples-of-or-(`|`)-usage**)
    * [**1. Matching Multiple Words (Alternation Example)**](#**1.-matching-multiple-words-(alternation-example)**)
    * [**Example Usage:**](#**example-usage:**)
    * [**2. Grouping OR Patterns Using Parentheses**](#**2.-grouping-or-patterns-using-parentheses**)
        * [**Example: Matching Words with Different Endings**](#**example:-matching-words-with-different-endings**)
        * [**Using Grouping in Vim:**](#**using-grouping-in-vim:**)
    * [**3. Using OR with Character Classes**](#**3.-using-or-with-character-classes**)
        * [**Example: Matching Vowels or Digits**](#**example:-matching-vowels-or-digits**)
    * [**4. Complex Alternation with Anchors**](#**4.-complex-alternation-with-anchors**)
        * [**Example: Match Lines Starting with "cat" or "dog"**](#**example:-match-lines-starting-with-"cat"-or-"dog"**)
* [**Combining OR with Quantifiers**](#**combining-or-with-quantifiers**)
        * [**Example: Match "ab" or "cd" Repeated 1 or More Times**](#**example:-match-"ab"-or-"cd"-repeated-1-or-more-times**)
* [**Summary Table: Using OR in Regex**](#**summary-table:-using-or-in-regex**)
* [**Conclusion**](#**conclusion**)
* [Using Not in Regular Expression](#using-not-in-regular-expression)
* [**Ways to Express "NOT" in Regex**](#**ways-to-express-"not"-in-regex**)
    * [1. **Negated Character Class (`[^ ]`)**](#1.-**negated-character-class-(`[^-]`)**)
        * [**Syntax:**](#**syntax:**)
        * [**Example:**](#**example:**)
    * [2. **Negative Lookahead (`(?!...)`)**](#2.-**negative-lookahead-(`(?!...)`)**)
        * [**Syntax:**](#**syntax:**)
        * [**Example in Vim:**](#**example-in-vim:**)
    * [3. **Negative Lookbehind (`(?<!...)`)**](#3.-**negative-lookbehind-(`(?<!...)`)**)
        * [**Syntax:**](#**syntax:**)
        * [**Example in Vim:**](#**example-in-vim:**)
    * [4. **Anchors with Negated Patterns**](#4.-**anchors-with-negated-patterns**)
        * [**Example: Match Lines that Do Not Start with a Digit**](#**example:-match-lines-that-do-not-start-with-a-digit**)
        * [**Example in Vim:**](#**example-in-vim:**)
    * [**Summary Table: NOT Patterns in Regex**](#**summary-table:-not-patterns-in-regex**)
    * [**Sample Use Case: Matching Non-Email Strings**](#**sample-use-case:-matching-non-email-strings**)
        * [Regex to Match Strings That **Are Not Emails**:](#regex-to-match-strings-that-**are-not-emails**:)
        * [**Example in Vim:**](#**example-in-vim:**)
    * [**Conclusion**](#**conclusion**)

<!-- vim-markdown-toc -->

---

## **Table of Metacharacters and Quantifiers**

| **Symbol** | **Description**                        | **Example**             | **Explanation / Matches**                |
| ---------- | -------------------------------------- | ----------------------- | ---------------------------------------- |
| `.`        | Any character except newline           | `a.b`                   | Matches `aab`, `acb`, but not `ab`.      |
| `\d`       | Digit (0-9)                            | `\d{3}`                 | Matches `123` but not `abc`.             |
| `\D`       | Not a digit (0-9)                      | `\D+`                   | Matches `abc` but not `123`.             |
| `\w`       | Word character (a-z, A-Z, 0-9, \_)     | `\w+`                   | Matches `hello_world1`.                  |
| `\W`       | Not a word character                   | `\W+`                   | Matches `@#%`.                           |
| `\s`       | Whitespace (space, tab, newline)       | `\s+`                   | Matches spaces or newlines.              |
| `\S`       | Not whitespace                         | `\S+`                   | Matches `hello`, skips spaces.           |
| `\b`       | Word boundary                          | `\bcat\b`               | Matches `cat` but not `catalog`.         |
| `\B`       | Not a word boundary                    | `\Bcat`                 | Matches `catalog` but not `cat`.         |
| `^`        | Beginning of a string                  | `^Hello`                | Matches strings starting with `Hello`.   |
| `$`        | End of a string                        | `world$`                | Matches strings ending with `world`.     |
| `[ ]`      | Matches characters in brackets         | `[aeiou]`               | Matches any vowel.                       |
| `[^ ]`     | Matches characters **not** in brackets | `[^aeiou]`              | Matches non-vowels.                      |
| `          | `                                      | Either or (alternation) | `cat dog` Matches either `cat` or `dog`. |
| `( )`      | Grouping                               | `(abc)+`                | Matches `abcabc`.                        |

---

## **Quantifiers**

| **Symbol** | **Description**            | **Example** | **Explanation / Matches**                  |
| ---------- | -------------------------- | ----------- | ------------------------------------------ |
| `*`        | 0 or more                  | `a*`        | Matches ``, `a`, `aaa`.                    |
| `+`        | 1 or more                  | `a+`        | Matches `a`, `aa`.                         |
| `?`        | 0 or one                   | `a?`        | Matches ``, `a`.                           |
| `{n}`      | Exact number               | `\d{3}`     | Matches exactly 3 digits, e.g., `123`.     |
| `{n,m}`    | Range (minimum to maximum) | `\d{2,4}`   | Matches 2 to 4 digits, e.g., `12`, `1234`. |

---

## **Sample Regular Expressions and Use Cases**

### 1. **Email Validation**

```regex
[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+
```

- **Explanation**:

  - `[a-zA-Z0-9_.+-]+`: Matches the username (letters, numbers, dots, and special characters).
  - `@`: Matches the `@` symbol.
  - `[a-zA-Z0-9-]+`: Matches the domain name (letters, numbers, and hyphens).
  - `\.`: Matches the dot (`.`) before the TLD.
  - `[a-zA-Z0-9-.]+`: Matches the top-level domain (TLD) part.

- **Examples**:
  - Matches: `user.name@example.com`, `user123@domain.co.uk`.
  - Does **not match**: `user@domain`, `user@.com`.

---

### 2. **Matching a US Phone Number**

```regex
\(\d{3}\)\s?\d{3}-\d{4}
```

- **Explanation**:

  - `\(\d{3}\)`: Matches a 3-digit area code in parentheses (e.g., `(123)`).
  - `\s?`: Matches an optional space after the area code.
  - `\d{3}-\d{4}`: Matches a 3-digit prefix and a 4-digit line number.

- **Examples**:
  - Matches: `(123) 456-7890`, `(987)456-1234`.

---

### 3. **Extracting Words from Text**

```regex
\b\w+\b
```

- **Explanation**:

  - `\b`: Matches a word boundary.
  - `\w+`: Matches one or more word characters.
  - `\b`: Ensures the match ends at a word boundary.

- **Examples**:
  - Input: `"The quick brown fox."`
  - Matches: `The`, `quick`, `brown`, `fox`.

---

### 4. **Validating a Date in `YYYY-MM-DD` Format**

```regex
\d{4}-\d{2}-\d{2}
```

- **Explanation**:

  - `\d{4}`: Matches a 4-digit year.
  - `-`: Matches the dash (`-`) separator.
  - `\d{2}`: Matches a 2-digit month and day.

- **Examples**:
  - Matches: `2023-10-15`, `1999-01-01`.
  - Does **not match**: `23-10-15`, `2023/10/15`.

---

## **Regex Behavior Across Tools**

| **Tool / Language** | **Does `.` Match Newlines?** | **How to Match Newlines** |
| ------------------- | ---------------------------- | ------------------------- |
| **Vim / Neovim**    | No                           | Use `\_.` or `\_.*`.      |
| **JavaScript**      | No                           | Use `/./s`.               |
| **Python**          | No                           | Use `re.DOTALL`.          |
| **Atom Editor**     | Yes (default)                | `.*` matches everything.  |

---

## **Summary and Key Takeaways**

1. **Dot (`.`)** matches any character **except newlines**. Use modifiers like
   `\_` (Vim) or `/s` (JavaScript) to match newlines.
2. **Quantifiers** (`*`, `+`, `{n}`) control the number of matches.
3. **Grouping and capturing** (`()`) allow rearranging and extracting parts of
   text.
4. Use **word boundaries** (`\b`) to match entire words without partial
   matches.
5. **Bracket expressions** (`[ ]` and `[^ ]`) allow flexible character
   matching.

---

This comprehensive guide covers the basics, advanced techniques, and real-world
examples for working with **regular expressions**. Let me know if you need more
examples or further clarifications!

Yes! In regular expressions, **"OR" logic** is represented by the **pipe symbol (`|`)**, which acts as an **alternation operator**. It works similarly to a logical "OR" — allowing you to match **either one pattern or another**.

---

## **How to Use OR (`|`) in Regex**

The **`|`** symbol matches **one pattern OR another pattern**. It works between different expressions or sub-patterns.

### **Basic Syntax:**

```regex
pattern1|pattern2
```

This will match **either `pattern1` or `pattern2`**.

---

## **Examples of OR (`|`) Usage**

### **1. Matching Multiple Words (Alternation Example)**

```regex
cat|dog|bird
```

- **Matches:** `cat`, `dog`, or `bird`.
- **Does not match:** `fish`.

### **Example Usage:**

```vim
:%s/\vcat|dog|bird/pet/g
```

This Vim command replaces occurrences of `cat`, `dog`, or `bird` with the word `pet`.

---

### **2. Grouping OR Patterns Using Parentheses**

Sometimes you need to **group multiple patterns** with OR logic inside parentheses for more complex matching.

#### **Example: Matching Words with Different Endings**

```regex
colou?r|colou?rful
```

- **Matches:** `color`, `colour`, `colorful`, or `colourful`.
- Here, the `?` after the `u` makes the `u` optional, allowing both `color` and `colour`.

#### **Using Grouping in Vim:**

```vim
:%s/\v(colou?r|colou?rful)/paint/g
```

This command will replace all occurrences of `color`, `colour`, `colorful`, and `colourful` with `paint`.

---

### **3. Using OR with Character Classes**

You can also use OR logic within **bracket expressions**.

#### **Example: Matching Vowels or Digits**

```regex
[aeiou]|[0-9]
```

- **Matches:** Any vowel (`a`, `e`, `i`, `o`, `u`) or any digit (`0-9`).
- **Example Input:** `a1b2c3`
  - Matches: `a`, `1`, `2`, and `3`.

---

### **4. Complex Alternation with Anchors**

You can use **anchors** (`^` for start, `$` for end) along with alternation.

#### **Example: Match Lines Starting with "cat" or "dog"**

```regex
^(cat|dog)
```

- **Matches:** Lines that begin with `cat` or `dog`.

**Vim Command:**

```vim
:%s/^(cat|dog)/animal/
```

This command replaces lines starting with `cat` or `dog` with the word `animal`.

---

## **Combining OR with Quantifiers**

You can combine the **OR operator (`|`)** with **quantifiers** like `*`, `+`, or `{n}`.

#### **Example: Match "ab" or "cd" Repeated 1 or More Times**

```regex
(ab|cd)+
```

- **Matches:** `ab`, `cd`, `abab`, `cdcd`, or any combination repeated at least once.

---

## **Summary Table: Using OR in Regex**

| **Pattern**         | **Explanation**                                  | **Example Matches**   |
| ------------------- | ------------------------------------------------ | --------------------- |
| `cat ordog`         | Matches either `cat` or `dog`.                   | `cat`, `dog`          |
| `(abcd)+`           | Matches `ab` or `cd` repeated one or more times. | `ab`, `cd`, `abab`    |
| `[aeiou][0-9]`      | Matches vowels or digits.                        | `a`, `3`, `i`         |
| `^(catdog)`         | Matches lines starting with `cat` or `dog`.      | `catfish`, `doghouse` |
| `colou?rcolou?rful` | Matches either spelling of color and variants.   | `color`, `colourful`  |

---

## **Conclusion**

- The **`|` (OR)** operator in regex allows you to match **alternatives**.
- You can use it for **simple alternations** (`cat|dog`) or with **grouping**
  for more complex matches (`(colou?r|colou?rful)`).
- OR logic also works well with **quantifiers** and **anchors** for advanced
  pattern matching.

This flexibility makes **regular expressions** incredibly powerful for text
processing. Let me know if you have more questions or need further
clarification!

## Using Not in Regular Expression

Great question! In **regular expressions**, there are several ways to implement **"NOT" logic**, such as matching patterns **that do not contain** certain characters or sequences. Here are the main methods:

---

## **Ways to Express "NOT" in Regex**

### 1. **Negated Character Class (`[^ ]`)**

A **negated character class** matches any character **that is not listed** inside the square brackets.

#### **Syntax:**

```regex
[^abc]
```

- **Explanation:** Matches any character **except** `a`, `b`, or `c`.

#### **Example:**

```vim
:%s/[^0-9]/X/g
```

- **Input:**
  ```
  a1b2c3
  ```
- **Output:**
  ```
  X1X2X3
  ```
- **Explanation:** This command replaces all non-digit characters with `X`.

---

### 2. **Negative Lookahead (`(?!...)`)**

A **negative lookahead** ensures that a pattern is **not followed** by a specific sequence.

#### **Syntax:**

```regex
foo(?!bar)
```

- **Explanation:** Matches `foo` only if it is **not followed by** `bar`.

#### **Example in Vim:**

```vim
:%s/foo(?!bar)/X/g
```

- **Input:**
  ```
  foobar
  fooqux
  ```
- **Output:**
  ```
  foobar
  Xqux
  ```
- **Explanation:** Only the `foo` not followed by `bar` is replaced.

---

### 3. **Negative Lookbehind (`(?<!...)`)**

A **negative lookbehind** ensures that a pattern is **not preceded** by a specific sequence.

#### **Syntax:**

```regex
(?<!abc)def
```

- **Explanation:** Matches `def` only if it is **not preceded by** `abc`.

#### **Example in Vim:**

```vim
:%s/(?<!abc)def/X/g
```

- **Input:**
  ```
  abcdef
  xyzdef
  ```
- **Output:**
  ```
  abcdef
  xyzX
  ```
- **Explanation:** Only the `def` not preceded by `abc` is replaced.

---

### 4. **Anchors with Negated Patterns**

You can combine **anchors** (`^` for start, `$` for end) with negated character classes to ensure **certain characters do not appear** at specific positions.

#### **Example: Match Lines that Do Not Start with a Digit**

```regex
^[^0-9].*
```

- **Explanation:** Matches lines **that do not start** with a digit.

#### **Example in Vim:**

```vim
:%s/^[^0-9].*/Non-digit start/g
```

- **Input:**
  ```
  123abc
  abc123
  ```
- **Output:**
  ```
  123abc
  Non-digit start
  ```

---

### **Summary Table: NOT Patterns in Regex**

| **Pattern** | **Explanation**                                    | **Example**                                                |
| ----------- | -------------------------------------------------- | ---------------------------------------------------------- |
| `[^abc]`    | Matches any character **except** `a`, `b`, or `c`. | `[^0-9]` matches non-digit chars.                          |
| `(?!...)`   | Negative lookahead (not followed by...).           | `foo(?!bar)` matches `foo`, but not if followed by `bar`.  |
| `(?<!...)`  | Negative lookbehind (not preceded by...).          | `(?<!abc)def` matches `def`, but not if preceded by `abc`. |
| `^[^0-9]`   | Matches lines **not starting** with a digit.       | Useful for filtering specific lines.                       |

---

### **Sample Use Case: Matching Non-Email Strings**

#### Regex to Match Strings That **Are Not Emails**:

```regex
^(?![a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+).*$
```

- **Explanation:** Matches any line that **does not contain a valid email address**.

#### **Example in Vim:**

```vim
:%s/^(?!.*@.*\..*).*$/Non-email line/g
```

- **Input:**
  ```
  user@example.com
  hello world
  ```
- **Output:**
  ```
  user@example.com
  Non-email line
  ```

---

### **Conclusion**

In **regex**, "NOT" logic can be implemented in different ways, depending on what you need:

- **Negated character classes** (`[^ ]`) for individual characters.
- **Negative lookahead** (`(?!...)`) to prevent specific sequences from
  following.
- **Negative lookbehind** (`(?<!...)`) to prevent specific sequences from
  preceding.
- **Anchors with negated patterns** to ensure certain patterns do not appear at
  the beginning or end of lines.

These techniques allow you to exclude patterns or characters effectively in
complex scenarios. Let me know if you need further clarifications!
