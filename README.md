# conversion-select

This project is inspired by [im-select](https://github.com/daipeihust/im-select), and its motivation is also for solving a vim key binding issue with non-alphabetic languages.

Currently, this is for windows users and IMEs that support multiple languages.

For example, Koreans type Korean and English with the same IME in Windows 11, and all keyboards being sold in Korea has a key to toggle eng/kor without changing the keyboard layout. So, changing IME via im-select is insufficient solution for us.

Internally, Changing the input language without changing IME is done by modifying the conversion status of IME, and conversion-select does a similar thing to im-select in this way.

You can use this with the following extensions or plugins.

- [VSCodeVim](https://github.com/VSCodeVim/Vim)
- [vim-im-select-obsidian](https://github.com/ALONELUR/vim-im-select-obsidian)

# Requirements

- Windows 10 or Windows 11
- PowerShell, which is included with Windows
- A C++ compiler that provides `g++`

The build script uses `g++` by default. The recommended way to install it on Windows is MSYS2 MinGW-w64.

# Install g++ on Windows

1. Download and install MSYS2 from <https://www.msys2.org/>.
2. Open **MSYS2 UCRT64** from the Start menu.
3. Update MSYS2:

   ```sh
   pacman -Syu
   ```

   If MSYS2 asks you to close the terminal, close it, reopen **MSYS2 UCRT64**, and run the same command again.

4. Install the MinGW-w64 C++ compiler:

   ```sh
   pacman -S mingw-w64-ucrt-x86_64-gcc
   ```

5. Add the compiler to your Windows `PATH`.

   Add this folder to the `Path` environment variable:

   ```text
   C:\msys64\ucrt64\bin
   ```

   One way to do this:

   1. Open the Start menu and search for **Environment Variables**.
   2. Open **Edit the system environment variables**.
   3. Click **Environment Variables...**.
   4. Under your user variables, select **Path**, then click **Edit**.
   5. Click **New**, add `C:\msys64\ucrt64\bin`, then click **OK**.
   6. Close and reopen PowerShell.

6. Verify that Windows can find `g++`:

   ```powershell
   g++ --version
   ```

   If this prints a version number, the compiler is ready.

# Build

Open PowerShell in this repository folder, then run:

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

# Use

Run the executable from PowerShell:

```powershell
.\build\Release\conversion-select.exe
```

With no arguments, it prints the current IME conversion status for the foreground window.

To set the conversion status, pass the value as the first argument:

```powershell
.\build\Release\conversion-select.exe 0
```

The exact values are IME-dependent. For editor integrations such as VSCodeVim or Obsidian Vim plugins, use the full path to the built executable:

```text
C:\path\to\conversion-select\build\Release\conversion-select.exe
```

# If PowerShell blocks the build script

If PowerShell says script execution is disabled, run this command from the repository folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

# Troubleshooting

## g++ is not recognized

If PowerShell shows this error:

```text
g++: The term 'g++' is not recognized
```

Check that `C:\msys64\ucrt64\bin` was added to `Path`, then close and reopen PowerShell. You can also run:

```powershell
where.exe g++
```

It should print a path such as:

```text
C:\msys64\ucrt64\bin\g++.exe
```

## Using a different compiler path

If `g++` is installed but not on `PATH`, set `CXX` for the current PowerShell session:

```powershell
$env:CXX = "C:\msys64\ucrt64\bin\g++.exe"
.\build.ps1
```

## IME compatibility

Flags used in conversion-select.cpp for WM_IME_CONTROL is not documented in [official documentation](https://learn.microsoft.com/en-us/windows/win32/intl/wm-ime-control), and seems like this is IME-dependent.
I manually found GET_CONVERSION_STATUS and SET_CONVERSION_STATUS for default Korean IME in windows 11.
So, if this doesn't work with your IME, find the same function manually by changing flags.
