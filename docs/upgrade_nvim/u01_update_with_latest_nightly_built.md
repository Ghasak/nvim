# How to update Nvim

## My Note

1. Use

```sh
git fetch --all --tags
```

2. build from scratch

```sh
   make distclean
   make CMAKE_BUILD_TYPE=Release
   sudo make install
```
3. Ensure the simlink for your sytem

```sh
ln -s ~/dev/neovim/build/bin/nvim  /usr/local/bin/
```
### Steps to Recover and Pull the Latest Stable Tag for Neovim

It looks like your attempt to update Neovim from GitHub encountered a **rebase
issue** with skipped commits and merge conflicts. Below is the best way to
**recover, pull all updates**, and **check out the latest stable tag**:

---

### **Step 1: Abort the Rebase (If Needed)**

Since you have encountered conflicts during a rebase, **abort the rebase** to prevent further issues:

```sh
git rebase --abort
```

This restores your working directory to the state before the rebase attempt.

---

### **Step 2: Ensure Your Local Branch is Clean**

Check if there are uncommitted changes:

```sh
git status
```

If there are uncommitted changes, either **stash** them or **commit** them before proceeding:

```sh
git stash
```

or

```sh
git add . && git commit -m "Save changes before sync"
```

---

### **Step 3: Fetch All Updates from the Remote Repository**

Pull the latest changes without applying them yet:

```sh
git fetch --all --tags
```

This updates your local knowledge of the remote repository.

---

### **Step 4: Reset to the Latest Remote Master (If You Want a Fresh Sync)**

If you want to **reset your branch to match the upstream master** (losing local commits):

```sh
git reset --hard origin/master
```

If you prefer **preserving your local commits** while updating, you can use:

```sh
git pull --rebase origin master
```

If you still encounter skipped commits, you can try forcing cherry-picks to reapply:

```sh
git rebase --reapply-cherry-picks
```

---

### **Step 5: Identify the Latest Stable Tag**

Find the latest stable tag:

```sh
git tag --sort=version:refname | grep '^v'
```

The highest version number is the latest stable tag.

Alternatively, fetch the latest release from GitHub using:

```sh
git describe --tags --abbrev=0
```

or

```sh
git ls-remote --tags origin | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' | sort -V | tail -n 1
```

---

### **Step 6: Checkout the Latest Stable Release**

Once you identify the latest stable tag, check it out:

```sh
git checkout <latest_stable_tag>
```

For example, if the latest stable tag is `v0.9.5`, run:

```sh
git checkout v0.9.5
```

If you also want to reset your branch to track the latest stable release:

```sh
git reset --hard v0.9.5
```

---

### **Step 7: Optional - Rebuild Neovim (If Needed)**

If you're working with a source build, after checking out the stable version, you may need to **rebuild Neovim**:

```sh
make distclean
make CMAKE_BUILD_TYPE=Release
sudo make install
```

---

### **Final Notes**

- **If you need to keep your local changes**, use `git stash` before pulling updates and `git stash pop` after.
- **Use `git log --oneline` to verify commits** and `git status` frequently.
- If a merge conflict happens, manually resolve it, run `git add <conflicted_file>`, and continue the rebase:
  ```sh
  git rebase --continue
  ```

Now, your Neovim repository should be **clean, up to date, and on the latest stable version**. 🚀

Great! It looks like you successfully checked out `NVIM 0.10.4`, which is the latest stable version at the moment. 🎉

### **Final Steps (Optional)**

1. **Verify the Checkout**

   ```sh
   git status
   ```

   It should confirm that you are on `HEAD detached at NVIM 0.10.4`.

2. **List All Tags (Optional)**
   If you want to see all available tags and confirm you are on the latest stable one:

   ```sh
   git tag --sort=version:refname
   ```

3. **Build Neovim (If Compiling from Source)**
   If you're using a **source-based installation**, rebuild Neovim:

   ```sh
   make distclean
   make CMAKE_BUILD_TYPE=Release
   sudo make install
   ```

4. **Run Neovim and Verify**
   ```sh
   nvim --version
   ```
   This should output something like:
   ```
   NVIM v0.10.4
   ...
   ```

If everything looks good, you're **now on the latest stable Neovim release!** 🚀🎉
