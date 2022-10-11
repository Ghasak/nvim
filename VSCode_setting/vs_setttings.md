   {
  "window.closeWhenEmpty": false,
  "window.openFilesInNewWindow": "off",
  "window.title": "${activeEditorShort}${separator}${rootName}",
  // YouTube recordings.
  "screencastMode.fontSize": 24,
  "screencastMode.keyboardOverlayTimeout": 500,
  "screencastMode.verticalOffset": 4,
  // =========================================================
  //                  Workbench Setting
  // =========================================================
  "workbench.editor.enablePreview": true,
  "workbench.settings.editor": "json",
  // This will allow you to change from ui setting showing to .json format
  "workbench.settings.openDefaultSettings": false,
  "workbench.settings.useSplitJSON": false,
  "workbench.iconTheme": "ayu",
  "workbench.colorCustomizations": {
    "editor.background": "#343a43",
    "banner.background": "#343a43",
    "sideBar.background": "#343a43",
    "activityBar.background": "#343a43", //this for the icon side bar
    "activityBar.border": "#343a43",
    "activityBar.dropBorder": "#ff0000",
    "terminal.background": "#343a43",
    "terminal.dropBackground": "#ff0000",
    "terminal.selectionBackground": "#ff0000",
    "statusBar.noFolderBackground": "#514b4e",
    "statusBar.debuggingBackground": "#484346",
    "statusBar.debuggingForeground": "#FEEFDD",
    "editorRuler.foreground": "#737575",
    "tab.activeBackground": "#201E1F",
    "tab.activeForeground": "#d08608"
  },

  "workbench.editor.showTabs": true,
  "workbench.statusBar.visible": true,
  "workbench.editor.enablePreviewFromQuickOpen": false,

  // Use vim hjkl to navigate folders.
  "workbench.list.keyboardNavigation": "simple",
  "workbench.list.automaticKeyboardNavigation": false,
  "workbench.activityBar.visible": true,
  // =========================================================
  //                  Editor Setting
  // =========================================================
  "editor.formatOnSave": true, // Once you Save the file will be auto-formatted.
  "editor.formatOnPaste": false,
  "editor.emptySelectionClipboard": false,
  "editor.dragAndDrop": true,
  "editor.selectionHighlight": true,
  "editor.overviewRulerBorder": true,
  "editor.scrollBeyondLastLine": false,
  "editor.mouseWheelScrollSensitivity": 5,
  "editor.wordWrap": "on",
  "editor.multiCursorModifier": "ctrlCmd",
  "editor.snippetSuggestions": "top",
  "editor.hover.delay": 0,
  "editor.fontSize": 14,
  "editor.fontWeight": "400",
  "editor.lineHeight": 20,
  "editor.fontFamily": "SFMono Nerd Font", // "VictorMono Nerd Font",
  "editor.letterSpacing": -0.4,
  "editor.inlineSuggest.enabled": true,
  // VS Code automatically highlights selected words.
  // "vim.hlsearch": false,
  "editor.codeLens": true,
  // "editor.cursorStyle": "block",
  "editor.cursorBlinking": "solid",
  "editor.cursorSmoothCaretAnimation": true,
  "editor.lineNumbers": "on",
  "editor.folding": false,
  "editor.glyphMargin": false,
  "editor.insertSpaces": false,
  "editor.hover.enabled": true,
  "editor.fontLigatures": true,
  "editor.minimap.enabled": true,
  "editor.renderWhitespace": "none",
  "editor.renderControlCharacters": false,
  "editor.suggestSelection": "first",
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.wordSeparators": "/\\()\"':,.;<>~!@#$%^&*|+=[]{}`?-",
  "editor.rulers": [120], //[100, 120]
  "editor.autoClosingBrackets": "always",
  "[python]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.python"
  },
  "[javascript]": {
    "editor.autoClosingBrackets": "always",
    "editor.tabSize": 4,
    "editor.formatOnSave": true
  },
  "notebook.cellToolbarLocation": {
    "default": "right",
    "jupyter-notebook": "left"
  },
  // =========================================================
  //                  Debugger Setting
  // =========================================================
  "debug.console.fontFamily": "SFMono Nerd Font", //"VictorMono Nerd Font", //"Roboto Mono Light for Powerline", //"Source Code Pro",
  "debug.console.fontSize": 20,

  // =========================================================
  //                  Git Setting
  // =========================================================

  "git.ignoreLegacyWarning": true,
  "notebook.lineNumbers": "on",
  "bracket-pair-colorizer-2.depreciation-notice": false,
  "bracketPairColorizer.depreciation-notice": false,
  "github.copilot.enable": {
    "*": true,
    "yaml": false,
    "plaintext": false,
    "markdown": false,
    "code-runner-output": false
  },

  // =========================================================
  //                  Terminal setting
  // =========================================================
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontFamily": "SFMono Nerd Font", // "VictorMono Nerd Font Hack Nerd Font",//"Roboto Mono Light for Powerline", //"Source Code Pro",
  "terminal.integrated.fontWeight": "400",
  "terminal.integrated.lineHeight": 0.1,
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.integrated.copyOnSelection": true,
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.fontWeightBold": "normal",
  "terminal.integrated.drawBoldTextInBrightColors": false,
  "terminal.integrated.tabs.enabled": false,
  "terminal.explorerKind": "external",
  // =========================================================
  //                  File Explorer Setting
  // =========================================================
  "files.autoSave": "afterDelay",
  "files.trimTrailingWhitespace": true,
  "files.exclude": {
    // "**/node_modules": true,
    "**/package-lock.json": true,
    // Hide js files after running tsc.
    "**/*.js": { "when": "$(basename).ts" }
  },
  "breadcrumbs.enabled": true,
  "tabnine.experimentalAutoImports": true,
  "explorer.compactFolders": false,
  "zenMode.hideTabs": false,
  "zenMode.hideLineNumbers": false,
  "search.searchOnType": false,
  "typescript.updateImportsOnFileMove.enabled": "always",
  "vsintellicode.modify.editor.suggestSelection": "choseToUpdateConfiguration",
  // =========================================================
  //                  Code Runner Setting
  // =========================================================
  // Code Runner -User Setting {Ghasak}
  "code-runner.executorMap": {
    "javascript": "node",
    "python": "$pythonPath -u $fullFileName", //"python": "python",
    "perl": "perl",
    "go": "go run",
    "c": "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt"
  },
  "code-runner.clearPreviousOutput": true,
  "code-runner.saveFileBeforeRun": true,
  "code-runner.runInTerminal": true,
  // Python Specific Features - Setting {Ghasak}
  // This will make your command output clean and print only the things that you want
  "code-runner.showExecutionMessage": true,

  // to remove the cursive font for the comments
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": [
          "comment",
          "punctuation.definition.comment",
          "comment",
          "comment.block",
          "comment.block.documentation",
          "comment.line",
          "constant",
          "constant.character",
          "constant.character.escape",
          "constant.numeric",
          "constant.numeric.integer",
          "constant.numeric.float",
          "constant.numeric.hex",
          "constant.numeric.octal",
          "constant.other",
          "constant.regexp",
          "constant.rgb-value",
          "emphasis",
          "entity",
          "entity.name",
          "entity.name.class",
          "entity.name.function",
          "entity.name.method",
          "entity.name.section",
          "entity.name.selector",
          "entity.name.tag",
          "entity.name.type",
          "entity.other",
          "entity.other.attribute-name",
          "entity.other.inherited-class",
          "invalid",
          "invalid.deprecated",
          "invalid.illegal",
          "keyword",
          "keyword.control",
          "keyword.operator",
          "keyword.operator.new",
          "keyword.operator.assignment",
          "keyword.operator.arithmetic",
          "keyword.operator.logical",
          "keyword.other",
          "markup",
          "markup.bold",
          "markup.changed",
          "markup.deleted",
          "markup.heading",
          "markup.inline.raw",
          "markup.inserted",
          "markup.italic",
          "markup.list",
          "markup.list.numbered",
          "markup.list.unnumbered",
          "markup.other",
          "markup.quote",
          "markup.raw",
          "markup.underline",
          "markup.underline.link",
          "meta",
          "meta.block",
          "meta.cast",
          "meta.class",
          "meta.function",
          "meta.function-call",
          "meta.preprocessor",
          "meta.return-type",
          "meta.selector",
          "meta.tag",
          "meta.type.annotation",
          "meta.type",
          "punctuation.definition.string.begin",
          "punctuation.definition.string.end",
          "punctuation.separator",
          "punctuation.separator.continuation",
          "punctuation.terminator",
          "storage",
          "storage.modifier",
          "storage.type",
          "string",
          "string.interpolated",
          "string.other",
          "string.quoted",
          "string.quoted.double",
          "string.quoted.other",
          "string.quoted.single",
          "string.quoted.triple",
          "string.regexp",
          "string.unquoted",
          "strong",
          "support",
          "support.class",
          "support.constant",
          "support.function",
          "support.other",
          "support.type",
          "support.type.property-name",
          "support.variable",
          "variable",
          "variable.language",
          "variable.name",
          "variable.other",
          "variable.other.readwrite",
          "variable.parameter",
          "source.dart"
        ],
        "settings": {
          "fontStyle": ""
        }
      }
    ]
  },

  // ===================================================
  //                   Shell Settings
  // ===================================================
  // ShellCheck (linter for bash scripting)
  "shellcheck.ignoreFileSchemes": ["git", "gitfs"],
  "shellcheck.enable": true,
  "shellcheck.enableQuickFix": true,
  "shellcheck.run": "onType", // Priority: user defined > bundled shellcheck binary > "shellcheck"
  "shellcheck.exclude": [],
  "shellcheck.customArgs": [],
  "shellcheck.ignorePatterns": {
    "**/*.zsh": true,
    "**/*.zshrc": true,
    "**/zshrc": true,
    "**/*.zprofile": true,
    "**/zprofile": true,
    "**/*.zlogin": true,
    "**/zlogin": true,
    "**/*.zlogout": true,
    "**/zlogout": true,
    "**/*.zshenv": true,
    "**/zshenv": true,
    "**/*.zsh-theme": true
  },

  // ===================================================
  //              language Server Setting
  // ===================================================
  // define R language path for langauge server
  "r.interpreterPath": "/usr/local/bin/R",
  //"python.defaultInterpreterPath": "/home/python39/python"
  "python.defaultInterpreterPath": "/home/opt/anaconda3/bin/python",
  // ===================================================
  //                   VIM Settings
  // You here use the extension (VSCodeVim)
  // https://github.com/VSCodeVim/Vim
  // ===================================================
  // "vim.timeout": 250,
  // "vim.useSystemClipboard": true,
  // "vim.easymotion": true,
  // "vim.incsearch": true,
  // "vim.useCtrlKeys": true,
  // "vim.hlsearch": false,
  // "vim.insertModeKeyBindings": [
  //   {
  //     "before": ["j", "j"],
  //     "after": ["<Esc>"]
  //   }
  // ],
  // "vim.normalModeKeyBindingsNonRecursive": [
  //   {
  //     "before": ["<leader>", "d"],
  //     "after": ["d", "d"]
  //   },
  //   {
  //     "before": ["<C-n>"],
  //     "commands": [":nohl"]
  //   },
  //   {
  //     "before": ["K"],
  //     "commands": ["lineBreakInsert"],
  //     "silent": true
  //   }
  // ],
  // "vim.leader": "<space>",
  // "vim.handleKeys": {
  //   "<C-a>": false,
  //   "<C-f>": false
  // },

  // "vim.normalModeKeyBindings": [
  //   {
  //     "before": ["v", "n"],
  //     "after": ["v", "g", "_", "y"]
  //   },
  //   {
  //     "before": ["d", "n"],
  //     "after": ["d", "g", "_"]
  //   }
  // ],
  // // vim mode viwy viwcmd+d p issue hack
  // "vim.visualModeKeyBindingsNonRecursive": [
  //   {
  //     "before": ["p"],
  //     "commands": ["editor.action.clipboardPasteAction"]
  //   }
  // ],

  // // ----------- Enable nvim inside the VSCodeVim extension -------
  // "vim.enableNeovim": true,
  // //"vim.neovimPath": "/usr/local/bin/nvim",
  // "vim.neovimUseConfigFile": true
  // //"vim.neovimConfigPath": "$HOME/.config/nvim/VSCode_setting/init.vim",
  // // "vim.statusBarColorControl": true,
  // // "vim.statusBarColors.normal": ["#201E1F", "#FEEFDD"],
  // // "vim.statusBarColors.insert": ["#BF616A", "#201E1F"],
  // // "vim.statusBarColors.visual": "#B48EAD",
  // // "vim.statusBarColors.visualline": "#B48EAD",
  // // "vim.statusBarColors.visualblock": "#A3BE8C",
  // // "vim.statusBarColors.replace": "#D08770",
  // // "vim.statusBarColors.commandlineinprogress": "#007ACC",
  // // "vim.statusBarColors.searchinprogressmode": "#007ACC",
  // // "vim.statusBarColors.easymotionmode": "#007ACC",
  // // "vim.statusBarColors.easymotioninputmode": "#007ACC",
  // // "vim.statusBarColors.surroundinputmode": "#007ACC"

  // ===================================================
  //                   NVIM Settings
  // You here use the extension (vscode-neovim)
  //https://github.com/vscode-neovim/vscode-neovim
  // ===================================================
  "vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
  "vscode-neovim.neovimInitVimPaths.darwin": "$HOME/.config/nvim/VSCode_setting/init.vim",

  //================================
  // My VIM-KEYBINDING CONFIGURATION
  //================================

  "whichkey.sortOrder": "alphabetically",

  "whichkey.bindings": [
    {
      "key": ";",
      "name": "commands",
      "type": "command",
      "command": "workbench.action.showCommands"
    },
    {
      "key": "/",
      "name": "comment",
      "type": "command",
      "command": "vscode-neovim.send",
      "args": "<C-/>"
    },
    {
      "key": "?",
      "name": "View All References",
      "type": "command",
      "command": "references-view.find",
      "when": "editorHasReferenceProvider"
    },
    {
      "key": "b",
      "name": "Buffers/Editors...",
      "type": "bindings",
      "bindings": [
        {
          "key": "b",
          "name": "Show all buffers/editors",
          "type": "command",
          "command": "workbench.action.showAllEditors"
        },
        {
          "key": "d",
          "name": "Close active editor",
          "type": "command",
          "command": "workbench.action.closeActiveEditor"
        },
        {
          "key": "h",
          "name": "Move editor into left group",
          "type": "command",
          "command": "workbench.action.moveEditorToLeftGroup"
        },
        {
          "key": "j",
          "name": "Move editor into below group",
          "type": "command",
          "command": "workbench.action.moveEditorToBelowGroup"
        },
        {
          "key": "k",
          "name": "Move editor into above group",
          "type": "command",
          "command": "workbench.action.moveEditorToAboveGroup"
        },
        {
          "key": "l",
          "name": "Move editor into right group",
          "type": "command",
          "command": "workbench.action.moveEditorToRightGroup"
        },
        {
          "key": "m",
          "name": "Close other editors",
          "type": "command",
          "command": "workbench.action.closeOtherEditors"
        },
        {
          "key": "n",
          "name": "Next editor",
          "type": "command",
          "command": "workbench.action.nextEditor"
        },
        {
          "key": "p",
          "name": "Previous editor",
          "type": "command",
          "command": "workbench.action.previousEditor"
        },
        {
          "key": "N",
          "name": "New untitled editor",
          "type": "command",
          "command": "workbench.action.files.newUntitledFile"
        },
        {
          "key": "u",
          "name": "Reopen closed editor",
          "type": "command",
          "command": "workbench.action.reopenClosedEditor"
        },
        {
          "key": "y",
          "name": "Copy buffer to clipboard",
          "type": "commands",
          "commands": [
            "editor.action.selectAll",
            "editor.action.clipboardCopyAction",
            "cancelSelection"
          ]
        }
      ]
    },
    {
      "key": "d",
      "name": "Debug...",
      "type": "bindings",
      "bindings": [
        {
          "key": "d",
          "name": "Start debug",
          "type": "command",
          "command": "workbench.action.debug.start"
        },
        {
          "key": "S",
          "name": "Stop debug",
          "type": "command",
          "command": "workbench.action.debug.stop"
        },
        {
          "key": "c",
          "name": "Continue debug",
          "type": "command",
          "command": "workbench.action.debug.continue"
        },
        {
          "key": "p",
          "name": "Pause debug",
          "type": "command",
          "command": "workbench.action.debug.pause"
        },
        {
          "key": "r",
          "name": "Run without debugging",
          "type": "command",
          "command": "workbench.action.debug.run"
        },
        {
          "key": "R",
          "name": "Restart ebug",
          "type": "command",
          "command": "workbench.action.debug.restart"
        },
        {
          "key": "i",
          "name": "Step into",
          "type": "command",
          "command": "workbench.action.debug.stepInto"
        },
        {
          "key": "s",
          "name": "Step over",
          "type": "command",
          "command": "workbench.action.debug.stepOver"
        },
        {
          "key": "o",
          "name": "Step out",
          "type": "command",
          "command": "workbench.action.debug.stepOut"
        },
        {
          "key": "b",
          "name": "Toggle breakpoint",
          "type": "command",
          "command": "editor.debug.action.toggleBreakpoint"
        },
        {
          "key": "B",
          "name": "Toggle inline breakpoint",
          "type": "command",
          "command": "editor.debug.action.toggleInlineBreakpoint"
        },
        {
          "key": "j",
          "name": "Jump to cursor",
          "type": "command",
          "command": "debug.jumpToCursor"
        },
        {
          "key": "v",
          "name": "REPL",
          "type": "command",
          "command": "workbench.debug.action.toggleRepl"
        },
        {
          "key": "w",
          "name": "Focus on watch window",
          "type": "command",
          "command": "workbench.debug.action.focusWatchView"
        },
        {
          "key": "W",
          "name": "Add to watch",
          "type": "command",
          "command": "editor.debug.action.selectionToWatch"
        }
      ]
    },
    {
      "key": "e",
      "name": "Toggle Explorer",
      "type": "command",
      "command": "workbench.action.toggleSidebarVisibility"
    },
    {
      "key": "f",
      "name": "Find & Replace...",
      "type": "bindings",
      "bindings": [
        {
          "key": "f",
          "name": "File",
          "type": "command",
          "command": "editor.action.startFindReplaceAction"
        },
        {
          "key": "s",
          "name": "Symbol",
          "type": "command",
          "command": "editor.action.rename",
          "when": "editorHasRenameProvider && editorTextFocus && !editorReadonly"
        },
        {
          "key": "p",
          "name": "Project",
          "type": "command",
          "command": "workbench.action.replaceInFiles"
        }
      ]
    },
    {
      "key": "g",
      "name": "Git...",
      "type": "bindings",
      "bindings": [
        {
          "key": "/",
          "name": "Search Commits",
          "command": "gitlens.showCommitSearch",
          "type": "command",
          "when": "gitlens:enabled && config.gitlens.keymap == 'alternate'"
        },
        {
          "key": "a",
          "name": "Stage",
          "type": "command",
          "command": "git.stage"
        },
        {
          "key": "b",
          "name": "Checkout",
          "type": "command",
          "command": "git.checkout"
        },
        {
          "key": "B",
          "name": "Browse",
          "type": "command",
          "command": "gitlens.openFileInRemote"
        },
        {
          "key": "c",
          "name": "Commit",
          "type": "command",
          "command": "git.commit"
        },
        {
          "key": "C",
          "name": "Cherry Pick",
          "type": "command",
          "command": "gitlens.views.cherryPick"
        },
        {
          "key": "d",
          "name": "Delete Branch",
          "type": "command",
          "command": "git.deleteBranch"
        },
        {
          "key": "f",
          "name": "Fetch",
          "type": "command",
          "command": "git.fetch"
        },
        {
          "key": "F",
          "name": "Pull From",
          "type": "command",
          "command": "git.pullFrom"
        },
        {
          "key": "g",
          "name": "Graph",
          "type": "command",
          "command": "git-graph.view"
        },
        {
          "key": "h",
          "name": "Heatmap",
          "type": "command",
          "command": "gitlens.toggleFileHeatmap"
        },
        {
          "key": "H",
          "name": "History",
          "type": "command",
          "command": "git.viewFileHistory"
        },
        {
          "key": "i",
          "name": "Init",
          "type": "command",
          "command": "git.init"
        },
        {
          "key": "j",
          "name": "Next Change",
          "type": "command",
          "command": "workbench.action.editor.nextChange"
        },
        {
          "key": "k",
          "name": "Previous Change",
          "type": "command",
          "command": "workbench.action.editor.previousChange"
        },
        {
          "key": "l",
          "name": "Toggle Line Blame",
          "type": "command",
          "command": "gitlens.toggleLineBlame",
          "when": "editorTextFocus && gitlens:canToggleCodeLens && gitlens:enabled && config.gitlens.keymap == 'alternate'"
        },
        {
          "key": "L",
          "name": "Toggle GitLens",
          "type": "command",
          "command": "gitlens.toggleCodeLens",
          "when": "editorTextFocus && gitlens:canToggleCodeLens && gitlens:enabled && config.gitlens.keymap == 'alternate'"
        },
        {
          "key": "m",
          "name": "Merge",
          "type": "command",
          "command": "git.merge"
        },
        {
          "key": "p",
          "name": "Push",
          "type": "command",
          "command": "git.push"
        },
        {
          "key": "P",
          "name": "Push",
          "type": "command",
          "command": "git.pull"
        },
        {
          "key": "s",
          "name": "Stash",
          "type": "command",
          "command": "workbench.view.scm"
        },
        {
          "key": "S",
          "name": "Status",
          "type": "command",
          "command": "gitlens.showQuickRepoStatus",
          "when": "gitlens:enabled && config.gitlens.keymap == 'alternate'"
        },
        {
          "key": "t",
          "name": "Create Tag",
          "type": "command",
          "command": "git.createTag"
        },
        {
          "key": "T",
          "name": "Delete Tag",
          "type": "command",
          "command": "git.deleteTag"
        },
        {
          "key": "U",
          "name": "Unstage",
          "type": "command",
          "command": "git.unstage"
        }
      ]
    },
    {
      "key": "h",
      "name": "Split Horizontal",
      "type": "command",
      "command": "workbench.action.splitEditorDown"
    },
    {
      "key": "i",
      "name": "Insert...",
      "type": "bindings",
      "bindings": [
        {
          "key": "j",
          "name": "Insert line below",
          "type": "command",
          "command": "editor.action.insertLineAfter"
        },
        {
          "key": "k",
          "name": "Insert line above",
          "type": "command",
          "command": "editor.action.insertLineBefore"
        },
        {
          "key": "s",
          "name": "Insert snippet",
          "type": "command",
          "command": "editor.action.insertSnippet"
        }
      ]
    },
    {
      "key": "l",
      "name": "LSP...",
      "type": "bindings",
      "bindings": [
        {
          "key": ";",
          "name": "Refactor",
          "type": "command",
          "command": "editor.action.refactor",
          "when": "editorHasCodeActionsProvider && editorTextFocus && !editorReadonly"
        },
        {
          "key": "a",
          "name": "Auto Fix",
          "type": "command",
          "command": "editor.action.autoFix",
          "when": "editorTextFocus && !editorReadonly && supportedCodeAction =~ /(\\s|^)quickfix\\b/"
        },
        {
          "key": "d",
          "name": "Definition",
          "type": "command",
          "command": "editor.action.revealDefinition",
          "when": "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"
        },
        {
          "key": "D",
          "name": "Declaration",
          "type": "command",
          "command": "editor.action.revealDeclaration"
        },
        {
          "key": "e",
          "name": "Errors",
          "type": "command",
          "command": "workbench.actions.view.problems"
        },
        {
          "key": "f",
          "name": "Format",
          "type": "command",
          "command": "editor.action.formatDocument",
          "when": "editorHasDocumentFormattingProvider && editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"
        },
        {
          "key": "i",
          "name": "Implementation",
          "type": "command",
          "command": "editor.action.goToImplementation",
          "when": "editorHasImplementationProvider && editorTextFocus && !isInEmbeddedEditor"
        },
        {
          "key": "l",
          "name": "Code Lens",
          "type": "command",
          "command": "codelens.showLensesInCurrentLine"
        },
        {
          "key": "n",
          "name": "Next Problem",
          "type": "command",
          "command": "editor.action.marker.next",
          "when": "editorFocus"
        },
        {
          "key": "N",
          "name": "Next Problem (Proj)",
          "type": "command",
          "command": "editor.action.marker.nextInFiles",
          "when": "editorFocus"
        },
        {
          "key": "o",
          "name": "Outline",
          "type": "command",
          "command": "outline.focus"
        },
        {
          "key": "p",
          "name": "Prev Problem",
          "type": "command",
          "command": "editor.action.marker.prevInFiles",
          "when": "editorFocus"
        },
        {
          "key": "P",
          "name": "Prev Problem (Proj)",
          "type": "command",
          "command": "editor.action.marker.prev",
          "when": "editorFocus"
        },
        {
          "key": "q",
          "name": "Quick Fix",
          "type": "command",
          "command": "editor.action.quickFix",
          "when": "editorHasCodeActionsProvider && editorTextFocus && !editorReadonly"
        },
        {
          "key": "r",
          "name": "References",
          "type": "command",
          "command": "editor.action.goToReferences",
          "when": "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
        },
        {
          "key": "R",
          "name": "Rename",
          "type": "command",
          "command": "editor.action.rename",
          "when": "editorHasRenameProvider && editorTextFocus && !editorReadonly"
        },
        {
          "key": "v",
          "name": "View All References",
          "type": "command",
          "command": "references-view.find",
          "when": "editorHasReferenceProvider"
        },
        {
          "key": "s",
          "name": "Go To Symbol",
          "type": "command",
          "command": "workbench.action.gotoSymbol"
        },
        {
          "key": "S",
          "name": "Show All Symbols",
          "type": "command",
          "command": "workbench.action.showAllSymbols"
        }
      ]
    },
    {
      "key": "m",
      "name": "Mark...",
      "type": "bindings",
      "bindings": [
        {
          "key": "c",
          "name": "Clear Bookmarks",
          "type": "command",
          "command": "bookmarks.clear"
        },
        {
          "key": "j",
          "name": "Next Bookmark",
          "type": "command",
          "command": "bookmarks.jumpToNext",
          "when": "editorTextFocus"
        },
        {
          "key": "k",
          "name": "Previous Bookmark",
          "type": "command",
          "command": "bookmarks.jumpToPrevious",
          "when": "editorTextFocus"
        },
        {
          "key": "l",
          "name": "List Bookmarks",
          "type": "command",
          "command": "bookmarks.listFromAllFiles",
          "when": "editorTextFocus"
        },
        {
          "key": "r",
          "name": "Refresh Bookmarks",
          "type": "command",
          "command": "bookmarks.refresh"
        },
        {
          "key": "t",
          "name": "Toggle Bookmark",
          "type": "command",
          "command": "bookmarks.toggle",
          "when": "editorTextFocus"
        },
        {
          "key": "s",
          "name": "Show Bookmarks",
          "type": "command",
          "command": "workbench.view.extension.bookmarks"
        }
      ]
    },
    {
      "key": "M",
      "name": "Minimap",
      "type": "command",
      "command": "editor.action.toggleMinimap"
    },
    {
      "key": "n",
      "name": "No Highlight",
      "type": "command",
      "command": "vscode-neovim.send",
      "args": ":noh<CR>"
    },
    {
      "key": "o",
      "name": "Open...",
      "type": "bindings",
      "bindings": [
        {
          "key": "d",
          "name": "Directory",
          "type": "command",
          "command": "workbench.action.files.openFolder"
        },
        {
          "key": "r",
          "name": "Recent",
          "type": "command",
          "command": "workbench.action.openRecent"
        },
        {
          "key": "f",
          "name": "File",
          "type": "command",
          "command": "workbench.action.files.openFile"
        }
      ]
    },
    {
      "key": "p",
      "name": "Peek...",
      "type": "bindings",
      "bindings": [
        {
          "key": "d",
          "name": "Definition",
          "type": "command",
          "command": "editor.action.peekDefinition",
          "when": "editorHasDefinitionProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
        },
        {
          "key": "D",
          "name": "Declaration",
          "type": "command",
          "command": "editor.action.peekDeclaration"
        },
        {
          "key": "i",
          "name": "Implementation",
          "type": "command",
          "command": "editor.action.peekImplementation",
          "when": "editorHasImplementationProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
        },
        {
          "key": "p",
          "name": "Toggle Focus",
          "type": "command",
          "command": "togglePeekWidgetFocus",
          "when": "inReferenceSearchEditor || referenceSearchVisible"
        },
        {
          "key": "r",
          "name": "References",
          "type": "command",
          "command": "editor.action.referenceSearch.trigger"
        },
        {
          "key": "t",
          "name": "Type Definition",
          "type": "command",
          "command": "editor.action.peekTypeDefinition"
        }
      ]
    },
    {
      "key": "s",
      "name": "Search...",
      "type": "bindings",
      "bindings": [
        {
          "key": "f",
          "name": "Files",
          "type": "command",
          "command": "workbench.action.quickOpen"
        },
        {
          "key": "t",
          "name": "Text",
          "type": "command",
          "command": "workbench.action.findInFiles"
        }
      ]
    },
    {
      "key": "S",
      "name": "Show...",
      "type": "bindings",
      "bindings": [
        {
          "key": "e",
          "name": "Show explorer",
          "type": "command",
          "command": "workbench.view.explorer"
        },
        {
          "key": "s",
          "name": "Show search",
          "type": "command",
          "command": "workbench.view.search"
        },
        {
          "key": "g",
          "name": "Show source control",
          "type": "command",
          "command": "workbench.view.scm"
        },
        {
          "key": "t",
          "name": "Show test",
          "type": "command",
          "command": "workbench.view.extension.test"
        },
        {
          "key": "r",
          "name": "Show remote explorer",
          "type": "command",
          "command": "workbench.view.remote"
        },
        {
          "key": "x",
          "name": "Show extensions",
          "type": "command",
          "command": "workbench.view.extensions"
        },
        {
          "key": "p",
          "name": "Show problem",
          "type": "command",
          "command": "workbench.actions.view.problems"
        },
        {
          "key": "o",
          "name": "Show output",
          "type": "command",
          "command": "workbench.action.output.toggleOutput"
        },
        {
          "key": "d",
          "name": "Show debug console",
          "type": "command",
          "command": "workbench.debug.action.toggleRepl"
        }
      ]
    },
    {
      "key": "t",
      "name": "Terminal...",
      "type": "bindings",
      "bindings": [
        {
          "key": "t",
          "name": "Toggle Terminal",
          "type": "command",
          "command": "workbench.action.togglePanel"
        },
        {
          "key": "T",
          "name": "Focus Terminal",
          "type": "command",
          "command": "workbench.action.terminal.toggleTerminal",
          "when": "!terminalFocus"
        }
      ]
    },
    {
      "key": "u",
      "name": "UI toggles...",
      "type": "bindings",
      "bindings": [
        {
          "key": "a",
          "name": "Toggle tool/activity bar visibility",
          "type": "command",
          "command": "workbench.action.toggleActivityBarVisibility"
        },
        {
          "key": "b",
          "name": "Toggle side bar visibility",
          "type": "command",
          "command": "workbench.action.toggleSidebarVisibility"
        },
        {
          "key": "j",
          "name": "Toggle panel visibility",
          "type": "command",
          "command": "workbench.action.togglePanel"
        },
        {
          "key": "F",
          "name": "Toggle full screen",
          "type": "command",
          "command": "workbench.action.toggleFullScreen"
        },
        {
          "key": "s",
          "name": "Select theme",
          "type": "command",
          "command": "workbench.action.selectTheme"
        },
        {
          "key": "m",
          "name": "Toggle maximized panel",
          "type": "command",
          "command": "workbench.action.toggleMaximizedPanel"
        },
        {
          "key": "T",
          "name": "Toggle tab visibility",
          "type": "command",
          "command": "workbench.action.toggleTabsVisibility"
        }
      ]
    },
    {
      "key": "v",
      "name": "Split Vertical",
      "type": "command",
      "command": "workbench.action.splitEditor"
    },
    {
      "key": "w",
      "name": "Window...",
      "type": "bindings",
      "bindings": [
        {
          "key": "W",
          "name": "Focus previous editor group",
          "type": "command",
          "command": "workbench.action.focusPreviousGroup"
        },
        {
          "key": "h",
          "name": "Move editor group left",
          "type": "command",
          "command": "workbench.action.moveActiveEditorGroupLeft"
        },
        {
          "key": "j",
          "name": "Move editor group down",
          "type": "command",
          "command": "workbench.action.moveActiveEditorGroupDown"
        },
        {
          "key": "k",
          "name": "Move editor group up",
          "type": "command",
          "command": "workbench.action.moveActiveEditorGroupUp"
        },
        {
          "key": "l",
          "name": "Move editor group right",
          "type": "command",
          "command": "workbench.action.moveActiveEditorGroupRight"
        },
        {
          "key": "t",
          "name": "Toggle editor group sizes",
          "type": "command",
          "command": "workbench.action.toggleEditorWidths"
        },
        {
          "key": "m",
          "name": "Maximize editor group",
          "type": "command",
          "command": "workbench.action.minimizeOtherEditors"
        },
        {
          "key": "M",
          "name": "Maximize editor group and hide side bar",
          "type": "command",
          "command": "workbench.action.maximizeEditor"
        },
        {
          "key": "=",
          "name": "Reset editor group sizes",
          "type": "command",
          "command": "workbench.action.evenEditorWidths"
        },
        {
          "key": "z",
          "name": "Combine all editors",
          "type": "command",
          "command": "workbench.action.joinAllGroups"
        },
        {
          "key": "d",
          "name": "Close editor group",
          "type": "command",
          "command": "workbench.action.closeEditorsInGroup"
        },
        {
          "key": "x",
          "name": "Close all editor groups",
          "type": "command",
          "command": "workbench.action.closeAllGroups"
        }
      ]
    },
    {
      "key": "x",
      "name": "Extensions",
      "type": "command",
      "command": "workbench.view.extensions"
    },
    {
      "key": "y",
      "name": "Sync...",
      "type": "bindings",
      "bindings": [
        {
          "key": "d",
          "name": "Download Settings",
          "type": "command",
          "command": "extension.downloadSettings"
        },
        {
          "key": "u",
          "name": "Upload Settings",
          "type": "command",
          "command": "extension.updateSettings"
        }
      ]
    }
  ],
  "files.associations": {
    "*.rmd": "markdown"
  },
  "http.systemCertificates": false,
  "terminal.integrated.inheritEnv": false,
  "Lua.telemetry.enable": false,
  "cmake.configureOnOpen": true,
  "python.formatting.provider": "black",
  "workbench.colorTheme": "Nord"

