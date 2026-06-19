# conversion-select

This project is inspired by [im-select](https://github.com/daipeihust/im-select), and its motivation is also for solving a vim key binding issue with non-alphabetic languages.

Currently, this is for windows users and IMEs that support multiple languages.

For example, Koreans type Korean and English with the same IME in Windows 11, and all keyboards being sold in Korea has a key to toggle eng/kor without changing the keyboard layout. So, changing IME via im-select is insufficient solution for us.

Internally, Changing the input language without changing IME is done by modifying the conversion status of IME, and conversion-select does a similar thing to im-select in this way.

You can use this with the following extensions or plugins.

- [VSCodeVim](https://github.com/VSCodeVim/Vim)
- [vim-im-select-obsidian](https://github.com/ALONELUR/vim-im-select-obsidian)

# Build

Install a Windows C++ compiler such as MSYS2 MinGW-w64, then run:

```powershell
.\build.ps1
```

The executable is created at `build\Release\conversion-select.exe`.

For a debug build:

```powershell
.\build.ps1 -Configuration Debug
```

To clean generated files:

```powershell
.\build.ps1 -Clean
```

You can also use the command prompt wrapper:

```bat
build.bat
```

# Troubleshooting

Flags used in conversion-select.cpp for WM_IME_CONTROL is not documented in [official documentation](https://learn.microsoft.com/en-us/windows/win32/intl/wm-ime-control), and seems like this is IME-dependent.
I manually found GET_CONVERSION_STATUS and SET_CONVERSION_STATUS for default Korean IME in windows 11.
So, if this doesn't work with your IME, find the same function manually by changing flags.
