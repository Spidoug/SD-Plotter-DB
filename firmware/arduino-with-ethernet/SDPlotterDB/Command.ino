void command()
{
  if (digitalRead(Pin3) == HIGH) {

    if (commaster == 0) {

      char fac = Serial1.read();

      switch (fac) {
        case '0' :
          comspeed = 0;
          EEPROM.write(addr0, comspeed);
          Serial1.println(F("19200 bps"));
          break;
        case '1':
          comspeed = 1;
          EEPROM.write(addr0, comspeed);
          Serial1.println(F("38400 bps"));
          break;
        case '2' :
          comspeed = 2;
          EEPROM.write(addr0, comspeed);
          Serial1.println(F("57600 bps"));
          break;
        case '3' :
          comspeed = 3;
          EEPROM.write(addr0, comspeed);
          Serial1.println(F("115200 bps"));
          break;
        case '4' :
          commaster = 0;
          EEPROM.write(addr1, commaster);
          Serial1.println(F("USB"));
          break;
        case '5' :
          commaster = 1;
          EEPROM.write(addr1, commaster);
          Serial1.println(F("Serial"));
          break;
        case 'a' :
          snA = vals[3];
          EEPROM.put(addr8, snA);
          EEPROM.get(addr8, snA);
          Serial1.println(snA);
          break;
        case 'b' :
          EEPROM.put(addr8, 0);
          EEPROM.get(addr8, snA);
          Serial1.print(snA);
          break;
        case 'c' :
          PIDcontroltemp = 1;
          EEPROM.write(addr3, PIDcontroltemp);
          Serial1.println(F("PID control temperature enabled"));
          break;
        case 'd' :
          PIDcontroltemp = 0;
          EEPROM.write(addr3, PIDcontroltemp);
          Serial1.println(F("PID control temperature disabled"));
          break;
        case 'e' :
          PIDcontrolspeed = 1;
          EEPROM.write(addr2, PIDcontrolspeed);
          Serial1.println(F("PID control speed enabled"));
          break;
        case 'f' :
          PIDcontrolspeed = 0;
          EEPROM.write(addr2, PIDcontrolspeed);
          Serial1.println(F("PID control speed disabled"));
          break;
        case 'g' :
          speeddataserial = 1;
          EEPROM.write(addr4, speeddataserial);
          Serial1.println(F("Smoothing on"));
          break;
        case 'h' :
          speeddataserial = 0;
          EEPROM.write(addr4, speeddataserial);
          Serial1.println(F("Smoothing off"));
          break;
        case 'i' :
          motorpower = vals[3];
          EEPROM.put(addr5, motorpower);
          EEPROM.get(addr5, motorpower);
          Serial1.print(motorpower);
          Serial1.println(F(" W"));
          break;
        case 'j' :
          maxspeed = vals[3];
          EEPROM.put(addr7, maxspeed);
          EEPROM.get(addr7, maxspeed);
          Serial1.print(maxspeed * 100);
          Serial1.println(F(" RPM"));
          break;
        case 'k' :
          pspin = vals[3];
          EEPROM.put(addr6, pspin);
          EEPROM.get(addr6, pspin);
          Serial1.print(pspin);
          Serial1.println(F(" pulse(s)"));
          break;
        case 'l' :
          ip[0] = byte(vals[3]);
          ip[1] = byte(vals[4]);
          ip[2] = byte(vals[5]);
          ip[3] = byte(vals[6]);
          EEPROM.put(addr47, ip[0]);
          EEPROM.put(addr48, ip[1]);
          EEPROM.put(addr49, ip[2]);
          EEPROM.put(addr50, ip[3]);
          EEPROM.get(addr47, ip[0]);
          EEPROM.get(addr48, ip[1]);
          EEPROM.get(addr49, ip[2]);
          EEPROM.get(addr50, ip[3]);
          Serial1.print(ip[0]);
          Serial1.print(F("."));
          Serial1.print(ip[1]);
          Serial1.print(F("."));
          Serial1.print(ip[2]);
          Serial1.print(F("."));
          Serial1.print(ip[3]);
          Serial1.println(F(" IP"));
          break;
        case 'm' :
          subnet[0] = byte(vals[3]);
          subnet[1] = byte(vals[4]);
          subnet[2] = byte(vals[5]);
          subnet[3] = byte(vals[6]);
          EEPROM.put(addr51, subnet[0]);
          EEPROM.put(addr52, subnet[1]);
          EEPROM.put(addr53, subnet[2]);
          EEPROM.put(addr54, subnet[3]);
          EEPROM.get(addr51, subnet[0]);
          EEPROM.get(addr52, subnet[1]);
          EEPROM.get(addr53, subnet[2]);
          EEPROM.get(addr54, subnet[3]);
          Serial1.print(subnet[0]);
          Serial1.print(F("."));
          Serial1.print(subnet[1]);
          Serial1.print(F("."));
          Serial1.print(subnet[2]);
          Serial1.print(F("."));
          Serial1.print(subnet[3]);
          Serial1.println(F(" SUBNET"));
          break;
        case 'n' :
          serverport = vals[3];
          EEPROM.put(addr55, serverport);
          EEPROM.get(addr55, serverport);
          Serial1.print(serverport);
          Serial1.println(F(" PORT"));
          break;
        case 'o' :
          for (int i = 0 ; i < int(EEPROM.length()); i++) {
            EEPROM.write(i, 0);
          }
          Serial1.println(F("Data erased"));
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
          Serial.print(snA);
          break;
        case 'b' :
          EEPROM.put(addr8, 0);
          EEPROM.get(addr8, snA);
          Serial.println(snA);
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
          EEPROM.put(addr4, speeddataserial);
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
          ip[0] = byte(vals[3]);
          ip[1] = byte(vals[4]);
          ip[2] = byte(vals[5]);
          ip[3] = byte(vals[6]);
          EEPROM.put(addr47, ip[0]);
          EEPROM.put(addr48, ip[1]);
          EEPROM.put(addr49, ip[2]);
          EEPROM.put(addr50, ip[3]);
          EEPROM.get(addr47, ip[0]);
          EEPROM.get(addr48, ip[1]);
          EEPROM.get(addr49, ip[2]);
          EEPROM.get(addr50, ip[3]);
          Serial.print(ip[0]);
          Serial.print(F("."));
          Serial.print(ip[1]);
          Serial.print(F("."));
          Serial.print(ip[2]);
          Serial.print(F("."));
          Serial.print(ip[3]);
          Serial.println(F(" IP"));
          break;
        case 'm' :
          subnet[0] = byte(vals[3]);
          subnet[1] = byte(vals[4]);
          subnet[2] = byte(vals[5]);
          subnet[3] = byte(vals[6]);
          EEPROM.put(addr51, subnet[0]);
          EEPROM.put(addr52, subnet[1]);
          EEPROM.put(addr53, subnet[2]);
          EEPROM.put(addr54, subnet[3]);
          EEPROM.get(addr51, subnet[0]);
          EEPROM.get(addr52, subnet[1]);
          EEPROM.get(addr53, subnet[2]);
          EEPROM.get(addr54, subnet[3]);
          Serial.print(subnet[0]);
          Serial.print(F("."));
          Serial.print(subnet[1]);
          Serial.print(F("."));
          Serial.print(subnet[2]);
          Serial.print(F("."));
          Serial.print(subnet[3]);
          Serial.println(F(" SUBNET"));
          break;
        case 'n' :
          serverport = vals[3];
          EEPROM.put(addr55, serverport);
          EEPROM.get(addr55, serverport);
          Serial.print(serverport);
          Serial.println(F(" PORT"));
          break;
        case 'o' :
          for (int i = 0 ; i < int(EEPROM.length()); i++) {
            EEPROM.write(i, 0);
          }
          Serial.println(F("Data erased"));
          break;
      }
    }
  }
}
