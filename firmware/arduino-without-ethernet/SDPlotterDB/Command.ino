void command()
{
  if (digitalRead(Pin3) == HIGH) {

    if (commaster == 0) {

      char fac = mySerial.read();

      switch (fac) {
        case '0' :
          comspeed = 0;
          EEPROM.write(addr0, comspeed);
          mySerial.println(F("19200 bps"));
          break;
        case '1':
          comspeed = 1;
          EEPROM.write(addr0, comspeed);
          mySerial.println(F("38400 bps"));
          break;
        case '2' :
          comspeed = 2;
          EEPROM.write(addr0, comspeed);
          mySerial.println(F("57600 bps"));
          break;
        case '3' :
          comspeed = 3;
          EEPROM.write(addr0, comspeed);
          mySerial.println(F("115200 bps"));
          break;
        case '4' :
          commaster = 0;
          EEPROM.write(addr1, commaster);
          mySerial.println(F("USB"));
          break;
        case '5' :
          commaster = 1;
          EEPROM.write(addr1, commaster);
          mySerial.println(F("Serial"));
          break;
        case 'a' :
          snA = vals[3];
          EEPROM.put(addr8, snA);
          EEPROM.get(addr8, snA);
          mySerial.println(snA);
          break;
        case 'b' :
          EEPROM.put(addr8, 0);
          EEPROM.get(addr8, snA);
          mySerial.print(snA);
          break;
        case 'c' :
          PIDcontroltemp = 1;
          EEPROM.write(addr3, PIDcontroltemp);
          mySerial.println(F("PID control temperature enabled"));
          break;
        case 'd' :
          PIDcontroltemp = 0;
          EEPROM.write(addr3, PIDcontroltemp);
          mySerial.println(F("PID control temperature disabled"));
          break;
        case 'e' :
          PIDcontrolspeed = 1;
          EEPROM.write(addr2, PIDcontrolspeed);
          mySerial.println(F("PID control speed enabled"));
          break;
        case 'f' :
          PIDcontrolspeed = 0;
          EEPROM.write(addr2, PIDcontrolspeed);
          mySerial.println(F("PID control speed disabled"));
          break;
        case 'g' :
          speeddataserial = 1;
          EEPROM.write(addr4, speeddataserial);
          mySerial.println(F("Smoothing on"));
          break;
        case 'h' :
          speeddataserial = 0;
          EEPROM.write(addr4, speeddataserial);
          mySerial.println(F("Smoothing off"));
          break;
        case 'i' :
          motorpower = vals[3];
          EEPROM.put(addr5, motorpower);
          EEPROM.get(addr5, motorpower);
          mySerial.print(motorpower);
          mySerial.println(F(" W"));
          break;
        case 'j' :
          maxspeed = vals[3];
          EEPROM.put(addr7, maxspeed);
          EEPROM.get(addr7, maxspeed);
          mySerial.print(maxspeed * 100);
          mySerial.println(F(" RPM"));
          break;
        case 'k' :
          pspin = vals[3];
          EEPROM.put(addr6, pspin);
          EEPROM.get(addr6, pspin);
          mySerial.print(pspin);
          mySerial.println(F(" pulse(s)"));
          break;
        case 'l' :
          for (int i = 0 ; i < int(EEPROM.length()) ; i++) {
            EEPROM.write(i, 0);
          }
          mySerial.println(F("Data erased"));
          break;
      }
    }

    if (commaster == 1) {
      char fac = Serial.read();

      switch (fac) {
        case '0' :
          comspeed = 0;
          EEPROM.write(addr0, comspeed);
          Serial.println(F("19200 bps"));
          break;
        case '1':
          comspeed = 1;
          EEPROM.write(addr0, comspeed);
          Serial.println(F("38400 bps"));
          break;
        case '2' :
          comspeed = 2;
          EEPROM.write(addr0, comspeed);
          Serial.println(F("57600 bps"));
          break;
        case '3' :
          comspeed = 3;
          EEPROM.write(addr0, comspeed);
          Serial.println(F("115200 bps"));
          break;
        case '4' :
          commaster = 0;
          EEPROM.write(addr1, commaster);
          Serial.println(F("USB"));
          break;
        case '5' :
          commaster = 1;
          EEPROM.write(addr1, commaster);
          Serial.println(F("Serial"));
          break;
        case 'a' :
          snA = vals[3];
          EEPROM.put(addr8, snA);
          EEPROM.get(addr8, snA);
          Serial.println(snA);
          break;
        case 'b' :
          EEPROM.put(addr8, 0);
          EEPROM.get(addr8, snA);
          Serial.print(snA);
          break;
        case 'c' :
          PIDcontroltemp = 1;
          EEPROM.write(addr3, PIDcontroltemp);
          Serial.println(F("PID control temperature enabled"));
          break;
        case 'd' :
          PIDcontroltemp = 0;
          EEPROM.write(addr3, PIDcontroltemp);
          Serial.println(F("PID control temperature disabled"));
          break;
        case 'e' :
          PIDcontrolspeed = 1;
          EEPROM.write(addr2, PIDcontrolspeed);
          Serial.println(F("PID control speed enabled"));
          break;
        case 'f' :
          PIDcontrolspeed = 0;
          EEPROM.write(addr2, PIDcontrolspeed);
          Serial.println(F("PID control speed disabled"));
          break;
        case 'g' :
          speeddataserial = 1;
          EEPROM.write(addr4, speeddataserial);
          Serial.println(F("Smoothing on"));
          break;
        case 'h' :
          speeddataserial = 0;
          EEPROM.write(addr4, speeddataserial);
          Serial.println(F("Smoothing off"));
          break;
        case 'i' :
          motorpower = vals[3];
          EEPROM.put(addr5, motorpower);
          EEPROM.get(addr5, motorpower);
          Serial.print(motorpower);
          Serial.println(F(" W"));
          break;
        case 'j' :
          maxspeed = vals[3];
          EEPROM.put(addr7, maxspeed);
          EEPROM.get(addr7, maxspeed);
          Serial.print(maxspeed * 100);
          Serial.println(F(" RPM"));
          break;
        case 'k' :
          pspin = vals[3];
          EEPROM.put(addr6, pspin);
          EEPROM.get(addr6, pspin);
          Serial.print(pspin);
          Serial.println(F(" pulse(s)"));
          break;
        case 'l' :
          for (int i = 0 ; i < int(EEPROM.length()) ; i++) {
            EEPROM.write(i, 0);
          }
          Serial.println(F("Data erased"));
          break;
      }
    }
  }
}
