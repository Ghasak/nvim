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
→ `RESULT style=glight groups=711 checked=736 known=11 fails=0`. It audits `glight` only, so a clean run
does not vouch for dark.
**Applies when:** any palette or highlight edit.

### `TEMP(T9)` means look before you clean

**Lesson:** The commented `"ghasak/githubG.nvim"` spec at `lua/plugins/pluginsHub.lua:3-4` must stay
commented until the theme's `feature/glight` is merged into its `main`.
**Why:** The config loads the theme from the local `dir =` path, which has the repair. The published
`main` is older, so restoring the spec would silently bring the old colours back.
**Evidence:** the open follow-ups table in `docs/backlog/BACKLOG.md`.
**Applies when:** tidying plugin specs.

### Two copies of the theme exist

**Lesson:** Only the `dir =` folder is live. `~/.local/share/nvim/lazy/githubG.nvim` is a stale, detached
copy, and editing it changes nothing.
**Why:** An edit in the wrong copy looks like a fix that did not work.
**Evidence:** `lazy-lock.json` pins `d0c0893` on `main` while the live tree is `feature/glight` at
`209ab19`.
**Applies when:** editing any theme file.

### `style = "light"` is broken on purpose

**Lesson:** `style = "light"` crashes on load because 58 palette keys are missing. `glight` is the
working light style. Never "fix" it by reverting the palette.
**Why:** The missing keys are a tracked open item, not a mystery.
**Evidence:** `lua/onedark/colors.lua:5` calls `tbl_extend` with nil; the follow-ups table in
`docs/backlog/BACKLOG.md`.
**Applies when:** working on light styling.

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
