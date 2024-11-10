# Formatting JSON file in place

You can use `jq` (which is a powerful tool for formatting JSON) inside Neovim
to format the JSON string in your buffer.

### Steps:

1. **Install `jq`** (if not already installed):

   - On Ubuntu or Debian-based systems:
     ```bash
     sudo apt-get install jq
     ```
   - On macOS:
     ```bash
     brew install jq
     ```

2. **Format the JSON string in Neovim**:
   If you're already in Neovim and have a buffer that contains your JSON
   string, you can use the following command to pipe the content through `jq`:

   - **Command to format the entire buffer:**
     ```vim
     :%!jq .
     ```

   Explanation:

   - `:%` refers to the entire buffer.
   - `!jq .` pipes the entire buffer through the `jq` command, which formats it.

3. **If you want to format a selection of JSON**:
   - First, visually select the part of the buffer containing the JSON using visual mode (`v` or `V`).
   - Then run the following command to format just the selected portion:
     ```vim
     :!jq .
     ```

### Example:

Original JSON (in a single line):

- This was as a single line in the `.jsonl` file

```json
{
  "level": "INFO",
  "message": "[INFO] this is just a test ",
  "timestamp": "2024-10-16T07:30:41.868284+00:00",
  "logger": "src.logging.L04_json_formatter_class",
  "module": "L04_json_formatter_class",
  "function": "testing_loading_config",
  "line": 19,
  "thread_name": "MainThread"
}
```

Formatted JSON after running `:%!jq .`:

```json
{
  "level": "INFO",
  "message": "[INFO] this is just a test ",
  "timestamp": "2024-10-16T07:30:41.868284+00:00",
  "logger": "src.logging.L04_json_formatter_class",
  "module": "L04_json_formatter_class",
  "function": "testing_loading_config",
  "line": 19,
  "thread_name": "MainThread"
}
```

This should give you a cleaner and more readable output in your buffer.
