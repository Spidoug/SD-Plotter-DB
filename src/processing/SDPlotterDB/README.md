# SD Plotter DB Processing Source

This folder contains the Processing sketch that implements the SD Plotter DB desktop application.

Main entry point:

- `SDPlotterDB.pde`

Important modules:

- `Communication.pde` - acquisition and runtime communication logic.
- `Database.pde` and `ConnectToDB.pde` - Apache Derby database routines.
- `Settings.pde` - sensor, communication, PID, user and calibration settings.
- `Control.pde` and `Condition.pde` - actuator control and condition-based automation.
- `Resources.pde` - UI resources and helper routines.

The `code/` folder includes Apache Derby JAR files used by the Processing sketch.
The `lib/src/` folder contains image assets used by the application interface.
