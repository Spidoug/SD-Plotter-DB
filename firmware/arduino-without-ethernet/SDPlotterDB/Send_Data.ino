void senddata() {

  if (commaster == 1) {

    for (uint8_t i = 0; i < 12; i++) {

      switch (i) {

        case 6:

          if (vals [2] > 0) {
            mySerial.print(9900);
          }
          break;

        case 0:
          mySerial.print(value0);
          break;
          
        case 1:
          mySerial.print(value1);
          break;
          
        case 2:
          mySerial.print(value2);
          break;
          
        case 3:
          mySerial.print(value3);
          break;
          
        case 4:
          mySerial.print(value4);
          break;
          
        case 5:
          mySerial.print(value5);
          break;

        case 7:

          mySerial.print(value7);
          break;
          
        case 8:
          mySerial.print(value8);
          break;
        case 9:

          mySerial.print(value9);
          break;
          
        case 10:
          mySerial.print(value10);
          break;
          
        case 11:
          mySerial.print(value11);
          break;
      }
      
      if (i == 12)
        mySerial.print(",");
    }
    mySerial.print("\r");
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
