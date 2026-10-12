# Rick's memory

What Rick has done here, and what it taught him. Read at the start of a session, at the point
`.claude/rick/PROFILE.md` § 2 puts it in the read order.

**The line against the backlog.** `docs/backlog/` records *what changed in the repository* — dated,
append-only, one entry per change, with its proof. This file records *what Rick must always know* — the
work he has already done and the lessons that change a future decision. If it describes an artefact, the
detail belongs in the backlog. If it describes what to remember, it belongs here.

## Rules

- **After every finished task, update this file before handing back. Always, no exceptions.** Two
  things, and only these two:
  1. **A work record line.** One line, appended to `## Work record`. Names the task, what came out of
     it, and any dead end.
  2. **A lesson entry**, under `## Lessons`, only when the work taught something durable.
- A work record line is **one line**. One line means one line: no sub-bullets, no detail. The detail
  lives in that task's backlog entry.
- `dead end:` in a line marks something that was tried and failed. **Never try it again** unless a
  changed condition is named. This is the most valuable half of the record.
- Lessons are keyed by topic and **edited in place** when they change. Never a second entry for the same
  lesson — that is how this file would rot into a log.
- Every lesson carries its evidence: a `file:line`, or the exact command and its result. No evidence, no
  entry. No speculation.
- A lesson entry keeps its established shape: a `### <topic>` heading, then `**Lesson:**`, `**Why:**`,
  `**Evidence:**`, `**Applies when:**`.
- Sizes: the work record is **append-only** — one line per task, never pruned, because this file must
  always know what Rick has done. The bound sits on the lessons: under ten lines each, labels and
  evidence included, and the section under about twelve entries. Past that, merge or cut.
- Read this file at intake, before Phase 0 closes. Whoever starts the next session reads it first.
- Rick writes it. A sub-agent may propose a line or a lesson in its report; Rick decides.

## Work record

One line per finished task, oldest first:
`- YYYY-MM-DD · <task in a few words> · <what came out of it> · <dead end: what failed, if any>`

- 2026-10-07 · light style repair · repaired the theme's light style, moved every light colour out of this config into the theme, shipped the contrast audit · dead end: `guicursor` mode letter `l:` is illegal in nvim 0.11.5 (`E546`) — use the `Cursor/lCursor` pair instead
- 2026-10-07 · backlog tracker · added `docs/backlog/` with an index and one dated entry per delivered change
- 2026-10-07 · Rick · added the `/rick` skill, the profile, the helper agent entry and this memory file · dead end: `model: inherit` in agent frontmatter could not be verified in a live session, so the key is left out, which is the documented way to inherit the session model
- 2026-10-07 · memory rules · made the memory update mandatory after every finished task, with a one-line work record and dead ends that are never retried; an adversarial read, then Rick himself, confirmed a fresh reader can state every rule from source · dead end: granting the theme folder only inside the profile left the grant void, because the hard rules outrank the profile — the carve-out had to be written into `CLAUDE.md` itself
- 2026-10-07 · memory routing · made `docs/rick/memory.md` the only memory for this repo, in `CLAUDE.md` § Hard rules § Memory; the harness memory at `~/.claude/projects/` was never used and does not exist · dead end: the first pass put the rule in § Rick, where it read as a description of Rick rather than a rule for every session — the repo's own lesson *a permission must be written into the law* sent it to § Hard rules
- 2026-10-07 · startup speed · deferred telescope/fzf-lua/devicons to first use (killed the gi_telescope extension cascade), fixed mason's init-require, removed 8 dead files + duplicate BufWritePre + createdir, dropped the patches deferral · dead end: undotree's VimEnter cannot be removed — its config turns on undofile/undodir, so removal would silently disable persistent undo
- 2026-10-11 · nvim 0.12.6 + telescope repair · built v0.12.6 from source (tag 779c36969e, sha 02819703…) and installed; telescope keys restored with lazy `keys` placeholders + Snacks dedup; blink build guard fixed; avante's <0.12 gate (getchar + :quit) was the picker-typing blocker; text objects broken on 0.12 → treesitter master→main migration queued as the next task · dead end: the saved v0.11.5 binary alone cannot roll back — `make install` replaced the shared runtime, only a rebuild works
- 2026-10-11 · snacks notifier preload · reproduced the fast-event E5560 (notify on LSP exit loaded snacks.notifier in a fast context) and fixed it by preloading the module at setup; deterministic timer fail→pass pair in `docs/backlog/2026-10-11-snacks-notifier-preload.md`
- 2026-10-12 · avante mega deps · added ColinKennedy/mega.cmdparse + mega.logging to the avante spec (upstream README:211); after the 4f49656 update the plugin file died at its top-level `require("mega.cmdparse")` and lazy showed "Failed to source" on the first InsertEnter — the owner's screenshot
- 2026-10-12 · treesitter 0.12 directive fix · reproduced the decoration-provider crash (telescope markdown previews, 2/3 baseline runs) and re-registered master's six predicates/directives with the 0.12 list unwrap; 9/9 clean after; upstream nvim-treesitter#8636
- 2026-10-12 · glight faint indent guides · traced the solid dark bars to `SnacksIndent`, a group the theme never defined, so snacks lent it `NonText` = `#636c76` (5.33:1); the theme now owns it and glight uses `bg3` `#d0d7de` (1.45:1), the block bar went `#59636e` → `#afb8c1`, both as reasoned `KNOWN` entries; merged `feature/glight` into the theme `main` (`ce469ff`, pushed), restored the GitHub spec and let lazy fetch it · dead end: predicting the checker's `checked` tally would hold at 736 — `SnacksIndentScope` leaves the checked set when it enters `KNOWN`, so it reads 735

## Lessons

### A permission must be written into the law, not the profile

**Lesson:** A standing permission belongs in `CLAUDE.md` § Hard rules. The same words in the profile are
void, because the profile's own precedence line says the hard rules win.
**Why:** An agent that honours the profile's grant breaks the declared law; an agent that honours the law
must stop and ask every single time.
**Evidence:** 2026-10-07 — the theme-folder grant lived only in `.claude/rick/PROFILE.md` § 6; the same
round moved it into `CLAUDE.md` § Forbidden without asking first.
**Applies when:** granting or changing any permission.

### A live Neovim is not evidence

**Lesson:** Reproduce any runtime complaint in a fresh headless process before touching a file.
**Why:** A running session holds the config it started with; the theme and options reload only on a
restart or `:colorscheme`. A stale process and a real defect look identical from the outside.
**Evidence:** 2026-10-07 — the light-style repair was only trusted after
`nvim --headless "+messages" +qa 2>&1` printed nothing and `nvim_get_hl` returned the new values; the
live session had been showing the old ones. `WORKFLOWS.md` § Proof standards.
**Applies when:** any claim about colours, keymaps, options or plugin behaviour.

### Dark must not move when the job is light

**Lesson:** Dump every group's resolved value for every style before and after, and require the dark
styles to be byte-identical.
**Why:** Palette work goes through shared code paths. A light change that moves dark is a defect, not a
side effect.
**Evidence:** the method in `docs/backlog/2026-10-07-light-style-repair.md` § Proof — one headless dump
per style, diffed; the dark diff came out empty.
**Applies when:** any palette or highlight change in the theme.

### Colours belong to the theme, not the config

**Lesson:** Put colour values in the theme. This config only wires plugins up.
**Why:** The owner moved every light-mode colour into `githubG.nvim` on 2026-10-07 so a fix is made once.
**Evidence:** `docs/backlog/2026-10-07-light-style-repair.md` § What changed. One exception remains
config-owned: the bufferline palette in `lua/plugins/configs/gi_nvim_bufferline.lua`.
**Applies when:** any colour, highlight or light/dark branch.

### The cursor colour rule in a terminal

**Lesson:** A terminal takes the cursor colour from the cursor group's **background**. `reverse` with no
group name in `guicursor` means "use the host terminal's own cursor", and `guifg` is ignored there.
**Why:** That is exactly why the light theme's cursor was invisible: white on white, from the terminal's
own colours.
**Evidence:** nvim 0.11.5 `runtime/doc/options.txt:3053-3061`, quoted in
`docs/backlog/2026-10-07-light-style-repair.md`. The theme now sets `guicursor` in
`lua/onedark/init.lua`, gated by `set_guicursor`.
**Applies when:** any cursor complaint, in any mode.

### Run the contrast audit before and after a colour change

**Lesson:** The theme ships `scripts/check.lua`. Run it either side of an edit.
**Why:** It catches what the eye misses: text equal to its own background, backgrounds equal to the page,
and anything under 4.5:1.
**Evidence:** `nvim --clean --headless -i NONE --cmd "set rtp^=<theme>" -c "luafile <theme>/scripts/check.lua"`
→ `RESULT style=glight groups=712 checked=735 known=13 fails=0`. It audits `glight` only, so a clean run
does not vouch for dark. (Before 2026-10-12 the same line read `groups=711 checked=736 known=11`; the
tallys move whenever a group is added or enters `KNOWN`.)
**Applies when:** any palette or highlight edit.

### `KNOWN` in the theme's checker waives enforcement outright

**Lesson:** A group listed in `KNOWN` is not tested at all, in either direction. Making a guide fainter
there also stops the checker noticing if it later drifts *darker*.
**Why:** `KNOWN` prints the group with its measured ratio and skips the threshold test entirely
(`scripts/check.lua:95-99`). It is a visibility tool, not an assertion. Adding an entry is still the
right move when the value is a deliberate decoration and no threshold should move — but the waiver is
total, so say so when you use it.
**Evidence:** 2026-10-12 — `SnacksIndent` and `SnacksIndentScope` joined `KNOWN` at 1.45:1 and 2.01:1.
With the old `#59636e` put back, the entry still printed 6.11:1 and `fails` stayed 0. Removing both
entries makes it `fails=2`, which is the proof the checker is alive.
**Applies when:** reaching for `KNOWN` to quiet a contrast failure.

### `TEMP(T9)` is resolved — the theme comes from GitHub now

**Lesson:** The config loads the theme from `"ghasak/githubG.nvim"` at `main`. A local `dir =` override
must not come back.
**Why:** A local override serves unreviewed code and silently diverges from what GitHub has. The
2026-10-07 session kept it only until `feature/glight` reached `main`; that merge happened on
2026-10-12. To change the theme now: edit `main`, push, then let lazy fetch it.
**Evidence:** `lua/plugins/pluginsHub.lua:3`; `lazy-lock.json` pins `githubG.nvim` at `ce469ff`.
**Applies when:** editing the theme, or tidying plugin specs.

### Only the lazy clone is live, and it flipped

**Lesson:** The live theme is `~/.local/share/nvim/lazy/githubG.nvim`. The dev folder at
`~/Desktop/devCode/programmingLanguages/luaHub/githubG.nvim` is detached today — editing it changes
nothing in the editor, and a change pushed from it reaches the editor only after a lazy fetch.
**Why:** An edit in the wrong copy looks like a fix that did not work. The live copy **changed sides**
on 2026-10-12 when the spec went back to the GitHub URL — before that, the `dir =` folder was the live
one. Any note written before that date has it backwards.
**Evidence:** `lazy-lock.json` pins `githubG.nvim` `ce469ff` on `main`; the clone carries the same
commit.
**Applies when:** editing any theme file.

### `style = "light"` and `style = "dark"` are both broken on purpose

**Lesson:** `style = "light"` and `style = "dark"` crash on load. `glight` is the working light style
and `gdark` the working dark one; they are the pair on the `<leader>ub` toggle path. A per-style sweep
must skip `dark`.
**Why:** The missing keys are a tracked open item, not a mystery. A sweep that includes `dark` dies
with `colors.lua:5: expected table, got nil`, which reads as if your own change broke it.
**Evidence:** `lua/onedark/colors.lua:5` calls `tbl_extend` with nil; `palette.lua:205` has the `dark`
block commented out while `init.lua:3` still lists it; 58 keys are missing from `light`; the
follow-ups table in `docs/backlog/BACKLOG.md`.
**Applies when:** working on styling, or sweeping every style.

### Measure launch the way the editor is launched

**Lesson:** Headless `nvim --headless ... +qa` never fires VimEnter or UIEnter, so it measures only the config load. Measure the real launch in a pty (`TERM=xterm-256color script -q /dev/null nvim ...`) and count which plugins are loaded at settle.
**Why:** This pass read 39 ms headless against ~140-180 ms real; the whole startup burst was invisible to the short harness. Also: `+messages` replays verbose output and double-counts — count on the live stream.
**Evidence:** `docs/backlog/2026-10-07-startup-speed.md` § Proof; a tester's `verbose=12` count read 2 where the live stream read 1.
**Applies when:** any claim about startup time or load order.

### A `require` in a spec `init` loads the plugin

**Lesson:** lazy.nvim's require hook loads a plugin regardless of its declared event, and every spec `init` runs at startup. So `require(...)` inside `init`, and "checking" a plugin with `pcall(require, name)`, both force a startup load.
**Why:** It hid in plain sight — the telescope extension loader pulled the whole DAP stack into VimEnter via `pcall(require, "dap")`, and mason's `init` loaded mason at startup, both defeating their declared triggers.
**Evidence:** `gi_telescope.lua:269-282`; mason's spec `init` before commit 891db25; lazy `core/loader.lua:529-548`; tracer: 20 VimEnter-rooted requires before, 0 after.
**Applies when:** reading or writing any plugin spec; any "is this plugin installed?" check.

### Keymap and typing complaints are load-order complaints

**Lesson:** When a key "does not work" or typing is blocked in a prompt, check WHAT loads on the
trigger and WHO owns the key at that moment before touching the mapping itself.
**Why:** Both of the 2026-10-11 telescope symptoms had nothing to do with telescope's own mappings:
a plugin loaded by `InsertEnter` (avante) ate the keystroke and quit the window on nvim < 0.12, and
after 891db25 an eager plugin (Snacks) owned the startup keys while the lazy one registered later.
**Evidence:** `avante.nvim/plugin/avante.lua:1-9` (getchar + :quit) blocked the first picker; the
`ff` owner at startup was Snacks (`keymappings.lua:623`) because telescope's maps register only on
load (`gi_telescope.lua:255`); fixed with lazy `keys` placeholders (`pluginsHub.lua:136-143`) +
deleting the colliding eager maps.
**Applies when:** any "key does not work" or "cannot type" report.
