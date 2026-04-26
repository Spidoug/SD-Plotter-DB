void control()
{
  KP1 = (vals [3] / 1000);
  KI1 = (vals [4] / 1000);
  KD1 = (vals [5] / 1000);

  KP2 = (vals [6] / 1000);
  KI2 = (vals [7] / 1000);
  KD2 = (vals [8] / 1000);

  if (PIDcontroltemp == 1) {
    if ( ativ_ethernet == false) {
      error2 = vals [0] - analogRead(analogPin5);
    } else {
      error2 =  val_0_ethernet - analogRead(analogPin5);
    }
    I_error2 += error2;
    D_error2 = lastError2 - error2;
    output1 += KP1 * error2 + KI1 * I_error2 + KD1 * D_error2;
    output1 = constrain(output1, 0, 1023);
  }

  if (PIDcontrolspeed == 1) {
    cpr = map(filtered6, 0, maxspeed * 100, 0, 1023);
    if ( ativ_ethernet == false) {
      error1 = vals [1] - cpr;
    } else {
      error1 = val_1_ethernet - cpr;
    }
    I_error1 += error1;
    D_error1 = lastError1 - error1;
    output2 += KP2 * error1 + KI2 * I_error1 + KD2 * D_error1;
    output2 = constrain(output2, 0, 1023);
  }
  if (PIDcontroltemp == 0) {
    if ( ativ_ethernet == false) {
      output1 = vals [0];
    } else {
      output1 = val_0_ethernet;
    }
  }
  if (PIDcontrolspeed == 0) {
    if ( ativ_ethernet == false) {
      output2 = vals [1];
    } else {
      output2 = val_1_ethernet;
    }
  }
}

void callback() {
  if (ativ_start == true) {
    Timer1.pwm(analogout1, output1);
    Timer1.pwm(analogout2, output2);
  }
}
