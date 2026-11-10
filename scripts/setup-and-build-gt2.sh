#!/usr/bin/env bash
# =============================================================================
# GT2 Android: установка окружения + сборка APK в WSL (Ubuntu).
#
# Что делает:
#   1. Ставит пакеты через apt (JDK 17, unzip, rsync, curl и т.д.) - только если чего-то не хватает
#   2. Ставит Android SDK: platform 36, build-tools 36.0.0, NDK 27.2.12479018, CMake 3.22.1
#   3. Ставит Gradle 8.13
#   4. Берёт gt2-android.zip (по умолчанию из Windows-папки Downloads) и обновляет проект в ~/gt2work/gt2-android
#   5. Запускает scripts/build-android.sh из проекта
#   6. Копирует готовый APK обратно в Windows-папку Downloads (gt2-android-debug.apk)
#
# Скрипт можно запускать повторно: уже установленное пропускается.
#
# -----------------------------------------------------------------------------
# КАК ЗАПУСКАТЬ (внутри WSL). Скрипт и gt2-android.zip лежат в Windows-папке Downloads.
# Каждая команда ниже делает всё сразу: копирует скрипт из Downloads в WSL и запускает его.
# Zip скачивай заново в Downloads - скрипт сам возьмёт свежий архив оттуда.
#
# 1) ПЕРВАЯ УСТАНОВКА окружения и сборка:
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh
#
# 2) СБОРКА С КЭШЕМ (быстро; перекомпилируется только то, что изменилось в новом zip):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup
#
# 3) СБОРКА БЕЗ КЭША (кэш проекта чистится, всё компилируется заново; интернет не нужен):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --clean
#
# 4) СОВСЕМ С НУЛЯ (папка проекта в WSL удаляется и распаковывается заново + сборка без кэша):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --fresh
#
# 5) САМАЯ ПОЛНАЯ ОЧИСТКА (как 3, плюс удаляется общий кэш Gradle; нужен интернет, очень долго):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --clean --purge-cache
#
# 6) БЕЗ ИНТЕРНЕТА (из кэша Gradle):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup --offline
#
# 7) ZIP ЛЕЖИТ НЕ В DOWNLOADS (путь к архиву в конце):
#
#   cp /mnt/c/Users/*/Downloads/setup-and-build-gt2.sh ~/ && bash ~/setup-and-build-gt2.sh --skip-setup /mnt/c/Users/ИМЯ/Desktop/gt2-android.zip
#
# Готовый APK копируется в Downloads под именем gt2-android-debug.apk.
#
# -----------------------------------------------------------------------------
# ПАРАМЕТРЫ:
#   (без параметров)  Быстрая сборка С КЭШЕМ. Из zip в проект копируются только файлы, которые
#                     изменились (сравнение по содержимому), удалённые из zip файлы удаляются.
#   --skip-setup      Не проверять и не ставить apt, SDK, NDK, Gradle. Используй после того,
#                     как первая установка (команда 1) уже прошла.
#   --clean           БЕЗ КЭША: удаляются android/app/build, android/app/.cxx и android/.gradle,
#                     потом всё компилируется заново. Скачанные плагины Gradle (~/.gradle) остаются.
#   --fresh           Удалить папку проекта в WSL, распаковать zip заново, собрать без кэша.
#   --purge-cache     Дополнительно удалить общий кэш Gradle (~/.gradle/caches). Нужен интернет.
#   --offline         Не ходить в сеть, собрать из кэша Gradle.
#   --no-copy         Не копировать APK в Windows (останется в проекте).
#   --src ПАПКА       Собрать из готовой папки в WSL вместо zip (обычно не нужно).
#   путь.zip          Взять архив не из Downloads, а по указанному пути.
#   -h, --help        Показать эту справку.
# =============================================================================
set -euo pipefail

# ---------- настройки ----------
ZIP_NAME="gt2-android.zip"
WORK_DIR="$HOME/gt2work"
PROJECT_DIR_NAME="gt2-android"

export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
NDK_VERSION="27.2.12479018"
BUILD_TOOLS_VERSION="36.0.0"
PLATFORM="android-36"
CMAKE_VERSION="3.22.1"
GRADLE_VERSION="8.13"
CMDLINE_TOOLS_ZIP="commandlinetools-linux-11076708_latest.zip"

GRADLE_HOME="$HOME/gradle-$GRADLE_VERSION"

log()  { printf '\n\033[1;32m==> %s\033[0m\n' "$*"; }
warn() { printf '\n\033[1;33mВнимание: %s\033[0m\n' "$*"; }
die()  { printf '\n\033[1;31mОшибка: %s\033[0m\n' "$*" >&2; exit 1; }

usage() { sed -n '2,/^set -euo/p' "$0" | sed '$d' | sed 's/^# \{0,1\}//'; }

# ---------- аргументы ----------
ZIP_PATH=""
SRC_DIR=""
BUILD_ARGS=()
CLEAN=0
FRESH=0
PURGE=0
SKIP_SETUP=0
NO_COPY=0
while [ $# -gt 0 ]; do
  case "$1" in
    --offline)     BUILD_ARGS+=("--offline") ;;
    --clean)       CLEAN=1 ;;
    --fresh)       FRESH=1 ;;
    --purge-cache) PURGE=1 ;;
    --skip-setup)  SKIP_SETUP=1 ;;
    --no-copy)     NO_COPY=1 ;;
    --src)         shift; [ $# -gt 0 ] || die "--src требует путь к папке проекта"; SRC_DIR="$1" ;;
    -h|--help)     usage; exit 0 ;;
    *.zip)         ZIP_PATH="$1" ;;
    *)             echo "Неизвестный аргумент: $1 (см. --help)"; exit 1 ;;
  esac
  shift
done
[ -z "$SRC_DIR" ] || [ -z "$ZIP_PATH" ] || die "Укажи что-то одно: --src ПАПКА или путь к zip."
[ -z "$SRC_DIR" ] || [ "$FRESH" -eq 0 ] || die "--fresh не совместим с --src (он удалил бы твою папку с правками)."

# ---------- 0. проверки ----------
[ "$(uname -s)" = "Linux" ] || die "Запускать нужно внутри WSL (Ubuntu)."
[ "$(uname -m)" = "x86_64" ] || die "Нужна x86_64 система: NDK-инструменты Android под arm64 Linux не работают."

SDKMANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"

if [ "$SKIP_SETUP" -eq 0 ]; then
  # ---------- 1. системные пакеты ----------
  need_apt=0
  for c in javac unzip zip curl wget git file rsync make; do
    command -v "$c" >/dev/null 2>&1 || need_apt=1
  done
  if [ "$need_apt" -eq 1 ]; then
    log "Установка системных пакетов (потребуется пароль sudo)"
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends \
      openjdk-17-jdk-headless unzip zip curl wget ca-certificates git file rsync \
      build-essential
  else
    log "Системные пакеты уже установлены"
  fi

  # ---------- 2. Android command-line tools ----------
  if [ ! -x "$SDKMANAGER" ]; then
    log "Скачивание Android command-line tools"
    mkdir -p "$ANDROID_HOME/cmdline-tools"
    tmp="$(mktemp -d)"
    curl -fL --retry 3 -o "$tmp/cmdline-tools.zip" \
      "https://dl.google.com/android/repository/$CMDLINE_TOOLS_ZIP"
    unzip -q "$tmp/cmdline-tools.zip" -d "$tmp"
    rm -rf "$ANDROID_HOME/cmdline-tools/latest"
    mv "$tmp/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"
    rm -rf "$tmp"
  else
    log "Android command-line tools уже установлены"
  fi

  # ---------- 3. SDK / NDK / CMake ----------
  if [ ! -d "$ANDROID_HOME/ndk/$NDK_VERSION" ] || [ ! -d "$ANDROID_HOME/platforms/$PLATFORM" ] \
     || [ ! -d "$ANDROID_HOME/build-tools/$BUILD_TOOLS_VERSION" ] || [ ! -d "$ANDROID_HOME/cmake/$CMAKE_VERSION" ]; then
    log "Принятие лицензий Android SDK"
    # `yes` получает SIGPIPE, когда sdkmanager закончил читать — это нормально.
    set +o pipefail
    yes | "$SDKMANAGER" --sdk_root="$ANDROID_HOME" --licenses >/dev/null
    set -o pipefail

    log "Установка платформы, build-tools, NDK и CMake (это долго, ~2-3 ГБ)"
    "$SDKMANAGER" --sdk_root="$ANDROID_HOME" \
      "platform-tools" \
      "platforms;$PLATFORM" \
      "build-tools;$BUILD_TOOLS_VERSION" \
      "ndk;$NDK_VERSION" \
      "cmake;$CMAKE_VERSION"
  else
    log "Android SDK / NDK / CMake уже установлены"
  fi

  [ -d "$ANDROID_HOME/ndk/$NDK_VERSION" ] || die "NDK $NDK_VERSION не установился."
  [ -x "$ANDROID_HOME/ndk/$NDK_VERSION/shader-tools/linux-x86_64/glslc" ] \
    || die "glslc не найден в NDK."

  # ---------- 4. Gradle ----------
  if [ ! -x "$GRADLE_HOME/bin/gradle" ]; then
    log "Скачивание Gradle $GRADLE_VERSION"
    tmp="$(mktemp -d)"
    curl -fL --retry 3 -o "$tmp/gradle.zip" \
      "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip"
    unzip -q "$tmp/gradle.zip" -d "$HOME"
    rm -rf "$tmp"
  else
    log "Gradle $GRADLE_VERSION уже установлен"
  fi
else
  log "Пропуск установки окружения (--skip-setup)"
  [ -d "$ANDROID_HOME/ndk/$NDK_VERSION" ] || die "NDK не найден. Запусти без --skip-setup."
  [ -x "$GRADLE_HOME/bin/gradle" ]        || die "Gradle не найден. Запусти без --skip-setup."
  command -v javac >/dev/null 2>&1        || die "JDK не найден. Запусти без --skip-setup."
  command -v rsync >/dev/null 2>&1 || [ -n "$SRC_DIR" ] || die "rsync не найден. Запусти без --skip-setup."
fi

export JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"
export PATH="$GRADLE_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
log "JAVA_HOME=$JAVA_HOME"
gradle --version | head -n 8

# ---------- 5. Windows Downloads ----------
find_windows_downloads() {
  local win_profile="" d=""
  if command -v cmd.exe >/dev/null 2>&1; then
    win_profile="$(cd /mnt/c 2>/dev/null && cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r' || true)"
    if [ -n "$win_profile" ] && command -v wslpath >/dev/null 2>&1; then
      d="$(wslpath -u "$win_profile" 2>/dev/null || true)/Downloads"
      [ -d "$d" ] && { echo "$d"; return 0; }
    fi
  fi
  # запасной вариант: перебор профилей /mnt/c/Users/*
  for d in /mnt/c/Users/*/Downloads; do
    [ -d "$d" ] && { echo "$d"; return 0; }
  done
  return 1
}

WIN_DOWNLOADS=""
if [ -n "$SRC_DIR" ]; then
  # сборка из готовой папки: zip не нужен, Downloads нужна только для копии APK
  [ -d "$SRC_DIR" ] || die "Папка не найдена: $SRC_DIR"
  PROJECT_DIR="$(cd "$SRC_DIR" && pwd)"
  [ -x "$PROJECT_DIR/scripts/build-android.sh" ] || [ -f "$PROJECT_DIR/scripts/build-android.sh" ] \
    || die "В $PROJECT_DIR нет scripts/build-android.sh - это не папка проекта."
  WIN_DOWNLOADS="$(find_windows_downloads || true)"
  log "Сборка из папки: $PROJECT_DIR"
else
  if [ -z "$ZIP_PATH" ]; then
    WIN_DOWNLOADS="$(find_windows_downloads || true)"
    [ -n "$WIN_DOWNLOADS" ] || die "Не нашёл папку Downloads Windows. Передай путь к zip аргументом."
    ZIP_PATH="$WIN_DOWNLOADS/$ZIP_NAME"
  else
    WIN_DOWNLOADS="$(dirname "$ZIP_PATH")"
  fi
  [ -f "$ZIP_PATH" ] || die "Файл не найден: $ZIP_PATH"
  log "Архив: $ZIP_PATH"

  # ---------- 6. обновление проекта из zip ----------
  PROJECT_DIR="$WORK_DIR/$PROJECT_DIR_NAME"
  mkdir -p "$WORK_DIR"
  if [ "$FRESH" -eq 1 ] && [ -d "$PROJECT_DIR" ]; then
    log "--fresh: удаляю папку проекта $PROJECT_DIR"
    rm -rf "$PROJECT_DIR"
  fi

  tmp_extract="$(mktemp -d)"
  trap 'rm -rf "$tmp_extract"' EXIT
  unzip -q "$ZIP_PATH" -d "$tmp_extract"
  [ -d "$tmp_extract/$PROJECT_DIR_NAME" ] || die "В архиве нет папки $PROJECT_DIR_NAME"

  mkdir -p "$PROJECT_DIR"
  log "Обновление проекта в $PROJECT_DIR (копируются только изменившиеся файлы)"
  # Сравнение по содержимому (-c): изменённые файлы получают НОВОЕ время изменения,
  # поэтому сборка гарантированно их перекомпилирует, а неизменённые не трогаются.
  # Файлы, которых нет в zip, удаляются (--delete); кэш сборки защищён исключениями.
  changed="$(rsync -rc --delete --out-format='%n' \
      --exclude='/android/app/build/' --exclude='/android/app/.cxx/' \
      --exclude='/android/.gradle/' --exclude='/android/build/' \
      --exclude='/android/local.properties' \
      "$tmp_extract/$PROJECT_DIR_NAME/" "$PROJECT_DIR/")" || die "rsync не смог обновить проект."
  changed="$(printf '%s\n' "$changed" | grep -v '/$' | grep -v '^$' || true)"
  if [ -n "$changed" ]; then
    echo "Изменённые/новые файлы:"; echo "$changed" | sed 's/^/  /' | head -n 60
    n="$(echo "$changed" | wc -l)"; [ "$n" -le 60 ] || echo "  ... и ещё $((n-60))"
  else
    echo "Файлы проекта не изменились."
  fi
fi

# на случай CRLF-окончаний строк и потери прав на запуск
find "$PROJECT_DIR/scripts" -type f -name '*.sh' -exec sed -i 's/\r$//' {} +
chmod +x "$PROJECT_DIR"/scripts/*.sh

# ---------- очистка кэша ----------
if [ "$CLEAN" -eq 1 ] || [ "$FRESH" -eq 1 ]; then
  log "Очистка кэша сборки проекта"
  rm -rf "$PROJECT_DIR/android/app/build" "$PROJECT_DIR/android/app/.cxx" \
         "$PROJECT_DIR/android/.gradle" "$PROJECT_DIR/android/build"
fi
if [ "$PURGE" -eq 1 ]; then
  warn "Удаляю глобальный кэш Gradle (~/.gradle/caches): потребуется интернет, сборка будет долгой"
  rm -rf "$HOME/.gradle/caches"
  # без сети такая сборка невозможна
  for a in "${BUILD_ARGS[@]+"${BUILD_ARGS[@]}"}"; do
    [ "$a" != "--offline" ] || die "--purge-cache несовместим с --offline."
  done
fi

# ---------- 7. сборка ----------
if [ "$CLEAN" -eq 1 ] || [ "$FRESH" -eq 1 ] || [ "$PURGE" -eq 1 ]; then
  log "Сборка APK С НУЛЯ (полная компиляция C++, это долго)"
else
  log "Сборка APK (инкрементальная: перекомпилируется только изменённое)"
fi
cd "$PROJECT_DIR"
./scripts/build-android.sh ${BUILD_ARGS[@]+"${BUILD_ARGS[@]}"}

APK="$PROJECT_DIR/android/app/build/outputs/apk/debug/app-debug.apk"
[ -f "$APK" ] || die "APK не найден: $APK"

# ---------- 8. копирование результата ----------
log "Готово!"
echo "APK в WSL:     $APK"
if [ "$NO_COPY" -eq 1 ]; then
  echo "(копирование в Windows отключено: --no-copy)"
elif [ -z "$WIN_DOWNLOADS" ] || [ ! -d "$WIN_DOWNLOADS" ]; then
  warn "Не нашёл папку Downloads Windows: APK не скопирован, забери его по пути выше."
else
  OUT="$WIN_DOWNLOADS/gt2-android-debug.apk"
  cp -f "$APK" "$OUT"
  echo "APK в Windows: $OUT"
  if command -v wslpath >/dev/null 2>&1; then
    echo "Путь Windows:  $(wslpath -w "$OUT")"
  fi
fi
