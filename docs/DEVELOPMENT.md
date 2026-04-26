# Development Notes

This document gives a practical overview for maintaining the SD Plotter DB source.

## Desktop application

The desktop application is written as a Processing sketch.

Path:

```text
src/processing/SDPlotterDB/
```

Main entry point:

```text
SDPlotterDB.pde
```

Important source files:

| File | Purpose |
| --- | --- |
| `SDPlotterDB.pde` | Main application imports, global setup and primary program structure. |
| `Communication.pde` | Communication and runtime data update logic. |
| `Database.pde` | Database routines. |
| `ConnectToDB.pde` | Database connection support. |
| `Settings.pde` | Settings, calibration, communication parameters and configuration UI. |
| `Control.pde` | Actuator control interface and method-related controls. |
| `Condition.pde` | Condition-based relay/method control logic. |
| `GraphSettings.pde` | Graph configuration. |
| `Buttons.pde` | Button definitions and UI behavior. |
| `Resources.pde` | Interface resources and helper elements. |
| `CreateData.pde` | Data creation/export routines. |
| `SimulatedSerial.pde` | Simulated serial/demo support. |
| `WinLogin.pde` | Login and user-access routines. |
| `WinClose.pde` | Window-closing behavior. |

## Processing dependencies

The source imports and uses Processing core APIs, Processing Serial, ControlP5, Grafica, Java SQL APIs, Apache Derby network server/control classes and Java crypto/security utilities.

Apache Derby JAR files are stored in:

```text
src/processing/SDPlotterDB/code/
```

## Arduino firmware

Firmware paths:

```text
firmware/arduino-without-ethernet/SDPlotterDB/
firmware/arduino-with-ethernet/SDPlotterDB/
```

Important firmware modules include `SDPlotterDB.ino`, `Capture_Data.ino`, `Command.ino`, `EEPROM.ino`, `Engine_control.ino`, `Ethernet.ino`, `mode_read_signal.ino` and `Send_Data.ino`.

## Recommended development workflow

1. Create a branch for each change.
2. Keep Processing and Arduino changes separate when possible.
3. Test firmware compilation before changing the desktop communication layer.
4. Test desktop operation in demo mode before connecting hardware.
5. Test serial communication with safe bench hardware.
6. Validate CSV export after changing acquisition logic.
7. Validate database functions after changing Derby-related code.
8. Update documentation when changing pins, shortcuts or user workflows.

## GitHub release workflow

1. Update source code.
2. Confirm Arduino firmware compiles.
3. Confirm Processing sketch runs.
4. Test login and settings.
5. Test demo mode.
6. Test serial connection.
7. Test data recording and CSV export.
8. Test database view and export.
9. Update `CHANGELOG.md`.
10. Build the Windows `.exe` installer externally.
11. Upload compiled release to Archive.org, MEGA or GitHub Releases.
12. Update `docs/RELEASES.md`.

## Sensitive files

Do not commit local database files, exported CSV files from real industrial tests, user/password database files, license keys, machine-specific configuration files or compiled installers unless intentionally published as release assets.
