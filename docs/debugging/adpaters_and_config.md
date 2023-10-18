# Adapter and Configurations



<!-- vim-markdown-toc GitLab -->

* [Adapters Types](#adapters-types)
    * [Which Adapter I am using](#which-adapter-i-am-using)
    * [Table 1: Adapter Details](#table-1-adapter-details)
    * [Table 2: Adapter Maintainers and Open Source Status](#table-2-adapter-maintainers-and-open-source-status)
* [Configure OpenDebugAD7](#configure-opendebugad7)
    * [How to Automate the Server](#how-to-automate-the-server)
* [Another Adapter](#another-adapter)

<!-- vim-markdown-toc -->

I have worked on debugging both the rust and cpp files in my projects, and I
found that there are several ways to construct configurations. Basically, there
are two methods: configuring as a `executable` or as a `server`. These are the two
classifications of the most available adapters for C, C++, and Rust.

## Adapters Types

Debugging adapters serve as intermediaries between a debugger (like LLDB or
GDB) and a development environment or editor (like Visual Studio Code). Each
adapter can have specific features, behaviors, and compatibility levels. Here's
a table summarizing the major differences among the mentioned debugging
adapters. Please note that this table is based on data available up to January
2022, and there might be changes or updates after that time:

### Which Adapter I am using

| Adapter Name   | file type support | configuration file name  | Features                                                       | dap calling name   |
| -------------- | ----------        | -------                  | ----------------------------------------                       | ------------------ |
| OpenDebugAD7   | C/CPP             | dap_cpp_OpenDebugAD7.lua | binary location, Automatic server triggered, breakpoint banner | cppdbg             |
| lldb-vscode    | C/CPP             | dap_cpp_lldb_vscode.lua  | binary location, Automatic executable, breakingpoint banner    | lldb-vscode        |
| Codelldb       |                   |

### Table 1: Adapter Details

| Adapter Name   | Debugger Backend    | IDE Support                   | Language Support    | Platform       |
| -------------- | ------------------- | ----------------------------- | ------------------- | -------------- |
| lldb-mi        | LLDB with MI        | Various (Eclipse, CLion)      | C, C++, Objective-C | Cross-platform |
| lldb           | LLDB                | Command line and others       | C, C++, Objective-C | Cross-platform |
| lldb-vscode    | LLDB                | Visual Studio Code            | C, C++, Objective-C | Cross-platform |
| codelldb       | LLDB                | Visual Studio Code            | C, C++, Objective-C | Cross-platform |
| vscode-cpptool | Either GDB or LLDB  | Visual Studio Code            | C, C++              | Cross-platform |
| OpenDebugAD7   | MIEngine (GDB/LLDB) | Visual Studio Code and others | C, C++, others      | Cross-platform |

### Table 2: Adapter Maintainers and Open Source Status

| Adapter Name   | Maintainer/Sponsor | Open Source | Remarks                                                                           |
| -------------- | ------------------ | ----------- | --------------------------------------------------------------------------------- |
| lldb-mi        | LLVM Project       | Yes         | Machine Interface for LLDB, mimics GDB's MI.                                      |
| lldb           | LLVM Project       | Yes         | LLDB's primary command-line interface.                                            |
| lldb-vscode    | LLVM Project       | Yes         | Adapter for integrating LLDB with VS Code.                                        |
| codelldb       | Vadim Macagon      | Yes         | A modern LLDB adapter for VS Code with a rich feature set.                        |
| vscode-cpptool | Microsoft          | Partially   | Microsoft's official C++ extension for VS Code. Debug components are open source. |
| OpenDebugAD7   | Microsoft          | Yes         | Built on MIEngine to abstract GDB/LLDB for Visual Studio Code.                    |

**Notes:**

- **Debugger Backend**: Refers to the underlying debugger the adapter uses to
  perform actual debugging operations.
- **IDE Support**: Indicates the primary development environments or editors
  the adapter is designed to work with.
- **Language Support**: Lists the primary programming languages the
  debugger/adapter is designed to work with.
- **Platform**: Indicates the operating systems or platforms the
  adapter/debugger can run on.
- **Remarks**: Provides additional notes or distinguishing features of the
  adapter.

This table provides a high-level comparison. For specific features, nuances, or
updates, it's always a good idea to refer to the official documentation or
repositories of each adapter/debugger.

I've added a "Maintainer/Sponsor" column and an "Open Source" column to the
table. Keep in mind that this information is based on data available as of
January 2022, and might require verification against the latest sources for the
most accurate details.

- "Partially" in the "Open Source" column for `vscode-cpptool` means that while
  the core debugging components (debugger and adapter) are open source, some
  components or features of the overall Visual Studio Code C++ extension might
  not be.
- Maintainer/Sponsor refers to the primary organization or individual
  responsible for creating, maintaining, or sponsoring the development of the
  adapter.
- Open Source status indicates whether the source code of the adapter/debugger
  is publicly available and licensed under open source terms. It's always a
  good idea to check the specific license terms for details. For the most
  recent and detailed information, always consult the official repositories or
  websites of these adapters.

## Configure OpenDebugAD7

- Ensure you run using Mason to install `cpptools`, this will install the
  adapter and configuration support for C/CPP and Rust. The steps are:

1. Download using `Mason` the `cpptools` located at:
   `~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin`

2. Use the adapter configurations

```sh

local M = {}

function M.setup(dap)
  local install_root_dir = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/"
  local miDebuggerPath = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/lldb-mi/bin/lldb-mi"
  local OpenDebugAD7 = install_root_dir .. "OpenDebugAD7"

  dap.adapters["cppdbg"] = {
    id = "cppdbg",
    type = "server",
    port = "9999",
    executable = {
      command = OpenDebugAD7,
      args = { "--server", "9999", "--trace", "response", "engineLogging" },
    },
    name = "cppdbg", -- Name can be useful for reference
  }
  dap.configurations.cpp = {
    {
      name = "Launch OpenDebugAD7",
      type = "cppdbg",
      MIMode = "gdb",
      --miDebuggerServerAddress = 'localhost:9999', -- Not working and should not be included, unless you are using linux
      miDebuggerPath = miDebuggerPath,
      request = "launch",
      program = "${workspaceFolder}/build/debug/main",
      cwd = "${workspaceFolder}",
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
  }

  dap.configurations.c = dap.configurations.cpp
end

return M
```

3. You must prepare a `<adapter_name>_ad7Engine.json` file which will give all
   the instructions on how to connect the adapter to the session. You follow the steps:
   - Go to the location
     `~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin`
     and copy the `cppdbg.ad7Engine.json` to `nvim.ad7Engine.json` at same
     location. Mine has the following information. The file comes directly with
     the extension directory, and `no need to modify anything`.

```json
{
  "engineAssemblyName": "Microsoft.MIDebugEngine, Version=14.0.0.0",
  "engineClassName": "Microsoft.MIDebugEngine.AD7Engine",
  "conditionalBP": true,
  "functionBP": true,
  "dataBP": true,
  "clipboardContext": true,
  "exceptionSettings": {
    "categories": [
      {
        "name": "C++ Exceptions",
        "id": "3A12D0B7-C26C-11D0-B442-00A0244A1DD2"
      }
    ],
    "exceptionBreakpointFilters": [
      {
        "label": "All C++ Exceptions",
        "filter": "all",
        "supportsCondition": true,
        "conditionDescription": "std::out_of_range,std::invalid_argument",
        "categoryId": "3A12D0B7-C26C-11D0-B442-00A0244A1DD2"
      }
    ]
  }
}
```

4. Run the server, You must keep make this server work everytime you want to
   use the debugger `OpenDebugAD7`. The server is located at:
   `~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin`

```sh
./OpenDebugAD7 --server=9999 --trace=response --engineLogging
```

### How to Automate the Server

In lua we can automate the servre to run and stop using

```lua

local job_id = nil

local function start_open_debug_ad7_server()
  local cmd = "~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
  local args = {"--server=9999", "--trace=response", "--engineLogging"}

  job_id = vim.fn.jobstart({cmd, unpack(args)}, {
    on_exit = function(j, return_val, event)
      if return_val ~= 0 then
        print("OpenDebugAD7 server exited with error!")
      end
    end
  })
end
```

## Another Adapter

