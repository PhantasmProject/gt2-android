# Install GT2 Android on your phone

## 1. Download and install the APK

1. Open [the latest GT2 Android release](https://github.com/PhantasmProject/gt2-android/releases/latest).
2. Download the APK asset from the release.
3. Open the downloaded APK on your Android device and follow Android's installation prompt.
4. If Android blocks the installation, allow installation from the browser or file manager you used to download the APK, then retry.

## 2. Prepare the game data on a Windows PC

Follow [GAME-DATA.md](GAME-DATA.md). The Windows toolkit extracts and validates your own supported disc image(s) and creates `runtime/arcade` and/or `runtime/simulation`.

## 3. Transfer the prepared data

On the PC, create one ZIP containing only the `arcade` and/or `simulation` folder(s) inside `runtime`. Do not include the outer `runtime` directory. Transfer this single ZIP to the phone and extract it there.

## 4. Select the data folder in the game

1. Launch GT2 Android.
2. If no game data has already been configured, the Android system folder picker opens.
3. Select the parent folder that contains `arcade` and/or `simulation`. You can also select the `arcade` or `simulation` folder itself.
4. On Android 11 and newer, enable the requested **All files access** permission for GT2 and return to the game. Android 9–10 uses the storage permission flow.
5. The app remembers the selected folder. If you move or remove it later, the folder picker will appear again.

The app reads the chosen data folder in place; it does not copy the thousands of files into its private storage.

## 5. Requirements and compatibility

- Android 9 or newer, ARM64.
- Vulkan 1.3 with dynamic rendering is required.
- Compatibility depends on the device and graphics driver. The tested-device list is in the main [README](../README.md).

## Troubleshooting

- **The game asks for data again:** the selected folder may have been moved, renamed, removed or become unavailable (for example, an SD card was removed). Select it again.
- **No supported GPU / Vulkan error:** verify that the device's active graphics driver exposes Vulkan 1.3 and dynamic rendering. Some older Adreno devices may require a compatible Turnip driver.
- **Game starts but a mode is missing:** make sure you prepared that disc and that the selected directory contains the corresponding `arcade` or `simulation` folder.
- **Need to report a crash:** include the phone model, Android version, GPU/driver details and `gt2game-error.log` if available.
