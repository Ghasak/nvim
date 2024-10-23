# **Everything You Need to Know About Macros in Neovim (Nvim)**

## Intro.

Macros in Neovim are powerful tools to automate repetitive tasks by recording
and replaying a sequence of commands. Below is a detailed guide to working with
macros, including how to **record, edit, replay, and use them with the `:norm`
command**.

---

## **1. Recording a Macro**

To record a macro:

1. **Enter Normal Mode**.
2. Press `q` followed by a **register name** (any letter a-z) to start recording. For example:
   ```vim
   qa
   ```
   This starts recording into register `a`.
3. **Perform your commands** (movement, insert, delete, etc.).
4. Press `q` again to stop recording.

---

## **2. Replaying a Macro**

To replay a recorded macro:

- **Replay once**:

  ```vim
  @a
  ```

  This replays the macro recorded in register `a`.

- **Replay multiple times**:
  ```vim
  10@a
  ```
  This replays the macro 10 times.

---

## **3. Viewing a Macro’s Contents**

To see what commands are stored in a macro, you can use:

```vim
:reg a
```

This shows the content of register `a`.

---

## **4. Editing a Macro**

There’s no direct way to edit a macro in Nvim, but you can modify it through the following steps:

### **Step-by-Step Editing Method**

1. **View the Macro**:

   ```vim
   :reg a
   ```

   For example, if the output is:

   ```
   a   iHello<Esc>oWorld<Esc>
   ```

   This means the macro inserts "Hello", presses `Esc`, and then adds "World" on the next line.

2. **Yank the Macro to a Buffer**:
   In Normal Mode:

   ```vim
   "ap
   ```

   This pastes the content of register `a` into the buffer.

3. **Edit the Commands**:
   Modify the commands in the buffer as needed (like editing text).

4. **Yank the Modified Macro**:
   In Visual Mode, select the edited commands and use:

   ```vim
   "ayy
   ```

   This yanks the modified macro back into register `a`.

5. **Test the Edited Macro**:
   Replay it with `@a` to ensure it works.

---

## **5. Applying Macros with the `:norm` Command**

The `:norm` (short for `:normal`) command allows you to apply commands or macros to multiple lines.

### **Syntax**

```vim
:norm @a
```

This applies the macro stored in register `a` to the current line.

### **Apply Macro to Multiple Lines (Range)**

```vim
:1,10norm @a
```

This applies the macro on lines 1 to 10.

### **Example: Add a Semicolon to Every Line**

1. Record a macro:

   ```
   qasA;<Esc>q
   ```

   This appends a semicolon at the end of a line.

2. Apply it to all lines in the buffer:
   ```vim
   :%norm @a
   ```
   The `%` symbol applies the command to all lines.

---

## **6. Advanced Examples**

### **Example 1: Delete the First Word on Every Line**

1. Record the macro:

   ```vim
   qadwq
   ```

   This deletes the first word.

2. Apply it to lines 5 through 15:
   ```vim
   :5,15norm @a
   ```

### **Example 2: Surround Text in Parentheses for Every Line**

1. Record the macro:

   ```vim
   qayi(<Esc>A)<Esc>q
   ```

   This surrounds the line with parentheses.

2. Apply it to all lines:
   ```vim
   :%norm @a
   ```

---

## **7. Summary Table**

| **Action**                      | **Command**                      | **Explanation**                                |
| ------------------------------- | -------------------------------- | ---------------------------------------------- |
| Start recording a macro         | `q<register>`                    | Start recording into the given register (a-z). |
| Stop recording                  | `q`                              | Stops the current macro recording.             |
| Replay a macro                  | `@<register>`                    | Replays the macro stored in the register.      |
| Replay macro multiple times     | `n@<register>`                   | Replays the macro `n` times.                   |
| View macro contents             | `:reg <register>`                | Shows the commands stored in the register.     |
| Yank macro to buffer            | `"ap`                            | Pastes the macro content into the buffer.      |
| Edit macro                      | Modify and yank back with `"ayy` | Allows indirect editing of the macro.          |
| Apply macro with `:norm`        | `:norm @<register>`              | Applies the macro to the current line.         |
| Apply macro to a range of lines | `:1,10norm @<register>`          | Runs the macro on lines 1 to 10.               |
| Apply macro to entire buffer    | `:%norm @<register>`             | Runs the macro on every line in the buffer.    |

---

### **Tips and Best Practices**

- Use **capital letters** (like `QA`) to record macros temporarily since
  lowercase registers might store useful data you don't want to overwrite.
- Save complex macros in **external files** to reuse them across sessions.
- Practice using **small, modular macros** to avoid errors. This makes editing
  them easier when needed.
- Use **`@:`** to replay the last executed `:` command. This is useful when
  tweaking macros with `:norm`.

Let me know if you need further clarification or more examples!
