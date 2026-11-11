# Preparing Gran Turismo 2 game data on Windows

The Android application does not include the game disc data. You must prepare data from your own legally obtained disc image.

The supplied Windows toolkit is included in this repository package at:

`tools/GT2 Preparing Data.zip`

It is a separate archive from the Android source ZIP and APK.

## Requirements

- Windows PC.
- Your own supported Gran Turismo 2 disc image(s).
- The **GT2 Preparing Data.zip** toolkit from this repository package or the [latest release](https://github.com/PhantasmProject/gt2-android/releases/latest).

Supported discs: The European versions of Arcade (SCES_023.80) and Simulation (SCES_123.80) are officially supported.
Original game disc image in .bin or .iso format.
## Step-by-step

1. Extract `GT2 Preparing Data.zip` into its own folder on your Windows PC.
2. Open the extracted folder.
3. Double-click **`INSTALL.bat`**.
4. If Windows asks for permission to run PowerShell, allow the script.
5. In the file dialog, select your own Arcade and/or Simulation disc image(s).
6. Choose the desired HD media level:
   - **Original** — original media.
   - **Menus** — HD menus.
   - **MenusAndMovies** — HD menus and movies.
7. Wait for extraction, conversion and validation to finish. The generated output is placed in the `runtime` folder inside the toolkit directory.
8. Open `runtime`. Depending on the disc images you processed, it contains `arcade` and/or `simulation`.
9. Create one ZIP archive containing only the generated `arcade` and/or `simulation` folders. Do **not** ZIP the entire `runtime` folder.
10. Transfer this ZIP to your Android phone.
11. Extract the ZIP on the phone. Do not transfer thousands of individual files uncompressed over USB/Wi-Fi; creating and transferring one ZIP is much faster.
12. Start GT2 Android and use the Android folder picker to select the folder containing `arcade` and/or `simulation`, or select the relevant mode folder itself.

## What the Windows installer does

`INSTALL.bat` starts `scripts/install.ps1`. The supplied prebuilt tools in `tools/` mean you normally do not need to compile the toolkit yourself. The installer asks for disc images, extracts the supported data, runs validation checks and publishes the prepared mode folders into `runtime`.

The default output location is `runtime` beside the toolkit. The script may install required Windows build dependencies if they are missing. It also keeps a backup of previously installed runtime data rather than silently replacing it.

Advanced users can inspect `scripts/install.ps1` and its PowerShell parameters. For example, it supports `-DiscImage`, `-InstallDir`, `-HdMedia`, `-Bios`, `-CaptureCore`, and `-NoBuild`; use PowerShell help or inspect the script before using advanced options.

## Important notes

- Only use disc images and BIOS files you are legally entitled to use.
- The toolkit does not grant rights to Gran Turismo 2 assets or trademarks.
- Do not upload disc images, extracted copyrighted assets, BIOS files or prepared game-data ZIPs to this public source repository.
- Keep the original toolkit archive intact; run `INSTALL.bat` from the extracted toolkit folder.
