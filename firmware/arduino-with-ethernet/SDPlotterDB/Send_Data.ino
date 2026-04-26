void senddata() {

  /////////////////////////////////////////////////////////////////////////////

  if (commaster == 1) {

    for (uint8_t i = 0; i < 12; i++) {

      switch (i) {

        case 6:

          if (vals [2] > 0) {
            Serial1.print(9900);
          }
          break;

        case 0:
          Serial1.print(value0);
          break;

        case 1:
          Serial1.print(value1);
          break;

        case 2:
          Serial1.print(value2);
          break;

        case 3:
          Serial1.print(value3);
          break;

        case 4:
          Serial1.print(value4);
          break;

        case 5:
          Serial1.print(value5);
          break;

        case 7:
          Serial1.print(value7);
          break;

        case 8:
          Serial1.print(value8);
          break;

        case 9:
          Serial1.print(value9);
          break;

        case 10:
          Serial1.print(value10);
          break;

        case 11:
          Serial1.print(value11);
          break;

      }

      if (i == 12)
        Serial1.print(",");

    }
    Serial1.print("\r");

  }

  ///////////////////////////////////////////////////////////////////////////

  if (commaster == 0) {

    for (uint8_t i = 0; i < 12; i++) {

      switch (i) {

        case 6:

          if (vals [2] > 0 ) {
            Serial.print(9900);
          }
          break;

        case 0:
          Serial.print(value0);
          break;

        case 1:
          Serial.print(value1);
          break;

        case 2:
          Serial.print(value2);
          break;

        case 3:
          Serial.print(value3);
          break;

        case 4:
          Serial.print(value4);
          break;

        case 5:
          Serial.print(value5);
          break;

        case 7:
          Serial.print(value7);
          break;

        case 8:
          Serial.print(value8);
          break;

        case 9:
          Serial.print(value9);
          break;

        case 10:
          Serial.print(value10);
          break;

        case 11:
          Serial.print(value11);
          break;
      }

      if (i < 12)
        Serial.print(",");
    }
    Serial.print("\r");
  }
}
