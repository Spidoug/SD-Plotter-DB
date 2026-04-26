#include <EEPROM.h>

int eepromApagada = 0;

void setup() {

  for (int i = 0; i < EEPROM.length(); i++) {
    eepromApagada = EEPROM.read(i);
    if (eepromApagada > 0) {
      for (int i = 0; i < EEPROM.length(); i++) {
        EEPROM.write(i, 0);
      }
    }
  }
}

void loop() {
}
