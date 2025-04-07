# Modern Permission and Ownership

In modern **Bash on macOS**, the most efficient and standardized ways to get
the **username, group, and file permissions** are:

### **1. Get the Current User's Name**

```bash
whoami
```

or

```bash
echo "$USER"
```

Both return the currently logged-in username.

---

### **2. Get the Group of the Current User**

```bash
id -gn
```

This prints the **primary group** of the current user.

To list **all groups** the user belongs to:

```bash
id -Gn
```

---

### **3. Get File Permissions in a Human-Readable Format**

#### **For a Specific File or Directory**

```bash
ls -l filename
```

Example output:

```
-rw-r--r--  1 user  staff  1234 Feb  5 10:00 filename
```

- **Permissions:** `-rw-r--r--`
- **Owner:** `user`
- **Group:** `staff`

To **extract just the permission string**:

```bash
stat -f "%Sp" filename
```

For example, it may return:

```
-rw-r--r--
```

To get both **owner and group**:

```bash
stat -f "%Su:%Sg" filename
```

Example output:

```
user:staff
```

---

### **4. Get Full File Metadata (Permissions, Owner, and Group)**

```bash
stat -f "%Sp %Su %Sg" filename
```

Example output:

```
-rw-r--r-- user staff
```

This is a **modern approach** on macOS compared to parsing `ls`.

---

### **5. Check if a User is in a Group**

```bash
groups "$USER" | grep -qw "admin" && echo "User is in admin group"
```

---

### **6. Get the UID and GID**

```bash
id -u  # Get User ID
id -g  # Get Group ID
```

---

### **Summary**

| Task                               | Modern Bash Command              |
| ---------------------------------- | -------------------------------- |
| Get current username               | `whoami` or `echo "$USER"`       |
| Get user's primary group           | `id -gn`                         |
| Get all groups of a user           | `id -Gn`                         |
| Get file permissions               | `stat -f "%Sp" filename`         |
| Get file owner                     | `stat -f "%Su" filename`         |
| Get file group                     | `stat -f "%Sg" filename`         |
| Get file permissions, owner, group | `stat -f "%Sp %Su %Sg" filename` |
| Get user ID                        | `id -u`                          |
| Get group ID                       | `id -g`                          |

These **`stat`-based** approaches are the most **modern, efficient, and portable** on macOS. 🚀

Yes! You can use `chown` with `id -u` and `id -g` to **recursively** apply ownership to all files and folders in a given directory.

### **Recursively Set Ownership for a Directory**

```bash
sudo chown -R "$(id -u):$(id -g)" /path/to/directory
```

- `$(id -u)` → Gets the **current user's UID**.
- `$(id -g)` → Gets the **current user's GID**.
- `-R` → Applies changes **recursively** to all subdirectories and files.

---

### **Example: Change Ownership of `/mydata`**

```bash
sudo chown -R "$(id -u):$(id -g)" /mydata
```

✅ Now, **all files and folders in `/mydata`** belong to the current user.

---

### **Using `chmod` to Apply Permissions Recursively**

After setting ownership, you may want to adjust **file and directory permissions**.

#### **Set Read/Write for User, Read for Group & Others**

```bash
chmod -R u=rwX,go=rX /path/to/directory
```

- `-R` → Recursively applies permissions.
- `u=rwX` → **User** gets **read/write** (and execute for directories).
- `go=rX` → **Group/Others** get **read-only** (execute for directories).

#### **Make Everything Readable but Only Directories Executable**

```bash
find /path/to/directory -type d -exec chmod 755 {} +
find /path/to/directory -type f -exec chmod 644 {} +
```

- `-type d` → **Directories** get `755` (rwxr-xr-x).
- `-type f` → **Files** get `644` (rw-r--r--).

---

### **Example: Fix Ownership & Permissions on a Project Folder**

```bash
sudo chown -R "$(id -u):$(id -g)" ~/myproject
chmod -R u=rwX,go=rX ~/myproject
```

This ensures:
✅ The user owns everything.
✅ Files are **read/write** for the owner, **read-only** for others.
✅ Directories are **executable** (so you can `cd` into them).

---

### **Best Practices**

- Always use `sudo` if modifying system directories.
- Run `ls -l` before and after to verify changes.
- Use `find` when applying permissions selectively.

Now you have **full recursive control** over ownership and permissions! 🚀
