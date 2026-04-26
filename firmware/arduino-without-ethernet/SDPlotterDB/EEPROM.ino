void checkeeprom() {

  ///////////////////////////////////////////////////
  // send to software

  if (vals [2] == 9900) {
    start1 = true;
    value11 = 9902;
  }

  if (vals [2] == 9904) {
    start2 = true;
    EEPROM.get(addr5, value0);
    EEPROM.get(addr6, value1);
    EEPROM.get(addr7, value2);
    EEPROM.get(addr8, value3);
    value4 = EEPROM.read(addr0);
    value5 = EEPROM.read(addr1);
    value10 = read_String(addr40);
    value11 = 9906;
  }

  if (vals [2] == 9908) {
    start3 = true;
    value0 = EEPROM.read(addr2);
    value1 = EEPROM.read(addr3);
    value2 = EEPROM.read(addr4);
    value10 = read_String(addr41);
    value11 = 9910;
  }

  if (vals [2] == 9912) {
    start4 = true;
    EEPROM.get(addr10, value0);
    EEPROM.get(addr11, value1);
    EEPROM.get(addr12, value2);
    EEPROM.get(addr13, value3);
    EEPROM.get(addr14, value4);
    EEPROM.get(addr15, value5);
    value10 = read_String(addr42);
    value11 = 9914;
  }

  if (vals [2] == 9916) {
    start5 = true;
    EEPROM.get(addr16, value0);
    EEPROM.get(addr17, value1);
    EEPROM.get(addr18, value2);
    EEPROM.get(addr19, value3);
    EEPROM.get(addr20, value4);
    EEPROM.get(addr21, value5);
    value10 = read_String(addr43);
    value11 = 9918;
  }

  if (vals [2] == 9920) {
    start6 = true;
    EEPROM.get(addr22, value0);
    EEPROM.get(addr23, value1);
    EEPROM.get(addr24, value2);
    EEPROM.get(addr25, value3);
    EEPROM.get(addr26, value4);
    EEPROM.get(addr27, value5);
    value10 = read_String(addr44);
    value11 = 9922;
  }

  if (vals [2] == 9924) {
    start7 = true;
    EEPROM.get(addr28, value0);
    EEPROM.get(addr29, value1);
    EEPROM.get(addr30, value2);
    EEPROM.get(addr31, value3);
    EEPROM.get(addr32, value4);
    EEPROM.get(addr33, value5);
    value10 = read_String(addr45);
    value11 = 9926;
  }

  if (vals [2] == 9928) {
    start8 = true;
    EEPROM.get(addr34, value0);
    EEPROM.get(addr35, value1);
    EEPROM.get(addr36, value2);
    EEPROM.get(addr37, value3);
    EEPROM.get(addr38, value4);
    EEPROM.get(addr39, value5);
    value10 = read_String(addr46);
    value11 = 9930;
  }

  if (vals [2] == 9932) {
    value11 = 9934;
  }

  if (vals [2] == 9936) {
    value11 = 9938;
  }

  if (vals [2] == 9940) {
    start9 = true;
    value10 = "";
    value11 = 9942;
  }

  if (vals [2] == 9944) {
    if ( (start1 == true) & (start2 == true) & (start3 == true) & (start4 == true) & (start5 == true) & (start6 == true) & (start7 == true) & (start8 == true) & (start9 == true) ) {
      ativ_start = true;
    }
  }
}

void receeprom() {

  if (vals [2] == 9840) {
    value11 = 9842;
  }

  if (vals [2] == 9844) {
    write_String(addr40, toks [13]);
    EEPROM.put(addr5, vals [3]);
    EEPROM.put(addr6, vals [4]);
    EEPROM.put(addr7, vals [5]);
    EEPROM.put(addr8, vals [6]);
    EEPROM.write(addr0, vals [7]);
    EEPROM.write(addr1, vals [8]);
    value11 = 9846;
  }

  if (vals [2] == 9848) {
    write_String(addr41, toks [13]);
    EEPROM.write(addr2, vals [3]);
    EEPROM.write(addr3, vals [4]);
    EEPROM.write(addr4, vals [5]);
    value11 = 9850;
  }

  if (vals [2] == 9852) {
    write_String(addr42, toks [13]);
    EEPROM.put(addr10, vals [3]);
    EEPROM.put(addr11, vals [4]);
    EEPROM.put(addr12, vals [5]);
    EEPROM.put(addr13, vals [6]);
    EEPROM.put(addr14, vals [7]);
    EEPROM.put(addr15, vals [8]);
    value11 = 9854;
  }

  if (vals [2] == 9856) {
    write_String(addr43, toks [13]);
    EEPROM.put(addr16, vals [3]);
    EEPROM.put(addr17, vals [4]);
    EEPROM.put(addr18, vals [5]);
    EEPROM.put(addr19, vals [6]);
    EEPROM.put(addr20, vals [7]);
    EEPROM.put(addr21, vals [8]);
    value11 = 9858;
  }

  if (vals [2] == 9860) {
    write_String(addr44, toks [13]);
    EEPROM.put(addr22, vals [3]);
    EEPROM.put(addr23, vals [4]);
    EEPROM.put(addr24, vals [5]);
    EEPROM.put(addr25, vals [6]);
    EEPROM.put(addr26, vals [7]);
    EEPROM.put(addr27, vals [8]);
    value11 = 9862;
  }

  if (vals [2] == 9864) {
    write_String(addr45, toks [13]);
    EEPROM.put(addr28, vals [3]);
    EEPROM.put(addr29, vals [4]);
    EEPROM.put(addr30, vals [5]);
    EEPROM.put(addr31, vals [6]);
    EEPROM.put(addr32, vals [7]);
    EEPROM.put(addr33, vals [8]);
    value11 = 9866;
  }

  if (vals [2] == 9868) {
    write_String(addr46, toks [13]);
    EEPROM.put(addr34, vals [3]);
    EEPROM.put(addr35, vals [4]);
    EEPROM.put(addr36, vals [5]);
    EEPROM.put(addr37, vals [6]);
    EEPROM.put(addr38, vals [7]);
    EEPROM.put(addr39, vals [8]);
    value11 = 9870;
  }

  if (vals [2] == 9872) {
    value11 = 9874;
  }

  if (vals [2] == 9876) {
    value11 = 9878;
  }

  if (vals [2] == 9880) {
    value11 = 9882;
  }

  if (vals [2] == 9884) {
    value11 = 9886;
  }
}

void write_String(int baseaddress, String message) {
  if (baseaddress + message.length() + 1 > EEPROM.length()) {
    return;
  }
  for (int i = 0; i < int(message.length()); i++) {
    EEPROM.update(baseaddress, message[i]);  
    baseaddress++;
  }
  EEPROM.update(baseaddress, '\0'); 
}

String read_String(int baseaddress) {
  String message = "";
  char pos;
  do {
    if (baseaddress >= EEPROM.length()) {
      return message;
    }
    pos = EEPROM.read(baseaddress);
    baseaddress++;
    if (pos != '\0') {
      message += pos; 
    }
  } while (pos != '\0');
  return message;
}
