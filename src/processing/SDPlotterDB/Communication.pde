// Function to manage communication
void Communication() {

  // Count number of bars and line graphs to hide
  int numberOfInvisibleBars = 0;
  for (i = 0; i < 8; i++) {
    // Logic for determining invisible bars
  }

  int numberOfInvisibleLineGraphs = 0;
  for (i = 0; i < 8; i++) {
    // Logic for determining invisible line graphs
  }

  // Build a new array to fit the data to show
  barChartValues = new float[8 - numberOfInvisibleBars];

  // Build the arrays for bar charts and line graphs
  int barchartIndex = 0;

  Firststepcom();

  if (setparameterscale == 1) {
    setparameterscale = 0;
    ptr = 1;
    lineGraphValues = new float[8][int(getConfigurationString("ratesampling"))];
    lineGraphSampleNumbers = new float[int(getConfigurationString("ratesampling"))];

    // Initialize charts
    setChartSettings();

    for (int i = 0; i < barChartValues.length; i++) {
      barChartValues[i] = 0;
    }

    for (int i = 0; i < lineGraphValues.length; i++) {
      for (int k = 0; k < lineGraphValues[0].length; k++) {
        lineGraphValues[i][k] = 0;

        if (i == 0) {
          lineGraphSampleNumbers[k] = k;
        }
      }
    }
  }

  for (i = 0; i < Values.length; i++) {

    if (i == 9) {
      avgr[6] = int(Values[9]);
      if (int(getConfigurationString("pidcontrolspeed")) == 1) {
        torqueout = 0;
        configuration.setString("sensor8", "   n/a");
        raw[7] = "n/a";
        rawvalues[7] = "n/a";
      } else {
        if ((mttemp - avgr[6]) >= 0) {
          torqueout = (mttemp - avgr[6]) * (float(getConfigurationString("motorpower")) / float(getConfigurationString("motorspeed")));
        } else {
          torqueout = 0;
        }
        configuration.setString("sensor8", "Torque");
      }
    }

    if (i == 7) {
      avgr[7] = torqueout;
    }

    // Update bar chart
    try {
      if (barchartIndex < barChartValues.length) {
        barChartValues[barchartIndex++] = avgrt[i];

        if (democ || statusconnect) {
          if (!democ) {
            timesmooth++;
            if (timesmooth == 1500) {
              statusok = true;
              normalizeview();
              control();
              if (timesmooth >= 1800) {
                timesmooth = 1700;
              }
            }
          } else {
            timesmooth = 0;
          }

          raw = Values;
          rawvalues = nf(avgr, 0, 3);
          avgrt = avgr;
        }
      }
    }
    catch (Exception e) {
      // Handle exception
    }

    // Update line graph
    try {
      if (i < lineGraphValues.length) {

        hideInvisibleGraphs();

        for (int k = 0; k < lineGraphValues[i].length - 1; k++) {
          if (democ || statusok) {
            lineGraphValues[i][lineGraphValues[i].length - 1] = avgrt[i];
          }
          lineGraphValues[i][k] = lineGraphValues[i][k + 1];
        }
      }
    }
    catch (Exception e) {
      // Handle exception
    }

    // Update averages and smooth values
    if (i >= 0 && i <= 5) {
      updateAverages(i);
    }
  }
}

void Firststepcom() {

  try {
    if (mockupSerial || serialPort.available() != 0) {

      myString = "";  // Initialize the input string

      if (!mockupSerial) {

        // Read from the serial port until a carriage return character
        if (!ipcon) {
          serialPort.readBytesUntil('\r', inBuffer);
        }

        myString = new String(inBuffer);  // Convert the byte array to a string
      } else {
        statusconnect = false;  // If using mockup serial, set status to not connected

        if (democ) {
          myString = mockupSerialFunction();  // Get mockup serial data if in demo mode
        }
      }

      // Split the string at delimiter (comma)
      Values = split(myString, ',');

      if (!mockupSerial) {
        for (i = 0; i < Values.length; i++) {
          if (i == 6) {
            if (eepromst == true) {
              valrel = 9840;
            } else {
              valrel = int(Values[6]);
            }
          }

          if (i == 7) {
            if (externevent) {
              if (!startcontrol && !reccontrol) {
                if (int(Values[7]) == 1) {
                  startcontrolb.setValue(1);
                  dotrwe = 1;
                }
              }
            }
          }

          if (i == 8) {
            if (externevent) {
              if (!statusstartrec) {
                if (int(Values[8]) == 1) {
                  startrecb.setValue(1);
                  dotre = 1;
                }
              }
            }
          }

          if (i == 11) {
            // Send to Arduino (eeprom)
            if (eepromst == true) {
              if (int(Values[11]) == 9842) {
                a10 = getConfigurationString("unit0");
                a1 = getConfigurationString("motorpower");
                a2 = getConfigurationString("encoder");
                a3 = str(int(getConfigurationString("motorspeed")) / 100);
                a4 = getConfigurationString("serialnumber");
                a5 = str(int(getConfigurationString("hardwarebaudrate")));
                a6 = str(int(getConfigurationString("moderxtx")));
                valrel = 9844;
              }

              if (int(Values[11]) == 9846) {
                a10 = getConfigurationString("unit1");
                a1 = str(int(getConfigurationString("pidcontrolspeed")));
                a2 = str(int(getConfigurationString("pidcontroltemperature")));
                a3 = str(int(getConfigurationString("hardwaresmooth")));
                valrel = 9848;
              }

              if (int(Values[11]) == 9850) {
                a10 = getConfigurationString("unit2");
                a1 = str(float(getConfigurationString("lgmultiplier1")) * 10000);
                a2 = str(float(getConfigurationString("lgmultiplier2")) * 10000);
                a3 = str(float(getConfigurationString("lgmultiplier3")) * 10000);
                a4 = str(float(getConfigurationString("lgmultiplier4")) * 10000);
                a5 = str(float(getConfigurationString("lgmultiplier5")) * 10000);
                a6 = str(float(getConfigurationString("lgmultiplier6")) * 10000);
                valrel = 9852;
              }

              if (int(Values[11]) == 9854) {
                a10 = getConfigurationString("unit3");
                a1 = str(float(getConfigurationString("lgspan1")) * 10);
                a2 = str(float(getConfigurationString("lgspan2")) * 10);
                a3 = str(float(getConfigurationString("lgspan3")) * 10);
                a4 = str(float(getConfigurationString("lgspan4")) * 10);
                a5 = str(float(getConfigurationString("lgspan5")) * 10);
                a6 = str(float(getConfigurationString("lgspan6")) * 10);
                valrel = 9856;
              }

              if (int(Values[11]) == 9858) {
                a10 = getConfigurationString("unit4");
                a1 = getConfigurationString("lgsmooth1");
                a2 = getConfigurationString("lgsmooth2");
                a3 = getConfigurationString("lgsmooth3");
                a4 = getConfigurationString("lgsmooth4");
                a5 = getConfigurationString("lgsmooth5");
                a6 = getConfigurationString("lgsmooth6");
                valrel = 9860;
              }

              if (int(Values[11]) == 9862) {
                a10 = getConfigurationString("unit5");
                a1 = getConfigurationString("temppidkp");
                a2 = getConfigurationString("temppidki");
                a3 = getConfigurationString("temppidkd");
                a4 = getConfigurationString("speedpidkp");
                a5 = getConfigurationString("speedpidki");
                a6 = getConfigurationString("speedpidkd");
                valrel = 9864;
              }

              if (int(Values[11]) == 9866) {
                a10 = getConfigurationString("unit6");
                a1 = getConfigurationString("hardwarelgsmooth1");
                a2 = getConfigurationString("hardwarelgsmooth2");
                a3 = getConfigurationString("hardwarelgsmooth3");
                a4 = getConfigurationString("hardwarelgsmooth4");
                a5 = getConfigurationString("hardwarelgsmooth5");
                a6 = getConfigurationString("hardwarelgsmooth6");
                valrel = 9868;
              }

              if (int(Values[11]) == 9870) {
                a1 = getConfigurationString("hardwareip1");
                a2 = getConfigurationString("hardwareip2");
                a3 = getConfigurationString("hardwareip3");
                a4 = getConfigurationString("hardwareip4");
                valrel = 9872;
              }

              if (int(Values[11]) == 9874) {
                a1 = getConfigurationString("hardwaremask1");
                a2 = getConfigurationString("hardwaremask2");
                a3 = getConfigurationString("hardwaremask3");
                a4 = getConfigurationString("hardwaremask4");
                a5 = getConfigurationString("hardwareport");
                valrel = 9876;
              }

              if (int(Values[11]) == 9878) {
                valrel = 9880;
              }

              if (int(Values[11]) == 9882) {
                cp1.getController("eeprom").setValue(0);
                valrel = 9884;
              }

              if (int(Values[11]) == 9886) {
                logEvent(" - Recorded parameters in hardware memory.");

                switch (int(getConfigurationString("hardwarebaudrate"))) {
                case 0:
                  configuration.setString("baudrate", "19200");
                  configuration.setString("buffer", "3000");
                  break;

                case 1:
                  configuration.setString("baudrate", "38400");
                  configuration.setString("buffer", "1500");
                  break;

                case 2:
                  configuration.setString("baudrate", "57600");
                  configuration.setString("buffer", "1200");
                  break;

                case 3:
                  configuration.setString("baudrate", "115200");
                  configuration.setString("buffer", "1000");
                  break;
                }

                if (int(getConfigurationString("moderxtx")) == 1) {
                  configuration.setString("moderxtx", "0");
                }

                disconnect();
                eepromst = false;
                connect();
              }
            }

            // Receive from Arduino (eeprom)
            if (!statusconnect) {
              if (int(Values[11]) == 9902) {
                valrel = 9904;
              }

              if (int(Values[11]) == 9906) {
                ut0 = Values[10];
                configuration.setString("motorpower", (Values[0]));
                configuration.setString("encoder", (Values[1]));
                configuration.setString("motorspeed", str(int(Values[2]) * 100));
                configuration.setString("serialnumber", (Values[3]));
                configuration.setString("hardwarebaudrate", (Values[4]));
                configuration.setString("moderxtx", (Values[5]));
                valrel = 9908;
              }

              if (int(Values[11]) == 9910) {
                ut1 = Values[10];
                configuration.setString("pidcontrolspeed", (Values[0]));
                configuration.setString("pidcontroltemperature", (Values[1]));
                configuration.setString("hardwaresmooth", (Values[2]));
                valrel = 9912;
              }

              if (int(Values[11]) == 9914) {
                ut2 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("lgmultiplier1", str(float(Values[0]) / 10000));
                  configuration.setString("lgmultiplier2", str(float(Values[1]) / 10000));
                  configuration.setString("lgmultiplier3", str(float(Values[2]) / 10000));
                  configuration.setString("lgmultiplier4", str(float(Values[3]) / 10000));
                  configuration.setString("lgmultiplier5", str(float(Values[4]) / 10000));
                  configuration.setString("lgmultiplier6", str(float(Values[5]) / 10000));
                }
                valrel = 9916;
              }

              if (int(Values[11]) == 9918) {
                ut3 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("lgspan1", str(float(Values[0]) / 10));
                  configuration.setString("lgspan2", str(float(Values[1]) / 10));
                  configuration.setString("lgspan3", str(float(Values[2]) / 10));
                  configuration.setString("lgspan4", str(float(Values[3]) / 10));
                  configuration.setString("lgspan5", str(float(Values[4]) / 10));
                  configuration.setString("lgspan6", str(float(Values[5]) / 10));
                }
                valrel = 9920;
              }

              if (int(Values[11]) == 9922) {
                ut4 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("lgsmooth1", (Values[0]));
                  configuration.setString("lgsmooth2", (Values[1]));
                  configuration.setString("lgsmooth3", (Values[2]));
                  configuration.setString("lgsmooth4", (Values[3]));
                  configuration.setString("lgsmooth5", (Values[4]));
                  configuration.setString("lgsmooth6", (Values[5]));
                }
                valrel = 9924;
              }

              if (int(Values[11]) == 9926) {
                ut5 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("temppidkp", (Values[0]));
                  configuration.setString("temppidki", (Values[1]));
                  configuration.setString("temppidkd", (Values[2]));
                  configuration.setString("speedpidkp", (Values[3]));
                  configuration.setString("speedpidki", (Values[4]));
                  configuration.setString("speedpidkd", (Values[5]));
                }
                valrel = 9928;
              }

              if (int(Values[11]) == 9930) {
                ut6 = Values[10];
                configuration.setString("hardwarelgsmooth1", (Values[0]));
                configuration.setString("hardwarelgsmooth2", (Values[1]));
                configuration.setString("hardwarelgsmooth3", (Values[2]));
                configuration.setString("hardwarelgsmooth4", (Values[3]));
                configuration.setString("hardwarelgsmooth5", (Values[4]));
                configuration.setString("hardwarelgsmooth6", (Values[5]));
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("unit1", ut1);
                  configuration.setString("unit2", ut2);
                  configuration.setString("unit3", ut3);
                  configuration.setString("unit4", ut4);
                  configuration.setString("unit5", ut5);
                  configuration.setString("unit6", ut6);
                }
                valrel = 9932;
              }

              if (int(Values[11]) == 9934) {
                ut5 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("hardwareip1", Values[0]);
                  configuration.setString("hardwareip2", Values[1]);
                  configuration.setString("hardwareip3", Values[2]);
                  configuration.setString("hardwareip4", Values[3]);
                }
                valrel = 9936;
              }

              if (int(Values[11]) == 9938) {
                ut5 = Values[10];
                if (int(getConfigurationString("recparameters")) == 0) {
                  configuration.setString("hardwaremask1", Values[0]);
                  configuration.setString("hardwaremask2", Values[1]);
                  configuration.setString("hardwaremask3", Values[2]);
                  configuration.setString("hardwaremask4", Values[3]);
                  configuration.setString("hardwareport", (Values[4]));
                }
                valrel = 9940;
              }

              if (int(Values[11]) == 9942) {
                if (valrel == int(Values[6])) {
                  statusconnect = true;
                }
                valrel = 9944;
              }
            }

            if (eepromst == false) {
              a1 = getConfigurationString("temppidkp");
              a2 = getConfigurationString("temppidki");
              a3 = getConfigurationString("temppidkd");
              a4 = getConfigurationString("speedpidkp");
              a5 = getConfigurationString("speedpidki");
              a6 = getConfigurationString("speedpidkd");
            }
          }
        }

        String valtempt = str(map(tptemp, float(getConfigurationString("controltempmin")), float(getConfigurationString("controltemp")), 0, 1023));
        String valmotort = str(map(mttemp, 0, int(getConfigurationString("motorspeed")), 0, 1023));
        out = valtempt + "," + valmotort + "," + str(valrel) + "," + a1 + "," + a2 + "," + a3 + "," + a4 + "," + a5 + "," + a6 + "," + str(a) + "," + str(b) + "," + str(c) + "," + str(d) + "," + a10 +",\r";      //creates the string that we will send to the Arduino

        if (!ipcon) {
          serialPort.write(out);
        }
        tret = 0;
      }
    } else {
      if (millis() > prevMilliscn) {

        if (statusok) {
          tret++;
        } else {
          tret = 0;
        }

        if (tret == 10) {

          if (startcontrol) {
            startcontrol(false);
          }

          if (reccontrol) {
            reccontrol(false);
          }

          if (statusstartrec) {
            startrec(false);
          }
          statusok = false;
          statusconnect = false;
          avg[0] = 0;
          avg[1] = 0;
          avg[2] = 0;
          avg[3] = 0;
          avg[4] = 0;
          avg[5] = 0;
          avgr[0] = 0;
          avgr[1] = 0;
          avgr[2] = 0;
          avgr[3] = 0;
          avgr[4] = 0;
          avgr[5] = 0;
          avgr[6] = 0;
          avgr[7] = 0;
          Userinfo = " - Connection lost";
          logEvent(" - Tasks completed safely.");
        }

        if (tret == 5) {
          Userinfo = " - Connection lost";
          logEvent(" - Connection lost.");
        }
        prevMilliscn = millis() + 1000;
      }
    }
  }
  catch (Exception e) {
    e.printStackTrace();  // Handle any exceptions
  }
}

// Function to create and update graphs
void Creategraph() {

  BarChart.DrawAxis();
  LineGraph.DrawAxis();
  TextGraph();

  if (democ || statusok) {
    BarChart.Bar(barChartValues);

    for (int i = 0; i < lineGraphValues.length; i++) {
      LineGraph.GraphColor = graphColors[i];

      if (int(getConfigurationString("lgvisible" + (i + 1))) == 1) {
        if (normaliz == 1) {
          cp1.getController("uppergraph").setValue(avgrt[i] + 0.5);
          cp1.getController("lowergraph").setValue(avgrt[i] - 0.5);
          cp1.getController("uppergraphb").setValue(avgrt[i] + 3);
          cp1.getController("lowergraphb").setValue(avgrt[i] - 3);
          normaliz = 0;
        }

        if (autoscale) {
          if (avgrt[i] > scaleu) {
            cp1.getController("uppergraph").setValue(avgrt[i] + 3);
          }
          if (avgrt[i] < scalel) {
            cp1.getController("lowergraph").setValue(avgrt[i] - 3);
          }
        }

        LineGraph.LineGraph(lineGraphSampleNumbers, lineGraphValues[i]);
      }

      if (!autoscale) {
        adjustGraphScale();
      }

      if (RightAxis) {
        if (statusok) {
          cp1.getController("uppergraph").setValue((1023 * float(getConfigurationString("lgmultiplier" + (i + 1)))) + float(getConfigurationString("lgspan" + (i + 1))));
          cp1.getController("lowergraph").setValue(float(getConfigurationString("lgspan" + (i + 1))));
        }
      }
    }
  }
}

// Update averages and smooth values for a given index
void updateAverages(int i) {
  avg[i] = avg[i] * (scale[i] - k[i]) / scale[i] + (int(Values[i]) * float(getConfigurationString("lgmultiplier" + (i + 1))) + float(getConfigurationString("lgspan" + (i + 1)))) * k[i];
  avgr[i] = avg[i] / scale[i];
  k[i] = (1000 - int(getConfigurationString("lgsmooth" + (i + 1)))) + abs((int(Values[i]) * float(getConfigurationString("lgmultiplier" + (i + 1))) + float(getConfigurationString("lgspan" + (i + 1))) - avgr[i]) / 0.08);
}

// Hide invisible graphs based on configuration
void hideInvisibleGraphs() {
  if (int(getConfigurationString("lgvisible1")) == 0) {
    raw[0] = "n/a";
    rawvalues[0] = "n/a";
  }

  if (int(getConfigurationString("lgvisible2")) == 0) {
    raw[1] = "n/a";
    rawvalues[1] = "n/a";
  }

  if (int(getConfigurationString("lgvisible3")) == 0) {
    raw[2] = "n/a";
    rawvalues[2] = "n/a";
  }

  if (int(getConfigurationString("lgvisible4")) == 0) {
    raw[3] = "n/a";
    rawvalues[3] = "n/a";
  }

  if (int(getConfigurationString("lgvisible5")) == 0) {
    raw[4] = "n/a";
    rawvalues[4] = "n/a";
  }

  if (int(getConfigurationString("lgvisible6")) == 0) {
    raw[5] = "n/a";
    rawvalues[5] = "n/a";
  }
}

// Adjust the scale of the graph
void adjustGraphScale() {
  if (scaleu < 0) {
    if (scaleu - scalel < 0) {
      cp1.getController("uppergraph").setValue(scalel + 0.1);
    }
  }

  if (scalel > 0) {
    if (scalel - scaleu > 0) {
      cp1.getController("lowergraph").setValue(scaleu - 0.1);
    }
  }
}
