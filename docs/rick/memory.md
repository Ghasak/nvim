# Rick's memory

Durable lessons learned while working on this config. Read at the start of a session, right after
`CLAUDE.md`, `WORKFLOWS.md` and `.claude/rick/PROFILE.md`.

**The line against the backlog.** `docs/backlog/` records *what changed in the repository* — dated,
append-only, with its proof. This file records *what must not be forgotten when working here* — the
lesson that changes a future decision. If it describes an artefact, it belongs in the backlog. If it
describes how to behave, it belongs here. Open items and their status never appear here.

**Rules**

- One entry per lesson, keyed by topic. Edit the entry in place when the lesson changes. Never add a
  second entry for the same lesson — that is how this file would become a second log.
- Every entry: **Lesson**, **Why**, **Evidence** (`file:line`, or the exact command and its result),
  **Applies when**.
- No entry without evidence. No speculation. Nothing about unfinished work — point at the backlog entry.
- Whole file stays under about 120 lines, one entry under six lines of prose. Past that it is a log:
  merge or cut.
- Written after a fix, a troubleshooting session, or a re-instruction round that taught something
  durable — and only then. Rick writes it; a sub-agent may propose an entry in its report.

---

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
