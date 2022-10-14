[
  {
    "key": "shift+ctrl+e",
    "command": "actions.findWithSelection"
  },
  {
    "key": "ctrl+e",
    "command": "-actions.findWithSelection"
  },
  {
    "key": "ctrl+e",
    "command": "workbench.view.explorer"
  },
  {
    "key": "shift+ctrl+e",
    "command": "-workbench.view.explorer"
  },
  {
    "key": "r",
    "command": "renameFile",
    "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
  },
  {
    "key": "enter",
    "command": "-renameFile",
    "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
  },
  {
    "key": "j",
    "command": "list.focusDown",
    "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
  },
  {
    "key": "k",
    "command": "list.focusUp",
    "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
  },
  {
    "key": "ctrl+j",
    "command": "selectNextSuggestion",
    "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
  },
  {
    "key": "ctrl+k",
    "command": "selectPrevSuggestion",
    "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
  },
  {
    "key": "ctrl+j",
    "command": "workbench.action.quickOpenNavigateNext",
    "when": "inQuickOpen"
  },
  {
    "key": "tab",
    "command": "selectNextSuggestion",
    "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
  },
  {
    "key": "tab",
    "command": "workbench.action.quickOpenNavigateNext",
    "when": "inQuickOpen"
  },
  {
    "key": "shift+tab",
    "command": "selectPrevSuggestion",
    "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
  },
  {
    "key": "shift+tab",
    "command": "workbench.action.quickOpenNavigatePrevious",
    "when": "inQuickOpen"
  },
  {
    "key": "ctrl+k",
    "command": "workbench.action.quickOpenNavigatePrevious",
    "when": "inQuickOpen"
  },
  {
    "key": "enter",
    "command": "list.select",
    "when": "explorerViewletVisible && filesExplorerFocus"
  },
  {
    "key": "l",
    "command": "list.select",
    "when": "explorerViewletVisible && filesExplorerFocus && !inputFocus"
  },
  {
    "key": "o",
    "command": "list.toggleExpand",
    "when": "explorerViewletVisible && filesExplorerFocus && !inputFocus"
  },
  {
    "key": "h",
    "command": "list.collapse",
    "when": "explorerViewletVisible && filesExplorerFocus && !inputFocus"
  },
  {
    "key": "a",
    "command": "explorer.newFile",
    "when": "filesExplorerFocus && !inputFocus"
  },
  {
    "key": "shift+a",
    "command": "explorer.newFolder",
    "when": "filesExplorerFocus && !inputFocus"
  },
  {
    "key": "shift+;",
    "command": "insertPrevSuggestion",
    "when": "hasOtherSuggestions && textInputFocus && textInputFocus && !inSnippetMode && !suggestWidgetVisible && config.editor.tabCompletion == 'on'"
  },
  {
    "key": "ctrl+l",
    "when": "sideBarFocus",
    "command": "workbench.action.focusActiveEditorGroup"
  },
  {
    "key": "ctrl+k",
    "command": "workbench.action.focusActiveEditorGroup",
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+shift+t",
    "command": "workbench.action.terminal.focus",
    "when": "!terminalFocus"
  },
  {
    "key": "ctrl+j",
    "command": "-editor.action.insertLineAfter",
    "when": "editorTextFocus && neovim.ctrlKeysInsert && !neovim.recording && neovim.mode == 'insert'"
  },
  {
    "key": "alt+j",
    "command": "workbench.action.terminal.focus",
    "when": "!terminalFocus"
  },
  {
    "key": "ctrl+shift+t",
    "command": "workbench.action.togglePanel"
  },
  {
    "key": "ctrl+j",
    "command": "-workbench.action.togglePanel"
  },
  {
    "key": "F1",
    "command": "editor.action.showHover",
    "when": "editorTextFocus && neovim.mode != 'insert'"
  },
  {
    "key": "ctrl+k ctrl+i",
    "command": "-editor.action.showHover",
    "when": "editorTextFocus"
  },
  {
    "key": "shift+tab",
    "command": "-acceptAlternativeSelectedSuggestion",
    "when": "suggestWidgetVisible && textInputFocus && textInputFocus"
  },
  {
    "key": "ctrl+f",
    "command": "-vscode-neovim.ctrl-f",
    "when": "editorTextFocus && neovim.ctrlKeysNormal && neovim.init && neovim.mode != 'insert'"
  },
  {
    "key": "space+t",
    "command": "whichkey.show",
    "when": "neovim.mode != 'insert'"
  },
  {
    // Installed by me: Ghasak (added the !editorReadonly)
    "key": "shift+k",
    "command": "editor.action.moveLinesUpAction",
    "when": "editorTextFocus  && !editorReadonly && neovim.ctrlKeysNormal && neovim.init && neovim.mode != 'insert'"
  },
  {
    // Installed by me: Ghasak
    "key": "shift+j",
    "command": "editor.action.moveLinesDownAction",
    "when": "editorTextFocus  && !editorReadonly && neovim.ctrlKeysNormal && neovim.init && neovim.mode != 'insert'"
  },
  //{
  //	"key": "space",
  //	"command": "vspacecode.space",
  //	"when": "activeEditorGroupEmpty && focusedView == '' && !whichkeyActive && !inputFocus"
  //},
  //{
  //	"key": "space",
  //	"command": "vspacecode.space",
  //	"when": "sideBarFocus && !inputFocus && !whichkeyActive"
  //},
  {
    "key": "tab",
    "command": "extension.vim_tab",
    "when": "editorFocus && vim.active && !inDebugRepl && vim.mode != 'Insert' && editorLangId != 'magit'"
  },
  {
    "key": "tab",
    "command": "-extension.vim_tab",
    "when": "editorFocus && vim.active && !inDebugRepl && vim.mode != 'Insert'"
  },
  {
    "key": "x",
    "command": "magit.discard-at-point",
    "when": "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/"
  },
  {
    "key": "k",
    "command": "-magit.discard-at-point"
  },
  {
    "key": "-",
    "command": "magit.reverse-at-point",
    "when": "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/"
  },
  {
    "key": "v",
    "command": "-magit.reverse-at-point"
  },
  {
    "key": "shift+-",
    "command": "magit.reverting",
    "when": "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/"
  },
  {
    "key": "shift+v",
    "command": "-magit.reverting"
  },
  {
    "key": "shift+o",
    "command": "magit.resetting",
    "when": "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/"
  },
  {
    "key": "shift+x",
    "command": "-magit.resetting"
  },
  {
    "key": "x",
    "command": "-magit.reset-mixed"
  },
  {
    "key": "ctrl+u x",
    "command": "-magit.reset-hard"
  },
  {
    "key": "y",
    "command": "-magit.show-refs"
  },
  {
    "key": "y",
    "command": "vspacecode.showMagitRefMenu",
    "when": "editorTextFocus && editorLangId == 'magit' && vim.mode == 'Normal'"
  },
  {
    "key": "ctrl+j",
    "command": "workbench.action.quickOpenSelectNext",
    "when": "inQuickOpen"
  },
  {
    "key": "ctrl+k",
    "command": "workbench.action.quickOpenSelectPrevious",
    "when": "inQuickOpen"
  },
  {
    "key": "ctrl+j",
    "command": "selectNextSuggestion",
    "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
  },
  {
    "key": "ctrl+k",
    "command": "selectPrevSuggestion",
    "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
  },
  {
    "key": "ctrl+l",
    "command": "acceptSelectedSuggestion",
    "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
  },
  {
    "key": "ctrl+j",
    "command": "showNextParameterHint",
    "when": "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible"
  },
  {
    "key": "ctrl+k",
    "command": "showPrevParameterHint",
    "when": "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible"
  },
  {
    "key": "ctrl+h",
    "command": "file-browser.stepOut",
    "when": "inFileBrowser"
  },
  {
    "key": "ctrl+l",
    "command": "file-browser.stepIn",
    "when": "inFileBrowser"
  },
  {
    "key": "shift+cmd+r",
    "command": "-extension.newAREPLSession",
    "when": "!inQuickOpen && !terminalFocus"
  },
  {
    "key": "shift+cmd+r",
    "command": "-workbench.action.showAllSymbols"
  },
  {
    "key": "shift+cmd+r",
    "command": "-extension.newlivecodeSession",
    "when": "!inQuickOpen && !terminalFocus"
  },
  {
    "key": "shift+cmd+r",
    "command": "-rerunSearchEditorSearch",
    "when": "inSearchEditor"
  },
  {
    "key": "shift+cmd+r",
    "command": "code-runner.run"
  },
  {
    "key": "ctrl+alt+n",
    "command": "-code-runner.run"
  },
  {
    "key": "ctrl+\\",
    "command": "workbench.action.terminal.toggleTerminal",
    "when": "terminal.active"
  },
  {
    "key": "ctrl+`",
    "command": "-workbench.action.terminal.toggleTerminal",
    "when": "terminal.active"
  },
  {
    "key": "cmd+t",
    "command": "workbench.action.showAllSymbols"
  },
  {
    "key": "cmd+t",
    "command": "-workbench.action.showAllSymbols"
  },
  {
    "key": "cmd+t",
    "command": "workbench.action.quickOpen"
  },
  {
    "key": "cmd+t",
    "command": "-workbench.action.quickOpen"
  }
]
