# Build GT2 Android from source

This guide describes the supplied WSL/Ubuntu build workflow. The helper script is:

` scripts/setup-and-build-gt2.sh `

It installs the pinned toolchain when needed, imports the source ZIP, invokes `scripts/build-android.sh`, and copies the resulting debug APK to the Windows Downloads folder.

## 1. What you need

- Windows 10/11 with WSL2 and Ubuntu (x86_64).
- Internet access for the first setup and dependency downloads.
- The Android source archive named **`gt2-android.zip`**.
- The helper script **`setup-and-build-gt2.sh`**.

The script installs/checks JDK 17, Android SDK platform 36, Build Tools 36.0.0, NDK 27.2.12479018, CMake 3.22.1 and Gradle 8.13. The NDK supplies `glslc`; a separate Vulkan SDK is not required by the Android build.

## 2. First build

1. Download the latest source ZIP from [GitHub Releases](https://github.com/PhantasmProject/gt2-android/releases/latest).
2. Save it in your Windows **Downloads** folder and make sure its filename is `gt2-android.zip`.
3. Save `setup-and-build-gt2.sh` in the same Downloads folder.
4. Open Ubuntu (WSL) and run:

```bash
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh
```

The first run may take a while: Android SDK/NDK and Gradle are downloaded and installed. `sudo` may request your Ubuntu password.

## 3. Subsequent builds

Run the same command with the desired options:

```bash
# Incremental build (default; reuses project and Gradle caches)
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup

# Clean project build (keeps the global Gradle cache)
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --clean

# Fresh project extraction + clean build
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --fresh

# Remove the global Gradle dependency cache too (internet required)
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --clean --purge-cache

# Offline build from the existing Gradle cache
cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --offline
```

## 4. Script options

| Option | Meaning |
|---|---|
| *(no option)* | Incremental build; copies only changed source files from the ZIP |
| `--skip-setup` | Skip apt, Android SDK/NDK and Gradle installation checks |
| `--clean` | Delete project build outputs and CMake/Gradle project caches before building |
| `--fresh` | Delete the WSL project directory and extract the source ZIP again; implies a clean build |
| `--purge-cache` | Also delete the global `~/.gradle/caches`; a network connection is needed afterwards |
| `--offline` | Ask Gradle to build using its existing cache without network access |
| `--no-copy` | Do not copy the APK to Windows Downloads |
| `--src PATH` | Build from an existing project directory in WSL instead of importing a ZIP |
| `PATH.zip` | Use a ZIP file at a custom path instead of the Windows Downloads default |
| `--help` | Print the script's built-in help |

Do not combine `--fresh` with `--src`. `--purge-cache` cannot be combined with `--offline`.

## 5. Output

The APK is generated at:

```text
~/gt2work/gt2-android/android/app/build/outputs/apk/debug/app-debug.apk
```

By default, the script copies it to:

```text
C:\Users\<your-user>\Downloads\gt2-android-debug.apk
```

The script is a convenience wrapper around the project's `scripts/build-android.sh`. It does not create a signed Play Store release; the output is the debug APK.

## 6. Troubleshooting

- **`Run inside WSL (Ubuntu)`** — open the Ubuntu WSL terminal, not Windows PowerShell or CMD.
- **NDK/Gradle not found with `--skip-setup`** — run once without `--skip-setup`.
- **Source ZIP not found** — check that `gt2-android.zip` is in Windows Downloads, or pass its full WSL path as the final argument.
- **`glslc` missing** — rerun setup without `--skip-setup` and check the NDK installation.
- **Build dependency download fails** — restore network access and retry. Use `--offline` only after a successful build has populated the Gradle cache.

For the Android runtime and folder-picker behavior, see [ANDROID.md](ANDROID.md).
