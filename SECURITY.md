# Security and Safety Policy

SD Plotter DB can interact with physical hardware and process-control equipment. Reports that involve unsafe output behavior, unauthorized access, credential handling, database exposure, firmware upload behavior or hardware-control risks should be treated seriously.

## Reporting

Please contact the author:

```text
spidoug@gmail.com
```

Include software version, firmware variant, Arduino board, communication mode, steps to reproduce, screenshots/logs when safe and whether physical outputs were connected.

## Safety guidance

Before using this project with real equipment, change the default administrator password, avoid shared administrator accounts, validate all output states, use safe test loads, protect relay/motor/heater circuits, use emergency-stop systems where required and do not rely only on software for safety-critical shutdown.
