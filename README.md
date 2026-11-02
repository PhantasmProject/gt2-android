[🇬🇧 English](#english) | [🇷🇺 Русский](#русский)

<div align="center">

<img src="assets/gt2-android-logo.png" alt="GT2 Android logo" width="420">

# GT2 Android

**Gran Turismo 2 Android Port, featuring touchscreen controls and a mobile-optimized interface.**

[![Platform](https://img.shields.io/badge/platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](#)
[![Architecture](https://img.shields.io/badge/architecture-ARM64-168BFF?style=for-the-badge)](#)
[![Graphics](https://img.shields.io/badge/graphics-Vulkan%201.3-7B61FF?style=for-the-badge)](#requirements)
[![Status](https://img.shields.io/badge/status-in%20development-orange?style=for-the-badge)](#project-status)

*Bringing the classic Gran Turismo 2 experience to Android touchscreens.*

</div>

---

## 🇬🇧 English

### About

**GT2 Android** is an Android port of Gran Turismo 2, adapted for regular 2D screens and touchscreen gameplay. It is based on the Android version of the original project, which was developed for VR, and has been reworked for mobile touch controls.

The goal is to provide a traditional, non-VR Android game experience with a customizable touch interface.

This project builds on the work of **Yevhen Dubrovskiy**. See [Credits](#credits--special-thanks) for the original project link and acknowledgement.

### Implemented features

- **Three steering control types:** virtual steering wheel, steering slider, and left/right buttons.
- **Steering sensitivity adjustment.**
- **Throttle response adjustment** to customize pedal input.
- **Customizable HUD layout:** move and resize on-screen elements.
- **Touch-button vibration feedback.**
- **Vibration effects** for collisions and driving over the road surface.
- **Live settings:** control and interface changes are applied immediately, without restarting the game.

### Screenshots

The screenshots below show the current state of the Android version and its implemented touch controls and interface options.

#### Touch controls and gameplay

| Virtual steering wheel | Steering slider |
|:---:|:---:|
| <img src="assets/screenshots/steering-wheel.png" alt="Virtual steering wheel" width="100%"> | <img src="assets/screenshots/steering-slider.png" alt="Steering slider" width="100%"> |

| Left/right steering buttons | Touch control settings |
|:---:|:---:|
| <img src="assets/screenshots/steering-buttons.png" alt="Left and right steering buttons" width="100%"> | <img src="assets/screenshots/touch-settings-menu.png" alt="Touch control settings menu" width="100%"> |

#### Touch control editor

| Steering control settings | Throttle pedal settings |
|:---:|:---:|
| <img src="assets/screenshots/steering-editor.png" alt="Steering control editor" width="100%"> | <img src="assets/screenshots/throttle-editor.png" alt="Throttle pedal editor" width="100%"> |

#### HUD customization and game settings

| HUD layout editor | HUD layout screen |
|:---:|:---:|
| <img src="assets/screenshots/hud-layout-editor.png" alt="HUD layout editor" width="100%"> | <img src="assets/screenshots/hud-layout-screen.png" alt="HUD layout screen" width="100%"> |

| Graphics and performance settings | Game menu |
|:---:|:---:|
| <img src="assets/screenshots/graphics-settings.png" alt="Graphics and performance settings" width="100%"> | <img src="assets/screenshots/game-menu.png" alt="Game menu" width="100%"> |

### Requirements

- Android device with **ARM64** support.
- **Vulkan 1.3 support is required.**

### Tested devices

Testing has so far been performed only on these two devices:

| Device | SoC | GPU |
|---|---|---|
| Google Pixel 3 XL | Qualcomm Snapdragon 845 | Adreno 630 |
| Samsung Galaxy S24 Ultra | Qualcomm Snapdragon 8 Gen 3 | Adreno 750 |

Compatibility with other devices has not yet been confirmed. Performance and compatibility may vary depending on the device, Android version and graphics drivers.

### Planned features and improvements

- Add support for loading custom music playlists in **MP3, FLAC and WAV** formats.
- Further performance optimization.
- Bug fixing and general stability improvements.

### Project status

🚧 **Work in progress.** The features listed above describe the current development state; compatibility with devices other than those listed under Tested devices has not yet been verified.

### Credits & special thanks

A special thank-you to **[Yevhen Dubrovskiy](https://github.com/dubrovskiy-yevhen-stakelogic)** for creating and publishing the original **[Gran Turismo 2 PC & VR](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)** project.

GT2 Android is based on the Android/VR work from that project and adapts it for flat-screen Android gameplay with touchscreen controls. We are grateful for the original engineering, research and implementation that made this adaptation possible.

### Game data and legal notice

This repository does **not** include Gran Turismo 2 disc images, BIOS/firmware, copyrighted game assets or save files. Users must provide their own legally obtained game data. Do not upload disc images, BIOS files or copyrighted game content to this repository.

Gran Turismo, Gran Turismo 2 and related marks are the property of their respective owners. This is an independent community project and is not affiliated with, endorsed by, or sponsored by Sony Interactive Entertainment or Polyphony Digital.

### License

See [LICENSE](LICENSE) for the license text included with the supplied source archive. The license applies only to the material it covers; it does not grant rights to Gran Turismo trademarks, game data, firmware or other third-party copyrighted material. Preserve all upstream copyright and license notices when publishing source code.

---

## 🇷🇺 Русский

### О проекте

**GT2 Android** — порт Gran Turismo 2 для Android, адаптированный для обычных 2D-экранов и сенсорного управления. Он основан на Android-версии оригинального проекта, изначально разрабатывавшегося для VR, и переработан для управления касаниями на мобильных устройствах.

Цель проекта — создать обычную Android-игру без VR с настраиваемым сенсорным интерфейсом.

Проект основан на работе **Yevhen Dubrovskiy**. Ссылка на оригинальный проект и благодарность автору приведены в разделе [«Благодарности и авторство»](#благодарности-и-авторство).

### Реализованные возможности

- **Три типа управления рулём:** виртуальный руль, ползунок и кнопки поворота влево/вправо.
- **Настройка чувствительности руля.**
- **Настройка отклика газа** для изменения реакции на нажатие педали.
- **Настройка расположения и размера HUD:** экранные элементы можно перемещать и масштабировать.
- **Вибрация при нажатии на сенсорные кнопки.**
- **Вибрация при столкновениях и движении по дорожному покрытию.**
- **Применение настроек без перезапуска игры:** изменения управления и интерфейса вступают в силу сразу.

### Скриншоты

На скриншотах показано текущее состояние Android-версии, реализованные варианты сенсорного управления и настройки интерфейса.

#### Сенсорное управление и игровой процесс

| Виртуальный руль | Ползунок управления рулём |
|:---:|:---:|
| <img src="assets/screenshots/steering-wheel.png" alt="Виртуальный руль" width="100%"> | <img src="assets/screenshots/steering-slider.png" alt="Ползунок управления рулём" width="100%"> |

| Кнопки поворота влево/вправо | Игровой процесс с сенсорным управлением |
|:---:|:---:|
| <img src="assets/screenshots/steering-buttons.png" alt="Кнопки поворота" width="100%"> | <img src="assets/screenshots/touch-settings-menu.png" alt="Меню сенсорного управления" width="100%"> |

#### Редактор сенсорного управления

| Настройки руля | Настройки педали газа |
|:---:|:---:|
| <img src="assets/screenshots/steering-editor.png" alt="Редактор руля" width="100%"> | <img src="assets/screenshots/throttle-editor.png" alt="Редактор педали газа" width="100%"> |

#### Настройка HUD и меню игры

| Редактор расположения HUD | Экран настройки HUD |
|:---:|:---:|
| <img src="assets/screenshots/hud-layout-editor.png" alt="Редактор HUD" width="100%"> | <img src="assets/screenshots/hud-layout-screen.png" alt="Экран настройки HUD" width="100%"> |

| Настройки графики и производительности | Игровое меню |
|:---:|:---:|
| <img src="assets/screenshots/graphics-settings.png" alt="Настройки графики и производительности" width="100%"> | <img src="assets/screenshots/game-menu.png" alt="Игровое меню" width="100%"> |

### Системные требования

- Android-устройство с поддержкой **ARM64**.
- **Обязательная поддержка Vulkan 1.3.**

### Проверенные устройства

На данный момент тестирование проводилось только на двух устройствах:

| Устройство | Процессор | Графический процессор |
|---|---|---|
| Google Pixel 3 XL | Qualcomm Snapdragon 845 | Adreno 630 |
| Samsung Galaxy S24 Ultra | Qualcomm Snapdragon 8 Gen 3 | Adreno 750 |

Совместимость с другими устройствами пока не подтверждена. Производительность и совместимость могут отличаться в зависимости от устройства, версии Android и графических драйверов.

### Планы и дальнейшие улучшения

- Добавить возможность загружать собственные музыкальные плейлисты в форматах **MP3, FLAC и WAV**.
- Дальнейшая оптимизация производительности.
- Исправление ошибок и повышение общей стабильности.

### Статус проекта

🚧 **В разработке.** Перечисленные выше возможности отражают текущее состояние проекта. Работа на устройствах, не указанных в разделе «Проверенные устройства», пока не подтверждена.

### Благодарности и авторство

Отдельная благодарность **[Yevhen Dubrovskiy](https://github.com/dubrovskiy-yevhen-stakelogic)** — автору оригинального проекта **[Gran Turismo 2 PC & VR](https://github.com/dubrovskiy-yevhen-stakelogic/gt-2-pc)**.

GT2 Android основан на Android/VR-разработке этого проекта и адаптирует её для обычного Android-экрана с сенсорным управлением. Спасибо за оригинальную инженерную реализацию, исследования и проделанную работу, которые сделали эту адаптацию возможной.

### Игровые данные и юридическая информация

В этом репозитории **не распространяются** образы дисков Gran Turismo 2, BIOS/прошивки, игровые ресурсы, защищённые авторским правом, или файлы сохранений. Пользователь должен самостоятельно предоставить собственные легально полученные игровые данные. Не загружайте в репозиторий образы дисков, BIOS и другие материалы, защищённые авторским правом.

Gran Turismo, Gran Turismo 2 и связанные с ними товарные знаки принадлежат соответствующим правообладателям. Это независимый проект сообщества, не связанный с Sony Interactive Entertainment или Polyphony Digital и не одобренный ими.

### Лицензия

Текст лицензии, включённый в предоставленный архив исходников, находится в файле [LICENSE](LICENSE). Лицензия распространяется только на материалы, которые она покрывает; она не предоставляет прав на товарные знаки Gran Turismo, игровые данные, прошивки и другие сторонние материалы, защищённые авторским правом. При публикации исходников сохраняйте все уведомления об авторстве и лицензиях оригинального проекта.

---

<div align="center">

**Built with respect for the original work. / Создано с уважением к оригинальной работе.**

</div>
