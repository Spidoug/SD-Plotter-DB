void capturedata() {

  if (commaster == 0) {

    if (Serial.available () > 0)  {
      int n = Serial. readBytesUntil ('\r', s, sizeof(s));
      s [n] = 0;      // terminate string
    }
  }

  if (commaster == 1) {

    if (Serial1.available () > 0)  {
      int n = Serial1. readBytesUntil ('\r', s, sizeof(s));
      s [n] = 0;      // terminate string
    }
  }

  tokenize (s, ",");

  if (ativ_start == true) {
    if ( ativ_ethernet == false) {
      if (vals [9] == 1) {
        digitalWrite(Pin6, LOW);
      }
      if (vals [10] == 1) {
        digitalWrite(Pin7, LOW);
      }
      if (vals [11] == 1) {
        digitalWrite(Pin8, HIGH);
      }
      if (vals [12] == 1) {
        digitalWrite(Pin9, HIGH);
      }
      if (vals [9] == 0) {
        digitalWrite(Pin6, HIGH);
      }
      if (vals [10] == 0) {
        digitalWrite(Pin7, HIGH);
      }
      if (vals [11] == 0) {
        digitalWrite(Pin8, LOW);
      }
      if (vals [12] == 0) {
        digitalWrite(Pin9, LOW);
      }
    }
  }
}
