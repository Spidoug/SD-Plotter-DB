// Function to move to the next serial port
void up() {
  if (!ipcon) {
    if (!statusconnect) {
      if (serial_list_index < (num_serial_ports - 1)) {
        serial_list_index++;
        serial_list = Serial.list()[serial_list_index];
      }
    }
  }
}

// Function to move to the previous serial port
void down() {
  if (!ipcon) {
    if (!statusconnect) {
      if (serial_list_index > 0) {
        serial_list_index--;
        serial_list = Serial.list()[serial_list_index];
      }
    }
  }
}

// Function to connect to the serial port or IP
void connect() {

  try {
    if (hexflash || eepromst) {
      cp1.getController("ipenable").setValue(0);
      ipcon = false;
    }

    if (!ipcon) {
      if (!hexflash) {
        if (!statusconnect && !democ) {

          setparameterscale = 1;

          if (num_serial_ports > 0) {
            if (licensec) {
              mockupSerial = false;
              inBuffer = new byte[int(getConfigurationString("buffer"))];

              if (!mockupSerial) {
                serialPortName = Serial.list()[serial_list_index];
                serialPort = new Serial(this, serialPortName, int(getConfigurationString("baudrate")));
                Userinfo = "";

                serialPort.clear();

                doty = 1;

                if (eepromst == true) {
                  valrel = 9836;
                } else {
                  serialPort.write("SDPlotterDB");
                  valrel = 9900;
                }
              }
            }
          }
        }
      }

      if (hexflash) {
        int programmer = 1;
        String[] readsettings = null;
        readsettings = loadStrings(topSketchPath + "/settings.txt");

        if (readsettings != null) {
          hardwarehex = readsettings[3];
          firmwareclearhex = readsettings[4];
          firmwarestdhex = readsettings[5];
          baudratehex = readsettings[6];

          if (hardwarehex.equals("atmega2560")) {
            programmer = 2;
          } else {
            programmer = 1;
          }

          if (!cleeprom) {
            File r = new File(topSketchPath + "/firmware.bat");

            if (r.exists()) {
              r.delete();
            }

            hexfile = createWriter(topSketchPath + "/firmware.bat");
            serialPortName = Serial.list()[serial_list_index];

            hexfile.println("@echo off");
            hexfile.println("echo SD Plotter DB");
            hexfile.println("echo Douglas Santana - spidoug@gmail.com");
            hexfile.println("echo.");
            hexfile.println("start avrdude -C avrdude.conf -v -c stk500v" + programmer + " -P " + serialPortName + " -b " + baudratehex + " -p " + hardwarehex + " -D  -U flash:w:" + firmwarestdhex + ":i");
            hexfile.println("endlocal");
            hexfile.println("pause");
            hexfile.flush();
            hexfile.close();

            launch(topSketchPath + "/firmware.bat");

            hexflash = false;

            // Log the firmware write
            logEvent(" - Performed firmware write.");

            configuration.setString("baudrate", "19200");
            configuration.setString("buffer", "800");
          }

          if (cleeprom) {
            File r = new File(topSketchPath + "/firmware.bat");

            if (r.exists()) {
              r.delete();
            }

            hexfile = createWriter(topSketchPath + "/firmware.bat");
            serialPortName = Serial.list()[serial_list_index];

            hexfile.println("@echo off");
            hexfile.println("echo SD Plotter DB");
            hexfile.println("echo Douglas Santana - spidoug@gmail.com");
            hexfile.println("echo.");
            hexfile.println("start avrdude -C avrdude.conf -v -c stk500v" + programmer + " -P " + serialPortName + " -b " + baudratehex + " -p " + hardwarehex + " -D  -U flash:w:" + firmwareclearhex + ":i");
            hexfile.println("endlocal");
            hexfile.println("pause");
            hexfile.flush();
            hexfile.close();

            launch(topSketchPath + "/firmware.bat");

            hexflash = false;

            // Log the ROM and EEPROM erase
            logEvent(" - ROM and EEPROM erased.");

            cleareeprom.setValue(0);
          }
        }
      }
    } else {
      opensite("http://" + getConfigurationString("ip1") + "." + getConfigurationString("ip2") + "." + getConfigurationString("ip3") + "." + getConfigurationString("ip4"));
    }
  }
  catch (Exception e) {
    e.printStackTrace();  // Handle any exceptions
  }
}

// Function to disconnect from the serial port or IP
void disconnect() {

  try {

    if (!ipcon) {
      eepromst = false;
      hexflash = false;

      if ((!statusstartrec && !startcontrol && !reccontrol && !democ) || admin) {
        if (licensec) {
          if (startcontrol) {
            startcontrol(false);
          }

          if (reccontrol) {
            reccontrol(false);
          }

          if (statusstartrec) {
            startrec(false);
          }

          // Reset averages and smooth values
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

          // Reset time variables
          millisecs1 = seconds1 = minutes1 = hour1 = day1 = 0;
          millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;

          setparameterscale = 1;

          if (num_serial_ports > 0) {
            statusok = false;
            statusconnect = false;
            mockupSerial = true;
            serialPort.clear();
            serialPort.stop();
            mockupSerial = true;
            mockupSerial = false;

            if (!mockupSerial) {
              serialPortName = Serial.list()[serial_list_index];
              serialPort = new Serial(this, serialPortName, int(getConfigurationString("baudrate")));
              Userinfo = "";
            }
          }

          statusok = false;
          statusconnect = false;
          mockupSerial = true;
          serialPort.clear();
          serialPort.stop();
          mockupSerial = true;
          timesmooth = 0;

          // Log the disconnection
          logEvent(" - Disconnected from systems.");
        }
      }
    } else {
      eepromst = false;
      hexflash = false;
    }
  }
  catch (Exception e) {
    e.printStackTrace();  // Handle any exceptions
  }
}

// Function to refresh the serial port list
void refresh() {
  if (!ipcon) {
    if (!statusconnect && !democ) {
      num_serial_ports = Serial.list().length;

      if (num_serial_ports > 0) {
        serial_list = Serial.list()[serial_list_index];
      }

      if (num_serial_ports == 0) {
        serial_list = "NULL";
      }
    }
  }
}

// Function to open control windows
void control() {
  ontopcont = true;
  if (wincontrol == null) {
    wincontrol = new PWindowcl(primaryX, primaryY);
    modevisible1 = 1;
  }

  if (wincondition == null && RightAxis) {
    wincondition = new PWindowcnd(primaryX, primaryY);
    modevisible4 = 1;
  }
}

// Function to open the database window
void database() {
  ontopdat = true;
  if (windatabase == null) {
    windatabase = new PWindowd(primaryX, primaryY);
    modevisible3 = 1;
  }
}

// Function to handle login process
void login() {
  windowslogin.hide();
  modemanageruser = 0;
  createuser.hide();
  deleteuser.hide();
  administrator.hide();
  upuser.hide();
  downuser.hide();
  password.show();
  isTabPressed = false;
  user.setText("");
  password.setText("");
  Systeminfo = "";
  Userinfo = "";
  window3 = "SD Plotter DB® - Login";
  login = true;
  modelogin = true;
  modevisible0 = 1;
  modevisible1 = 1;
  modevisible2 = 1;
  modevisible3 = 1;
  modevisible4 = 1;
  user.setFocus(true);
  password.setFocus(false);
  user.setLock(false);
  password.setLock(false);

  // Log the login box opening
  logEvent(" - Open login box.");

  if (statusstartrec || startcontrol || reccontrol) {
    isTabPressed = true;
    valueps = username;
    user.setText(username);
    user.setFocus(false);
    password.setFocus(true);
  }
}

// Function to open the settings window
void settingssd() {
  ontopsett = true;
  if (winsetting == null) {
    winsetting = new PWindows(primaryX, primaryY);
    modevisible2 = 1;
  }
}

// Function to set the upper graph scale
void uppergraph(float f) {
  scaleu = f;
}

// Function to set the lower graph scale
void lowergraph(float f) {
  scalel = f;
}


// Function to set the upper graph scale for the second graph
void uppergraphb(float f) {
  scaleub = f;
}

// Function to set the lower graph scale for the second graph
void lowergraphb(float f) {
  scalelb = f;
}

// Function to enable or disable marker
void marker(boolean theFlag) {
  if (!theFlag) {
    ShowMouseLines = false;
  }

  if (theFlag) {
    ShowMouseLines = true;
  }
}

// Function to control recording
void reccontrol(boolean theFlag) {
  if (statusok) {
    if (theFlag) {

      startcontrol = false;
      cp1.getController("startcontrol").setValue(0);

      datafilemethod = "SDPlotterDB_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + username + ".mrt";

      Userinfo = " - Recording Method";
      status_met = "Recording Method";
      datainfo = " - " + datafilemethod;
      numberfile = datafilemethod;

      // Log the method recording initialization
      logEvent(" - Method recording initialization. // " + datafilemethod);

      lastTimeUpdate_cr = 0;

      methodout = "";

      millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;

      reccontrol = true;
    }

    if (!theFlag) {

      reccontrol = false;
      methodout = methodout + (str(tptemp) + ";" + str(mttemp) + ";" + str(c) + ";" + str(d) + ";1");
      encryptFile(keys, methodout, topSketchPath + "/method/" + username + "/" + datafilemethod);

      if (!reccontrol && !startcontrol) {
        try {
          String encryptedTextBase64 = join(loadStrings(topSketchPath + "/method/" + username + "/" + numberfile), "\n");
          byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);
          SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
          Cipher cipher = Cipher.getInstance("AES");
          cipher.init(Cipher.DECRYPT_MODE, secretKey);
          byte[] decryptedText = cipher.doFinal(encryptedText);
          myStringsmet = split(new String(decryptedText), "\n");
        }
        catch (Exception e) {
          myStringsmet = null;
          e.printStackTrace();
        }

        refreshmethod = true;

        Userinfo = " - Stop method recording";
        status_met = "   Stop recording";
        Timer2final();

        // Log the method recording stop
        logEvent(" - Finishing the method recording. // " + datafilemethod);
      }

      if (int(getConfigurationString("ativdir")) == 1) {
        dirResources = topSketchPath + "/method/" + username + "/";
        loadImageIntoDB(datafilemethod, "Blob");
      }

      methodsmain();
    }
  }
}

// Function to start control
void startcontrol(boolean theFlag) {
  if (statusok) {
    if (theFlag) {
      if (myStringsmet == null) {
        cp1.getController("startcontrol").setValue(0);
        deletemt = false;
        status_met = "      No method";
        datainfo = "";

        // Log the no method file recorded
        logEvent(" - There is no method file recorded for playback.");
      } else {
        dotr = 1;
      }
    }

    if (myStringsmet.length == 0) {
      startcontrol = false;
      cp1.getController("startcontrol").setValue(0);
    } else {
      startcontrol = true;
    }

    if (!theFlag) {
      startcontrol = false;
      lastTimeUpdate_pl = 0;
      millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;
      imet = 0;

      if (!reccontrol) {
        dotpu = 1;

        if (dotp == 1) {
          dotpu = 0;
        }
      }
    }
  }
}

// Function to start recording
void startrec(boolean theFlag) {
  if (theFlag) {
    if (statusok) {
      datamoment = "SDPlotterDB_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + username + ".sdpl";
      datasout = "";
      numberbt = 0;
      millisecs1 = seconds1 = minutes1 = hour1 = day1 = 0;
      statusstartrec = true;
      setparametersdata = 1;
    }
  }

  if (!theFlag) {
    if (statusok) {
      datasout = datasout + ("Total time:;;;" + day1 + ";" + hour1 + ";" + minutes1 + ";" + seconds1 + ";" + millisecs1 + ";");
      encryptFile(keys, datasout, topSketchPath + "/data/" + username + "/" + datamoment);
      statusstartrec = false;
      status_rec = "           Stop";
      Userinfo = " - Stopped data recording";

      // Log the data recording stop
      logEvent(" - Finished recording analytics data.");

      if (int(getConfigurationString("ativdir")) == 1) {
        dirResources = topSketchPath + "/data/" + username + "/";
        loadImageIntoDB(datamoment, "Blob");
      }

      tablesmain();
    }
  }
}

// Function to take a snapshot
void snapshotcallmain() {
  datamomentsnap = "SDPlotterDB_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + "_" + username + ".png";
  saveFrame(topSketchPath + "/snapshot/" + username + "/" + datamomentsnap);

  if (int(getConfigurationString("ativdir")) == 1) {
    dirResources = topSketchPath + "/snapshot/" + username + "/";
    loadImageIntoDB(datamomentsnap, "Blob");
  }

  // Log the snapshot generation
  logEvent(" - Generated snapshot. // " + datamomentsnap);

  othersmain();
}

// Function to toggle unit mode
void unit(boolean theFlag) {
  if (theFlag) {
    modeunit = true;
  }

  if (!theFlag) {
    modeunit = false;
  }
}

// Function to toggle autoscale
void autoscale(boolean theFlag) {
  if (theFlag) {
    autoscale = true;
  }

  if (!theFlag) {
    autoscale = false;
  }
}

// Function to toggle monitor view
void monitor(boolean theFlag) {
  if (theFlag) {
    Viewgraph = false;
  }

  if (!theFlag) {
    Viewgraph = true;
  }
}

// Function to normalize the graph scale
void normalizesd() {
  float normscalev = pow((scaleu - scalel), 2) * 0.0125;
  cp1.getController("gpbr").setValue(normscalev);
  cp1.getController("gpct").setValue(normscalev);
  normaliz = 1;
}

// Function to enable EEPROM mode
void eeprom(boolean theFlag) {
  if (theFlag) {
    eepromst = true;
    cp1.getController("inputs_1").setColorBackground(#FAC7C7);
    cp1.getController("inputs_2").setColorBackground(#FAC7C7);
    cp1.getController("inputs_3").setColorBackground(#FAC7C7);
    cp1.getController("inputs_4").setColorBackground(#FAC7C7);
    cp1.getController("inputs_5").setColorBackground(#FAC7C7);
    cp1.getController("inputs_6").setColorBackground(#FAC7C7);
  }
}

// Function to enable hexflash mode
void savehex(boolean theFlag) {
  if (theFlag) {
    hexflash = true;
  }
}

// Function to enable or disable IP connection
void ipenable(boolean theFlag) {
  if (theFlag) {
    ipcon = true;
  }

  if (!theFlag) {
    ipcon = false;
    refresh();
  }
}
