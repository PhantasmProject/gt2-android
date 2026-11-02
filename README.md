<div align="center">

<img src="assets/gt2-android-logo.png" alt="GT2 Android logo" width="420">

# GT2 Android

**Gran Turismo 2 — Android touchscreen adaptation**

[![Platform](https://img.shields.io/badge/platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](#)
[![Architecture](https://img.shields.io/badge/architecture-ARM64-168BFF?style=for-the-badge)](#)
[![License](https://img.shields.io/badge/license-MIT-30A46C?style=for-the-badge)](LICENSE)
[![Status](https://img.shields.io/badge/status-in%20development-orange?style=for-the-badge)](#project-status--статус-проекта)

*Bringing the classic Gran Turismo 2 experience to Android touchscreens.*

</div>

---

## 🇬🇧 English

### About

**GT2 Android** is an independent adaptation of the Android/VR codebase from the original **Gran Turismo 2 PC & VR** project, with a different target in mind: **Android phones and tablets with touchscreen controls**.

The work focuses on adapting the driving experience and interface for touch input while removing VR-specific functionality and dependencies. The intended result is a regular, flat-screen Android application — **not a VR app**.

This project builds on the work published by **Yevhen Dubrovskiy**:

➡️ **[Original project: dubrovskiy-yevhen-stakelogic/gt-2-pc](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)**

This repository is for the Android touchscreen adaptation. It is not the original PC project, and the original author's work is credited below.

### Project goals

- Adapt the game for Android phones and tablets.
- Replace VR-oriented interaction with touchscreen controls.
- Adapt the on-screen interface for mobile displays.
- Remove VR-only systems, code paths and dependencies where they are not needed for the Android touchscreen build.
- Preserve the original gameplay experience as much as the Android platform allows.

### Platform

| Target | Support |
|---|---|
| Android phones | Main target |
| Android tablets | Intended target |
| VR headsets / OpenXR | Not a target of this project |

Device compatibility, Android version requirements and graphics-driver requirements will be documented after testing and should be treated as build-specific.

### Touch controls

The project is being adapted around touchscreen input. Details such as button layout, steering controls, sensitivity and interface options will be documented here as the implementation stabilizes.

### Project status

🚧 **Work in progress.** The Android touchscreen adaptation and removal of VR-specific functionality are ongoing. Build instructions, screenshots, tested-device information and release packages will be added when they are ready.

### Building and installation

Build and installation instructions will be added after the Android-only configuration is finalized and tested.

For background and upstream project documentation, see:
- [Original repository](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)
- [Original Android documentation](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc/blob/main/docs/ANDROID.md)
- [Original Quest/VR documentation](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc/blob/main/docs/QUEST.md) — referenced only as part of the upstream project's history; Quest/VR is not a target of this adaptation.

### Game data and legal notice

This repository does **not** include Gran Turismo 2 disc images, BIOS/firmware, copyrighted game assets or save files. Users must provide their own legally obtained game data. Do not upload disc images, BIOS files or copyrighted game content to this repository.

Gran Turismo, Gran Turismo 2 and related marks are the property of their respective owners. This is an independent community project and is not affiliated with, endorsed by, or sponsored by Sony Interactive Entertainment or Polyphony Digital.

### Credits & special thanks

A special thank-you to **[Yevhen Dubrovskiy](https://github.com/dubrovskiy-yevhen-stakelogic)** for creating and publishing the original **[Gran Turismo 2 PC & VR](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)** project.

This Android touchscreen adaptation is based on that project's work. We are grateful for the original engineering, research and implementation that provided the foundation for this adaptation.

All other third-party components must retain their original notices and license terms. See `THIRD_PARTY.md` if/when it is included in this repository.

### License

See [LICENSE](LICENSE) for the license text included with the supplied source archive. The license applies only to the material it covers; it does not grant rights to Gran Turismo trademarks, game data, firmware or other third-party copyrighted material. Preserve all upstream copyright and license notices when publishing source code.

---

## 🇷🇺 Русский

### О проекте

**GT2 Android** — независимая адаптация Android/VR-кодовой базы оригинального проекта **Gran Turismo 2 PC & VR**, но с другой целью: **запуск на Android-смартфонах и планшетах с сенсорным управлением**.

Основная задача — адаптировать игровой процесс и интерфейс под управление касаниями, одновременно удаляя VR-функциональность и связанные с ней зависимости. В результате должно получиться обычное Android-приложение с плоским изображением на экране, **а не VR-приложение**.

Проект основан на работе **Yevhen Dubrovskiy**:

➡️ **[Оригинальный проект: dubrovskiy-yevhen-stakelogic/gt-2-pc](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)**

Этот репозиторий посвящён именно Android-адаптации с сенсорным управлением. Это не оригинальный PC-проект; авторство исходной работы отдельно указано ниже.

### Цели проекта

- Адаптация игры для Android-смартфонов и планшетов.
- Замена VR-ориентированного взаимодействия сенсорным управлением.
- Адаптация экранного интерфейса под мобильные дисплеи.
- Удаление VR-компонентов, VR-кода и зависимостей, которые не нужны для Android-версии с сенсорным управлением.
- Максимально возможное сохранение оригинального игрового процесса с учётом особенностей Android.

### Платформа

| Цель | Поддержка |
|---|---|
| Android-смартфоны | Основная платформа |
| Android-планшеты | Планируемая платформа |
| VR-гарнитуры / OpenXR | Не являются целью проекта |

Совместимость устройств, требования к версии Android и графическим драйверам будут описаны после тестирования. Эти требования могут зависеть от конкретной сборки.

### Сенсорное управление

Проект адаптируется под управление касаниями. Раскладка кнопок, управление рулём, чувствительность и настройки интерфейса будут описаны здесь после стабилизации реализации.

### Статус проекта

🚧 **В разработке.** Адаптация Android-версии под сенсорное управление и удаление VR-функциональности продолжаются. Инструкции по сборке, скриншоты, список проверенных устройств и готовые релизы появятся по мере готовности.

### Сборка и установка

Инструкции по сборке и установке будут добавлены после завершения настройки Android-only конфигурации и её тестирования.

Документация исходного проекта:
- [Оригинальный репозиторий](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)
- [Исходная документация Android](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc/blob/main/docs/ANDROID.md)
- [Документация Quest/VR оригинального проекта](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc/blob/main/docs/QUEST.md) — приведена только как часть истории исходного проекта; Quest/VR не является целью этой адаптации.

### Игровые данные и юридическая информация

В этом репозитории **не распространяются** образы дисков Gran Turismo 2, BIOS/прошивки, игровые ресурсы, защищённые авторским правом, или файлы сохранений. Пользователь должен самостоятельно предоставить собственные легально полученные игровые данные. Не загружайте в репозиторий образы дисков, BIOS и другие материалы, защищённые авторским правом.

Gran Turismo, Gran Turismo 2 и связанные с ними товарные знаки принадлежат соответствующим правообладателям. Это независимый проект сообщества, не связанный с Sony Interactive Entertainment или Polyphony Digital и не одобренный ими.

### Благодарности и авторство

Отдельная благодарность **[Yevhen Dubrovskiy](https://github.com/dubrovskiy-yevhen-stakelogic)** — автору оригинального проекта **[Gran Turismo 2 PC & VR](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)**.

Эта Android-адаптация основана на его работе. Спасибо за оригинальную инженерную реализацию, исследования и проделанную разработку, которые стали основой для дальнейшей адаптации под сенсорное управление.

Для всех сторонних компонентов необходимо сохранять исходные уведомления об авторстве и условия лицензий. Список зависимостей будет указан в `THIRD_PARTY.md`, если этот файл будет добавлен в репозиторий.

### Лицензия

Текст лицензии, включённый в предоставленный архив исходников, находится в файле [LICENSE](LICENSE). Лицензия распространяется только на материалы, которые она покрывает; она не предоставляет прав на товарные знаки Gran Turismo, игровые данные, прошивки и другие сторонние материалы, защищённые авторским правом. При публикации исходников сохраняйте все уведомления об авторстве и лицензиях оригинального проекта.

---

<div align="center">

**Built with respect for the original work. / Создано с уважением к оригинальной работе.**

</div>
