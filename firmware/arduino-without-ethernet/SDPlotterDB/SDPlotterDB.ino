/*  //////////////////////////////////////////////////////////////////SD PLOTTER DB® VERSION 3.00 - FIRMWARE/////////////////////////////////////////////////////////////////////////
 
 SOFTWARE DEVELOPED BY DOUGLAS SANTANA DA SILVA
 CONTACT EMAIL: SPIDOUG@GMAIL.COM
 
 THIS PROGRAM HAS THE CAPABILITY OF MONITORING AND CONTROLLING SIGNALS FROM A MICROCONTROLLER WITH DEDICATED FIRMWARE AND EXCLUSIVE COMMUNICATION PROTOCOL.

 FOR ARDUINO UNO AND NANO
 */

#include <TimerOne.h>
#include <SoftwareSerial.h>
#include <EEPROM.h>

byte pinPWM;

volatile byte peaks;
unsigned long timeold = 0;
unsigned long timeled = 0;
unsigned long time_now = micros();
unsigned long pspin = 0;
unsigned long rpm = 0;
int cpr = 0;

int output1 = 0;
int output2 = 0;

char s[80];

#define MaxTok  14
char *toks[MaxTok];
unsigned long vals[MaxTok];

// -----------------------------------------------------------------------------
long
tokenize(
  char       *s,
  const char *sep)
{
  unsigned n = 0;
  toks[n] = strtok(s, sep);
  vals[n] = atoi(toks[n]);

  for (n = 1; (toks[n] = strtok(NULL, sep)); n++)
    vals[n] = atoi(toks[n]);

  return n;
}

int beta0 = 1;  //alpha = 1/2^beta
int beta1 = 1;  //alpha = 1/2^beta
int beta2 = 1;  //alpha = 1/2^beta
int beta3 = 1;  //alpha = 1/2^beta
int beta4 = 1;  //alpha = 1/2^beta
int beta5 = 1;  //alpha = 1/2^beta
int beta6 = 7;  //alpha = 1/2^beta
int beta6_1 = 7;  //alpha = 1/2^beta

unsigned int datax0 = 0, filtered0 = 0;
unsigned long sum0 = 0;

unsigned int datax1 = 0, filtered1 = 0;
unsigned long sum1 = 0;

unsigned int datax2 = 0, filtered2 = 0;
unsigned long sum2 = 0;

unsigned int datax3 = 0, filtered3 = 0;
unsigned long sum3 = 0;

unsigned int datax4 = 0, filtered4 = 0;
unsigned long sum4 = 0;

unsigned int datax5 = 0, filtered5 = 0;
unsigned long sum5 = 0;

unsigned long datax6 = 0, filtered6 = 0;
unsigned long sum6 = 0;

unsigned long datax6_1 = 0, filtered6_1 = 0;
unsigned long sum6_1 = 0;

unsigned long filtered6final = 0;

float lastError1 = 0;
float error1 = 0;
float I_error1 = 0;
float D_error1 = 0;
float KP1 = 0;
float KI1 = 0;
float KD1 = 0;

float lastError2 = 0;
float error2 = 0;
float I_error2 = 0;
float D_error2 = 0;
float KP2 = 0;
float KI2 = 0;
float KD2 = 0;

int addr0 = 0;
int addr1 = 1;
int addr2 = 2;
int addr3 = 3;
int addr4 = 4;
int addr5 = 5;
int addr6 = 9;
int addr7 = 13;
int addr8 = 17;
int addr9 = 21;
int addr10 = 25;
int addr11 = 29;
int addr12 = 33;
int addr13 = 37;
int addr14 = 41;
int addr15 = 45;
int addr16 = 49;
int addr17 = 53;
int addr18 = 57;
int addr19 = 61;
int addr20 = 65;
int addr21 = 69;
int addr22 = 73;
int addr23 = 77;
int addr24 = 81;
int addr25 = 85;
int addr26 = 89;
int addr27 = 93;
int addr28 = 97;
int addr29 = 101;
int addr30 = 105;
int addr31 = 109;
int addr32 = 113;
int addr33 = 117;
int addr34 = 121;
int addr35 = 125;
int addr36 = 129;
int addr37 = 133;
int addr38 = 137;
int addr39 = 141;
int addr40 = 145;
int addr41 = 150;
int addr42 = 170;
int addr43 = 190;
int addr44 = 210;
int addr45 = 230;
int addr46 = 250;

int PIDcontrolspeed = 0;
int PIDcontroltemp = 0;
int comspeed = 0;
int commaster = 0;
int speeddataserial = 0;
unsigned long maxspeed = 0;
unsigned long motorpower = 0;
unsigned long rxtxspeed = 0;
unsigned long snA = 1;
int memory = 0;

const byte analogout1 = 10;
const byte analogout2 = 9;

int pin_D0 = 2;
const int Pin3 = 3;
const int Pin4 = 4;
const int Pin5 = 5;
const int Pin6 = 6;
const int Pin7 = 7;
const int Pin8 = 8;
const int Pin11 = 11;
const byte txPin = 12;
const byte rxPin = 13;

int analogPin0 = A0;
int analogPin1 = A1;
int analogPin2 = A2;
int analogPin3 = A3;
int analogPin4 = A4;
int analogPin5 = A5;

int16_t value0 = 0;
int16_t value1 = 0;
int16_t value2 = 0;
int16_t value3 = 0;
int16_t value4 = 0;
int16_t value5 = 0;
int16_t value6 = 0;
int16_t value7 = 0;
int16_t value8 = 0;
unsigned long value9 = 0;
String  value10 = "";
int16_t value11 = 0;

boolean ativ_start = false;
boolean start1 = false;
boolean start2 = false;
boolean start3 = false;
boolean start4 = false;
boolean start5 = false;
boolean start6 = false;
boolean start7 = false;
boolean start8 = false;
boolean start9 = false;

SoftwareSerial mySerial(rxPin, txPin);

void counter()
{
  peaks++;
}

void setup() {
  EEPROM.get(addr9, memory);

  if (memory != 6867) {
    EEPROM.put(addr10, 49);
    EEPROM.put(addr11, 49);
    EEPROM.put(addr12, 49);
    EEPROM.put(addr13, 49);
    EEPROM.put(addr14, 49);
    EEPROM.put(addr15, 49);
    EEPROM.put(addr16, 0);
    EEPROM.put(addr17, 0);
    EEPROM.put(addr18, 0);
    EEPROM.put(addr19, 0);
    EEPROM.put(addr20, 0);
    EEPROM.put(addr21, 0);
    EEPROM.put(addr22, 0);
    EEPROM.put(addr23, 0);
    EEPROM.put(addr24, 0);
    EEPROM.put(addr25, 0);
    EEPROM.put(addr26, 0);
    EEPROM.put(addr27, 0);
    EEPROM.put(addr28, 1000);
    EEPROM.put(addr29, 100);
    EEPROM.put(addr30, 10);
    EEPROM.put(addr31, 1000);
    EEPROM.put(addr32, 100);
    EEPROM.put(addr33, 10);
    EEPROM.put(addr34, 1);
    EEPROM.put(addr35, 1);
    EEPROM.put(addr36, 1);
    EEPROM.put(addr37, 1);
    EEPROM.put(addr38, 1);
    EEPROM.put(addr39, 1);

    write_String(addr40, "");
    write_String(addr41, "Unit 1");
    write_String(addr42, "Unit 2");
    write_String(addr43, "Unit 3");
    write_String(addr44, "Unit 4");
    write_String(addr45, "Unit 5");
    write_String(addr46, "ºC");

    EEPROM.put(addr9, 6867);
  }

  Timer1.initialize(500);
  Timer1.attachInterrupt(callback);  // attaches callback() as a timer overflow interrupt

  // Define pin modes for TX and RX
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  pinMode(pin_D0, INPUT);
  pinMode(Pin3, INPUT);
  pinMode(Pin4, INPUT);
  pinMode(Pin5, INPUT);
  pinMode(Pin6, OUTPUT);
  pinMode(Pin7, OUTPUT);
  pinMode(Pin8, OUTPUT);
  pinMode(analogout1, OUTPUT);
  pinMode(analogout2, OUTPUT);
  pinMode(Pin11, OUTPUT);

  comspeed = EEPROM.read(addr0);
  commaster = EEPROM.read(addr1);
  PIDcontrolspeed = EEPROM.read(addr2);
  PIDcontroltemp = EEPROM.read(addr3);
  speeddataserial = EEPROM.read(addr4);

  EEPROM.get(addr5, motorpower);
  EEPROM.get(addr6, pspin);
  EEPROM.get(addr7, maxspeed);
  EEPROM.get(addr8, snA);

  EEPROM.get(addr34, beta0);
  EEPROM.get(addr35, beta1);
  EEPROM.get(addr36, beta2);
  EEPROM.get(addr37, beta3);
  EEPROM.get(addr38, beta4);
  EEPROM.get(addr39, beta5);

  if ((comspeed != 0) & (comspeed != 1) & (comspeed != 2) & (comspeed != 3)) {
    comspeed = 0;
    EEPROM.write(addr0, comspeed);
  }

  if ((commaster != 1) & (commaster != 0)) {
    commaster = 0;
    EEPROM.write(addr1, commaster);
  }

  if ((PIDcontroltemp != 1) & (PIDcontroltemp != 0)) {
    PIDcontroltemp = 0;
    EEPROM.write(addr2, PIDcontroltemp);
  }

  if ((PIDcontrolspeed != 1) & (PIDcontrolspeed != 0)) {
    PIDcontrolspeed = 0;
    EEPROM.write(addr3, PIDcontrolspeed);
  }

  if ((speeddataserial != 1) & (speeddataserial != 0)) {
    speeddataserial = 0;
    EEPROM.write(addr4, speeddataserial);
  }

  if (motorpower == 0) {
    motorpower = 300;
    EEPROM.put(addr5, motorpower);
  }

  if (pspin == 0) {
    pspin = 3;
    EEPROM.put(addr6, pspin);
  }

  if (maxspeed == 0) {
    maxspeed = 30;
    EEPROM.put(addr7, maxspeed);
  }

  if (snA == 0) {
    snA = 1;
    EEPROM.put(addr8, snA);
  }

  switch (comspeed) {
    case 0 :
      rxtxspeed = 19200;
      break;
    case 1:
      rxtxspeed = 38400;
      break;
    case 2:
      rxtxspeed = 57600;
      break;
    case 3:
      rxtxspeed = 115200;
      break;
  }

  if (commaster == 0) {

    if (digitalRead(Pin3) == HIGH) {
      mySerial.begin(9600);
      delay(1000);
      mySerial.print(F("SD Plotter DB"));
      mySerial.println();
      mySerial.print(F("Version 3.00"));
      mySerial.println();
      mySerial.print(F("SERIAL NUMBER = SD"));

      mySerial.print(snA);
      mySerial.println();
      mySerial.println();

      mySerial.print(F("Set baud rate. 0->19200/1->38400/2->57600/3->115200"));
      mySerial.println();
      mySerial.print(F("Set main port communication. 4->USB/5->Serial"));
      mySerial.println();
      mySerial.print(F("Set serial number. a->Enter/b->Clear"));
      mySerial.println();
      mySerial.print(F("PID control temperature. c->ON/d->OFF"));
      mySerial.println();
      mySerial.print(F("PID control speed. e->ON/f->OFF"));
      mySerial.println();
      mySerial.print(F("Set smoothing. g->ON/h->OFF"));
      mySerial.println();
      mySerial.print(F("Set Motor Power. i->Enter"));
      mySerial.println();
      mySerial.print(F("Set Max RPM. j->Enter"));
      mySerial.println();
      mySerial.print(F("Set encoder count numbers. k->Enter"));
      mySerial.println();
      mySerial.print(F("l-> Clear all"));
      mySerial.println();
      mySerial.println();

      mySerial.print(F("// Summary //"));
      mySerial.println();
      mySerial.print(rxtxspeed);
      mySerial.print(F(" bps"));
      mySerial.println();

      if (PIDcontroltemp == 1) {
        mySerial.println(F("PID temperature control enabled"));
      }
      if (PIDcontroltemp == 0) {
        mySerial.println(F("PID temperature control disabled"));
      }
      if (PIDcontrolspeed == 1) {
        mySerial.println(F("PID speed control enabled"));
      }
      if (PIDcontrolspeed == 0) {
        mySerial.println(F("PID speed control disabled"));
      }
      if (speeddataserial == 1) {
        mySerial.println(F("Smoothing on"));
      }
      if (speeddataserial == 0) {
        mySerial.println(F("Smoothing off"));
      }

      mySerial.print(maxspeed * 100);
      mySerial.println(F(" Max RPM"));
      mySerial.print(pspin);
      mySerial.println(F(" pulse(s)"));
      mySerial.print(motorpower);
      mySerial.println(F(" W"));
      mySerial.println(F("// -/- //"));
    }
    Serial.begin(rxtxspeed);
    delay(100);
    Serial.println(F("SDPlotterDB"));
  }

  if (commaster == 1) {

    if (digitalRead(Pin3) == HIGH) {
      Serial.begin(9600);
      delay(1000);
      Serial.print(F("SD Plotter DB"));
      Serial.println();
      Serial.print(F("Version 3.00"));
      Serial.println();
      Serial.print(F("SERIAL NUMBER = SD"));

      Serial.print(snA);
      Serial.println();
      Serial.println();

      Serial.print(F("Set baud rate. 0->19200/1->38400/2->57600/3->115200"));
      Serial.println();
      Serial.print(F("Set main port communication. 4->USB/5->Serial"));
      Serial.println();
      Serial.print(F("Set serial number. a->Enter/b->Clear"));
      Serial.println();
      Serial.print(F("PID control temperature. c->ON/d->OFF"));
      Serial.println();
      Serial.print(F("PID control speed. e->ON/f->OFF"));
      Serial.println();
      Serial.print(F("Set smoothing. g->ON/h->OFF"));
      Serial.println();
      Serial.print(F("Set Motor Power. i->Enter"));
      Serial.println();
      Serial.print(F("Set Max RPM. j->Enter"));
      Serial.println();
      Serial.print(F("Set encoder count numbers. k->Enter"));
      Serial.println();
      Serial.print(F("l-> Clear all"));
      Serial.println();
      Serial.println();

      Serial.print(F("// Summary //"));
      Serial.println();
      Serial.print(rxtxspeed);
      Serial.print(F(" bps"));
      Serial.println();

      if (PIDcontroltemp == 1) {
        Serial.println(F("PID temperature control enabled"));
      }
      if (PIDcontroltemp == 0) {
        Serial.println(F("PID temperature control disabled"));
      }
      if (PIDcontrolspeed == 1) {
        Serial.println(F("PID speed control enabled"));
      }
      if (PIDcontrolspeed == 0) {
        Serial.println(F("PID speed control disabled"));
      }
      if (speeddataserial == 1) {
        Serial.println(F("Smoothing on"));
      }
      if (speeddataserial == 0) {
        Serial.println(F("Smoothing off"));
      }

      Serial.print(motorpower);
      Serial.println(F(" W"));
      Serial.print(maxspeed * 100);
      Serial.println(F(" Max RPM"));
      Serial.print(pspin);
      Serial.println(F(" pulse(s)"));
      Serial.println(F("// -/- //"));
    }
    mySerial.begin(rxtxspeed);
    delay(100);
    mySerial.println(F("SDPlotterDB"));
  }

  if (digitalRead(Pin3) == LOW) {
    pinMode(Pin3, OUTPUT);
  }

  digitalWrite(Pin6, HIGH);
  digitalWrite(Pin7, HIGH);
  digitalWrite(Pin8, LOW);
  digitalWrite(Pin11, LOW);

  attachInterrupt(0, counter, RISING);
  peaks = 0;
  rpm = 0;
  timeold = 0;
  timeled = 0;

  value6 = 9900;
}

void loop() {

  if ((micros() - time_now) >= 50000) {
    time_now = micros();
    digitalWrite(Pin3, LOW);
  }

  if (ativ_start == true) {
    if (speeddataserial == 1) {
      readsmooth();
    }
    if (speeddataserial == 0) {
      readnormal();
    }
  }

  checkeeprom();

  if (ativ_start == true) {
    if ((micros() - timeold) >= 500) {
      detachInterrupt(0);
      rpm = 2000 * ((30000 / pspin) / (micros() - timeold) * peaks);
      timeold = micros();
      peaks = 0;
      attachInterrupt(0, counter, RISING);
    }
  }

  sum6 = sum6 - filtered6 + rpm;
  filtered6 = sum6 >> beta6;
  sum6_1 = sum6_1 - filtered6_1 + filtered6;
  filtered6_1 = sum6_1 >> beta6_1;

  command();

  if ((micros() - time_now) <= 1000) {
    if (vals[2] > 0) {
      senddata();
    }
  }

  capturedata();
  receeprom();

  if (ativ_start == true) {
    control();
    digitalWrite(Pin3, HIGH);
  }

  if ((millis() - timeled) >= 1000) {
    timeled = millis();
    digitalWrite(Pin3, HIGH);
    filtered6final = filtered6_1;
  }
}
