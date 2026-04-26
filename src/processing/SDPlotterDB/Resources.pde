void Machinecode() {
  // Generate a random registration pair within the specified range
  regpair = random(1000, 500000);

  // If configuration is null, initialize it
  if (configuration == null) {
    configuration = new JSONObject();

    // Define default properties
    Object[][] properties = {
      {"ativdir", "0"}, {"autoscale", "1"}, {"baudrate", "19200"}, {"buffer", "5000"},
      {"controltemp", "5"}, {"directory", "C:"}, {"dout1", "0"}, {"dout2", "0"},
      {"encoder", "3"}, {"externalevent", "0"}, {"fnkey", "1"}, {"graph1", "255"},
      {"graph2", "0"}, {"graph3", "255"}, {"graph4", "0"}, {"graph5", "225"},
      {"graph6", "170"}, {"hardwareip1", "192"}, {"hardwareip2", "168"},
      {"hardwareip3", "0"}, {"hardwareip4", "77"}, {"hardwarelgsmooth1", "1"},
      {"hardwarelgsmooth2", "1"}, {"hardwarelgsmooth3", "1"}, {"hardwarelgsmooth4", "1"},
      {"hardwarelgsmooth5", "1"}, {"hardwarelgsmooth6", "1"}, {"hardwaresmooth", "0"},
      {"hardwarebaudrate", "0"}, {"hardwaremask1", "255"}, {"hardwaremask2", "255"},
      {"hardwaremask3", "255"}, {"hardwaremask4", "0"}, {"hardwareport", "80"},
      {"ip1", "192"}, {"ip2", "168"}, {"ip3", "0"}, {"ip4", "77"}, {"ipserial", "0"},
      {"knob1", "0"}, {"knob2", "0"}, {"lgmultiplier1", "0.0049"}, {"lgmultiplier2", "0.0049"},
      {"lgmultiplier3", "0.0049"}, {"lgmultiplier4", "0.0049"}, {"lgmultiplier5", "0.0049"},
      {"lgmultiplier6", "0.0049"}, {"lgmultiplier7", "0.0049"}, {"lgmultiplier8", "0.0049"},
      {"lgsmooth1", "0"}, {"lgsmooth2", "0"}, {"lgsmooth3", "0"}, {"lgsmooth4", "0"},
      {"lgsmooth5", "0"}, {"lgsmooth6", "0"}, {"lgspan1", "0"}, {"lgspan2", "0"},
      {"lgspan3", "0"}, {"lgspan4", "0"}, {"lgspan5", "0"}, {"lgspan6", "0"},
      {"lgspan7", "0"}, {"lgspan8", "0"}, {"lgvisible1", "1"}, {"lgvisible2", "1"},
      {"lgvisible3", "1"}, {"lgvisible4", "1"}, {"lgvisible5", "1"}, {"lgvisible6", "1"},
      {"lgvisible7", "0"}, {"lgvisible8", "0"}, {"license", "10"}, {"licensevalidation", "0"},
      {"machinecode", "0"}, {"marker", "1"}, {"methodcond1", ""}, {"methodcond2", ""},
      {"moderxtx", "0"}, {"motorpower", "300"}, {"motorspeed", "3000"}, {"pairsecrtst", str(regpair)},
      {"pidcontrolspeed", "0"}, {"pidcontroltemperature", "0"}, {"probecond1", "0"},
      {"probecond2", "0"}, {"probecond3", "0"}, {"probecond4", "0"}, {"probecond5", "0"},
      {"probecond6", "0"}, {"ratesampling", "305"}, {"relay1", "0"}, {"relay2", "0"},
      {"relaycond1", "0"}, {"relaycond2", "0"}, {"relaycond3", "0"}, {"relaycond4", "0"},
      {"recparameters", "0"}, {"savedata", "1"}, {"sensor1", "Probe 1"}, {"sensor2", "Probe 2"},
      {"sensor3", "Probe 3"}, {"sensor4", "Probe 4"}, {"sensor5", "Probe 5"}, {"sensor6", "Temperature"},
      {"sensor7", "Speed"}, {"sensor8", "Torque"}, {"speedpidkp", "1000"}, {"speedpidki", "100"},
      {"speedpidkd", "10"}, {"sqlmode", "file"}, {"serialnumber", "1"}, {"temppidkp", "1000"},
      {"temppidki", "100"}, {"temppidkd", "10"}, {"timeleft", "20"}, {"unit1", "Unit 1"},
      {"unit2", "Unit 2"}, {"unit3", "Unit 3"}, {"unit4", "Unit 4"}, {"unit5", "Unit 5"},
      {"unit6", "°C"}, {"unit7", "RPM"}, {"unit8", "Ncm"}, {"uuid", infopc}, {"valuecond1", "0"},
      {"valuecond2", "0"}, {"valuecond3", "0"}, {"valuecond4", "0"}, {"valuecond5", "0"},
      {"valuecond6", "0"}, {"winlogin", "0"}
    };

    setConfigurationProperties(properties);

    // Log creation of new configuration file
    logEvent(" - Created new configuration file.");
  }

  try {
    // Load and decrypt user data
    String encryptedTextBase64 = join(loadStrings(topSketchPath + "/users.dat"), "\n");
    byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

    SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
    Cipher cipher = Cipher.getInstance("AES");
    cipher.init(Cipher.DECRYPT_MODE, secretKey);

    byte[] decryptedText = cipher.doFinal(encryptedText);
    idlist = parseJSONObject(new String(decryptedText));
  }
  catch (Exception e) {
    e.printStackTrace();

    // Create a new user list file if decryption fails
    JSONObject idlist = new JSONObject();
    JSONArray pairsec = new JSONArray();
    pairsec.append(str(regpair));

    for (int i = 1; i <= 2; i++) {
      JSONArray usersid = new JSONArray();
      usersid.append("827ccb0eea8a706c4c34a16891f84e7b");
      usersid.append("1");
      idlist.setJSONArray("(*836*$#@)Admin", usersid);
      idlist.setJSONArray("pairsecrtid", pairsec);
    }

    encryptFile(keys, idlist.toString(), topSketchPath + "/users.dat");

    // Log creation of new user list file
    logEvent(" - Created new user list file.");
  }

  try {
    // Load and decrypt user data again
    String encryptedTextBase64 = join(loadStrings(topSketchPath + "/users.dat"), "\n");
    byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

    SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
    Cipher cipher = Cipher.getInstance("AES");
    cipher.init(Cipher.DECRYPT_MODE, secretKey);

    byte[] decryptedText = cipher.doFinal(encryptedText);
    idlist = parseJSONObject(new String(decryptedText));
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  properties = (String[]) idlist.keys().toArray(new String[idlist.size()]);
  vld = idlist.getJSONArray("pairsecrtid");

  // Retrieve machine code from configuration
  keyinopen = int(getConfigurationString("machinecode"));

  // Generate a new machine code if the current one is out of the valid range
  if (keyinopen <= 100000 || keyinopen >= 100000000) {
    for (int i = 0; i < 100; i++) {
      float r = random(1000, 5000);
      float d = random(1, 999);
      keyinopen = ((int(r) * 152539) / (int(d)));
    }

    if (keyinopen >= 100000 & keyinopen <= 100000000) {
      configuration.setString("machinecode", str(keyinopen));
      saveJsonToRegistry(mainKey, "Settings");
    }
  }

  // Set code based on machine code range
  if (keyinopen < 216589) {
    xcode = "jYo";
  } else if (keyinopen > 216588 & keyinopen < 508658) {
    xcode = "FDs";
  } else if (keyinopen > 508657 & keyinopen < 1208658) {
    xcode = "AsR";
  } else if (keyinopen > 1208657) {
    xcode = "Dgt";
  }

  // Generate license validation code
  keyoutopen = str(((keyinopen) / 23) * 1256) + xcode + str(keyinopen / 770);
  configuration.setString("licensevalidation", keyoutopen);
}

void Activation() {
  // Check if the current UUID matches the stored UUID
  if (getConfigurationString("uuid").equals(infopc)) {

    // Check if the license is valid or if there is time left
    if (getConfigurationString("license").equals(keyoutopen) || getConfigurationString("license").equals("All5@fe4u") || int(getConfigurationString("timeleft")) > 0) {
      mode = " - Activated";
      licensec = true;
    } else {
      licensec = false;
    }

    // If the license is valid, set the time left to 0
    if (getConfigurationString("license").equals(keyoutopen) || getConfigurationString("license").equals("All5@fe4u")) {
      configuration.setString("timeleft", "0");
    } else {
      // If there is time left, set the mode to show the deadline
      if (int(getConfigurationString("timeleft")) > 0) {
        mode = " - Deadline to expire trial mode (" + getConfigurationString("timeleft") + ")";
      }
    }
  } else {
    licensec = false;
  }

  // If the license is not valid
  if (!licensec) {
    status_on = "   Unlicensed";
    mode = " - Not Activated ";

    // Set the status operation based on the demonstration mode
    if (democ) {
      statusoperation = " - Demonstration";
    } else {
      statusoperation = " - Offline";
    }
  }
}

public void tablesmain() {

  try {
    pointer = null;

    // Check if the folder path is not null
    if (folderPath == null) {
    } else {
      // Check if the folder path matches the user's data folder
      if ((folderPath).equals(topSketchPath + "/data/" + username)) {
        fileNames = reverse(listFileNames(folderPath, txtFilter));

        // If no files are found, initialize an empty file name array
        if (fileNames == null) {
          fileNames = new String[1];
          fileNames[0] = "";
        }

        // Display the file names in the GUI
        if (windatabase != null) {
          if (cp5 != null) {
            myTextarea.hide();
            initialBodyList.setLabel("Tables");
            initialBodyList.show().setOpen(true);
            initialBodyList.setItems(fileNames);
          }
        }
      }
    }
  }
  catch (Exception e) {
    println("Error" + e.getMessage());
    e.printStackTrace();
  }
}

public void methodsmain() {

  try {
    pointer = null;

    // Check if the folder path is not null
    if (folderPath == null) {
    } else {
      // Check if the folder path matches the user's method folder
      if ((folderPath).equals(topSketchPath + "/method/" + username)) {
        fileNames = reverse(listFileNames(folderPath, txtFilter));

        // If no files are found, initialize an empty file name array
        if (fileNames == null) {
          fileNames = new String[1];
          fileNames[0] = "";
        }

        // Display the file names in the GUI
        if (windatabase != null) {
          if (cp5 != null) {
            myTextarea.hide();
            initialBodyList.setLabel("Methods");
            initialBodyList.show().setOpen(true);
            initialBodyList.setItems(fileNames);
          }
        }
      }
    }
  }
  catch (Exception e) {
    println("Error" + e.getMessage());
    e.printStackTrace();
  }
}

public void othersmain() {

  try {
    pointer = null;

    // Check if the folder path is not null
    if (folderPath == null) {
    } else {
      // Check if the folder path matches the user's snapshot folder
      if ((folderPath).equals(topSketchPath + "/snapshot/" + username)) {
        fileNames = reverse(listFileNames(folderPath, txtFilter));

        // If no files are found, initialize an empty file name array
        if (fileNames == null) {
          fileNames = new String[1];
          fileNames[0] = "";
        }

        // Display the file names in the GUI
        if (windatabase != null) {
          if (cp5 != null) {
            myTextarea.hide();
            initialBodyList.setLabel("Snapshots");
            initialBodyList.show().setOpen(true);
            initialBodyList.setItems(fileNames);
          }
        }
      }
    }
  }
  catch (Exception e) {
    println("Error" + e.getMessage());
    e.printStackTrace();
  }
}

public void createusermain() {
  // Initialize the GUI for creating a user
  login = true;
  modelogin = false;
  modemanageruser = 1;
  user.setLock(false);
  password.setLock(false);
  createuser.hide();
  deleteuser.show();
  administrator.show();
  upuser.hide();
  downuser.hide();
  password.show();
  window3 = "Create User";
  Systeminfo = "";
  isTabPressed = false;
  user.setText("");
  password.setText("");
  user.setFocus(true);
  password.setFocus(false);
}

// Get a configuration value as a string
String getConfigurationString(String id) {
  String r = "";
  try {
    r = configuration.getString(id);
  }
  catch (Exception e) {
    r = "";
  }
  return r;
}

void opensite(String url) {
  try {
    // Open the given URL in the default web browser
    if (Desktop.isDesktopSupported()) {
      Desktop desktop = Desktop.getDesktop();
      desktop.browse(new java.net.URI(url));
    } else {
      println("No supported.");
    }
  }
  catch (Exception e) {
    println("Error" + e.getMessage());
    e.printStackTrace();
  }
}

// Get a scale value as a string
String getScaleString(String id) {
  String r = "";
  try {
    r = scalegraph.getString(id);
  }
  catch (Exception e) {
    r = "";
  }
  return r;
}

void saveJsonToRegistry(String mainKey, String key) {
  // Save the configuration JSON to the system registry
  Preferences prefs = Preferences.userRoot().node(mainKey);
  prefs.put(key, configuration.toString());
}

void readJsonFromRegistry(String mainKey, String key) {
  // Read the configuration JSON from the system registry
  Preferences prefs = Preferences.userRoot().node(mainKey);
  String jsonString = prefs.get(key, null);

  if (jsonString != null) {
    configuration = parseJSONObject(jsonString);
  } else {
  }
}

String executeCommand(String[] command) {
  // Execute a system command and return the result as a string
  String result = null;
  try {
    Process process = Runtime.getRuntime().exec(command);
    process.waitFor();
    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
    StringBuilder stringBuilder = new StringBuilder();
    String line;

    while ((line = reader.readLine()) != null) {
      stringBuilder.append(line);
    }

    result = stringBuilder.toString().trim();
  }
  catch (IOException | InterruptedException e) {
    e.printStackTrace();
  }
  return result;
}

String[] listFileNames(String dir, java.io.FilenameFilter extension) {
  // List file names in a directory with a specified extension
  File file = new File(dir);

  if (file.isDirectory()) {
    String names[] = file.list(extension);
    return names;
  } else {
    return null;
  }
}

String[] getFilesFromDataFolder() {
  // Get the list of files from the data folder
  return dataFile("").list();
}

boolean readyToClose() {
  // Check if the system is ready to close
  if (statusok) {
    return true;
  } else {
    return false;
  }
}

public void closesec() {
  // Close the session and save the current state
  if (statusconnect == true) {
    disconnect();
  }

  configuration.setString("lastfile", numberfile);

  // Set the license if it's valid
  if (getConfigurationString("license").equals("All5@fe4u")) {
    configuration.setString("license", keyoutopen);
  }

  // Log the closing of the software
  logEvent(" - Closed software.");

  oldlogs = oldlogs + "--------------------------------" + "\r\n";

  encryptFile(keys, oldlogs, topSketchPath + "/log.dat");

  // Stop the server if it's running
  if (int(getConfigurationString("ativdir")) == 1) {
    try {
      stopServer();

      if (stmt != null) {
        stmt.close();
      }

      closeDBbyServer();
    }
    catch (Exception sqlExcept) {
    }
  }

  saveJsonToRegistry(mainKey, "Settings");

  // Delete the firmware file if it exists
  File r = new File(topSketchPath + "/firmware.bat");
  if (r.exists()) {
    r.delete();
  }

  System.exit(0);
}

void Timer1() {
  // Update the timer if recording is started
  if (statusstartrec) {
    if (int(millis() / 100) % 10 != millisecs1) {
      millisecs1++;
    }

    if (millisecs1 >= 10) {
      millisecs1 -= 10;
      seconds1++;
    }

    if (seconds1 >= 60) {
      seconds1 -= 60;
      minutes1++;
    }

    if (minutes1 >= 60) {
      minutes1 -= 60;
      hour1++;
    }

    if (hour1 >= 24) {
      hour1 -= 24;
      day1++;
    }
  }
}

void Timer2() {
  // Update the second timer if control or recording is started
  if (startcontrol || reccontrol) {
    if (int(millis() / 100) % 10 != millisecs2) {
      millisecs2++;
    }

    if (millisecs2 >= 10) {
      millisecs2 -= 10;
      seconds2++;
    }

    if (seconds2 >= 60) {
      seconds2 -= 60;
      minutes2++;
    }

    if (minutes2 >= 60) {
      minutes2 -= 60;
      hour2++;
    }

    if (hour2 >= 24) {
      hour2 -= 24;
      day2++;
    }
  }
}

// Finalizing the timer
void Timer1final() {
  updatetimeshdat2AndTimeshseldat();
}

void updatetimeshdat2AndTimeshseldat() {
  if (int(timesdatadisplay[3]) != 0) {

    if (int(timesdatadisplay[4]) != 0) {
      timeshdat1 = "h";
    } else if (int(timesdatadisplay[5]) != 0) {
      timeshdat1 = "min";
    } else if (int(timesdatadisplay[6]) != 0) {
      timeshdat1 = "s";
    } else {
      timeshdat1 = "ms";
    }

    timeshdat2 = "day(s)";
    timeshseldat = int(timesdatadisplay[3]) + (int(timesdatadisplay[4]) * 0.01) + (int(timesdatadisplay[5]) * 0.0001);
  } else if (int(timesdatadisplay[4]) != 0) {
    timeshdat1 = "h";
    timeshdat2 = "h";
    timeshseldat = int(timesdatadisplay[4]) + (int(timesdatadisplay[5]) * 0.01);
  } else if (int(timesdatadisplay[5]) != 0) {
    timeshdat1 = "min";
    timeshdat2 = "min";
    timeshseldat = int(timesdatadisplay[5]) + (int(timesdatadisplay[6]) * 0.01);
  } else if (int(timesdatadisplay[6]) != 0) {
    timeshdat1 = "s";
    timeshdat2 = "s";
    timeshseldat = int(timesdatadisplay[6]) + (int(timesdatadisplay[7]) * 0.1);
  } else {
    timeshdat1 = "ms";
    timeshdat2 = "ms";
    timeshseldat = int(timesdatadisplay[7]);
  }
}

void Timer2final() {
  // Final update to the second timer when control or recording is stopped
  if (!startcontrol || !reccontrol) {

    // Calculate the total time in milliseconds, rounding based on string length

    int tempMillis = round((myStringsmet.length - 1) * 510);
    
    // Set default time unit to seconds
    timesh = "s";
    timeshsel = (tempMillis % 60000) / 1000.0;  // Time in seconds

    // If the time is greater than or equal to 1 minute but less than 1 hour
    if ((tempMillis % 3600000) / 60000 >= 1 && (tempMillis % 3600000) / 60000 <= 59) {
      timesh = "min";
      timeshsel = (tempMillis % 3600000) / 60000 + (tempMillis % 60000) / 1000.0 / 100;  // Time in minutes and seconds
    }

    // If the time is greater than or equal to 1 hour but less than 24 hours
    if ((tempMillis / 3600000) >= 1 && (tempMillis / 3600000) < 24) {
      timesh = "h";
      timeshsel = (tempMillis / 3600000) + (tempMillis % 3600000) / 60000.0 / 100;  // Time in hours and minutes
    }

    // If the time is greater than or equal to 1 day
    if (tempMillis / 86400000 >= 1) {
      timesh = "day(s)";
      int rest = (tempMillis / 3600000) - (24 * (tempMillis / 86400000));  // Remaining hours within the current day
      timeshsel = (tempMillis / 86400000) + rest / 10.0;  // Time in days and hours
    }

    // Update time variables for days, hours, minutes, and seconds
    day2 = tempMillis / 86400000;  // Days
    hour2 = (tempMillis / 3600000) % 24;  // Hours within the day
    minutes2 = (tempMillis % 3600000) / 60000;  // Minutes within the hour
    seconds2 = (tempMillis % 60000) / 1000;  // Seconds within the minute
    millisecs2 = int((tempMillis % 1000) / 100);  // Remaining milliseconds
  }
}

// Function to get text from clipboard
String GetTextFromClipboard() {
  String text = (String) GetFromClipboard(DataFlavor.stringFlavor);
  if (text == null)
    return "";
  return text;
}

Object GetFromClipboard(DataFlavor flavor) {
  Clipboard clipboard = getJFrame(getSurface()).getToolkit().getSystemClipboard();
  Transferable contents = clipboard.getContents(null);
  Object object = null; // the potential result

  // Check if the contents are available and supported
  if (contents != null && contents.isDataFlavorSupported(flavor) & admin & RightAxis) {
    try {
      object = contents.getTransferData(flavor);
    }
    catch (UnsupportedFlavorException e1) {
      e1.printStackTrace();
    }
    catch (java.io.IOException e2) {
      e2.printStackTrace();
    }
  }
  return object;
}

// Cast the PSurface to a PSurfaceAWT.SmoothCanvas to access its frame
static final javax.swing.JFrame getJFrame(final PSurface surf) {
  return (javax.swing.JFrame)
    ((processing.awt.PSurfaceAWT.SmoothCanvas) surf.getNative()).getFrame();
}

// called each time the chart settings are changed by the user
void setChartSettings() {
  // Update chart settings based on the mode (demonstration or calibration)
  if (democ) {
    LineGraph.Alert = "DEMONSTRATION";
    BarChart.Alert = "DEMONSTRATION";
  } else {
    if (RightAxis) {
      LineGraph.Alert = "        CALIBRATION";
      BarChart.Alert = "        CALIBRATION";
    } else {
      LineGraph.Alert = "";
      BarChart.Alert = "";
    }
  }

  // Set labels and titles for bar and line charts
  BarChart.xLabel = " Readings ";
  BarChart.yLabel = "Amplitude";
  BarChart.Title = "Bar Chart";
  BarChart.yDiv = int(getScaleString("div"));
  BarChart.xDiv = int(getScaleString("div"));
  BarChart.yMax = scaleub;
  BarChart.yMin = scalelb;
  LineGraph.xLabel = "Sampling =";
  LineGraph.yLabel = "Amplitude";
  LineGraph.Title = "Line Chart";
  LineGraph.yDiv = int(getScaleString("div"));
  LineGraph.xDiv = int(getScaleString("div"));
  LineGraph.xMax = int(getConfigurationString("ratesampling"));
  LineGraph.xMin = 0;
  LineGraph.yMax = scaleu;
  LineGraph.yMin = scalel;
}

void encryptFile(String keys, String text, String filePath) {
  // Encrypt a file using AES encryption
  try {
    SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
    Cipher cipher = Cipher.getInstance("AES");
    cipher.init(Cipher.ENCRYPT_MODE, secretKey);

    byte[] encryptedText = cipher.doFinal(text.getBytes());
    String encryptedTextBase64 = Base64.getEncoder().encodeToString(encryptedText);

    PrintWriter output = createWriter(filePath);
    output.println(encryptedTextBase64);
    output.close();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

public PImage[] loadImages(String... paths) {
  // Load images from specified paths
  PImage[] images = new PImage[paths.length];
  for (int i = 0; i < paths.length; i++) {
    try {
      images[i] = loadImage(topSketchPath + paths[i]);
      if (images[i] == null) {
        System.err.println("Error: Failed to load image at path: " + topSketchPath + paths[i]);
      }
    }
    catch (Exception e) {
      System.err.println("Exception while loading image at path: " + topSketchPath + paths[i]);
      e.printStackTrace();
    }
  }
  return images;
}

void setConfigurationProperties(Object[][] properties) {
  // Set multiple configuration properties from an array
  for (Object[] property : properties) {
    configuration.setString((String) property[0], (String) property[1]);
  }
}

void Conditions() {
  // Check if the status is okay to proceed with conditions
  if (statusok) {

    // Probe Condition 1
    if (int(getConfigurationString("probecond1")) > 0) {
      // Check if the average reading exceeds a configured value
      if (avgrt[int(getConfigurationString("probecond1")) - 1] > float(getConfigurationString("valuecond1"))) {

        // Set relay conditions based on configuration
        if (int(getConfigurationString("relaycond1")) == 1) {
          a = 1;
        } else {
          a = 0;
        }

        if (int(getConfigurationString("relaycond1")) == 2) {
          b = 1;
        } else {
          b = 0;
        }
      }
    }

    // Probe Condition 2
    if (int(getConfigurationString("probecond2")) > 0) {
      // Check if the average reading exceeds a configured value
      if (avgrt[int(getConfigurationString("probecond2")) - 1] > float(getConfigurationString("valuecond2"))) {
        if (int(getConfigurationString("relaycond2")) == 1) {
          a = 1;
        }
        if (int(getConfigurationString("relaycond2")) == 2) {
          b = 1;
        }
      } else {

        if (int(getConfigurationString("relaycond2")) == 1) {
          a = 0;
        }
        if (int(getConfigurationString("relaycond2")) == 2) {
          b = 0;
        }
      }
    }

    // Probe Condition 3
    if (int(getConfigurationString("probecond3")) > 0) {
      // Check if the average reading is below a configured value
      if (avgrt[int(getConfigurationString("probecond3")) - 1] < float(getConfigurationString("valuecond3"))) {
        if (int(getConfigurationString("relaycond3")) == 1) {
          a = 1;
        } else {
          a = 0;
        }

        if (int(getConfigurationString("relaycond3")) == 2) {
          b = 1;
        } else {
          b = 0;
        }
      }
    }

    // Probe Condition 4
    if (int(getConfigurationString("probecond4")) > 0) {
      // Check if the average reading is below a configured value
      if (avgrt[int(getConfigurationString("probecond4")) - 1] < float(getConfigurationString("valuecond4"))) {
        if (int(getConfigurationString("relaycond4")) == 1) {
          a = 1;
        }
        if (int(getConfigurationString("relaycond4")) == 2) {
          b = 1;
        }
      } else {

        if (int(getConfigurationString("relaycond4")) == 1) {
          a = 0;
        }
        if (int(getConfigurationString("relaycond4")) == 2) {
          b = 0;
        }
      }
    }

    // Probe Condition 5
    if (int(getConfigurationString("probecond5")) > 0) {
      if (!startcontrol && !reccontrol && !democ) {
        if (avgrt[int(getConfigurationString("probecond5")) - 1] > float(getConfigurationString("valuecond5"))) {
          try {
            String encryptedTextBase64 = join(loadStrings(getConfigurationString("methodcond1")), "\n");
            byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

            SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);

            byte[] decryptedText = cipher.doFinal(encryptedText);
            myStringsmet = split(new String(decryptedText), "\n");
          }
          catch (Exception e) {
            e.printStackTrace();
          }

          if (myStringsmet != null) {
            datainfo = " - " + getConfigurationString("methodcond1");

            // Log the condition met
            logEvent(" - Condition met for method start. // ");

            Timer2final();
            refreshmethod = true;

            millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;

            startcontrolb.setValue(1);
          }
        }
      }
    }

    // Probe Condition 6
    if (int(getConfigurationString("probecond6")) > 0) {
      if (!startcontrol && !reccontrol && !democ) {
        if (avgrt[int(getConfigurationString("probecond6")) - 1] < float(getConfigurationString("valuecond6"))) {
          try {
            String encryptedTextBase64 = join(loadStrings(getConfigurationString("methodcond2")), "\n");
            byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

            SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);

            byte[] decryptedText = cipher.doFinal(encryptedText);
            myStringsmet = split(new String(decryptedText), "\n");
          }
          catch (Exception e) {
            e.printStackTrace();
          }

          if (myStringsmet != null) {
            datainfo = " - " + getConfigurationString("methodcond2");

            // Log the condition met
            logEvent(" - Condition met for method start. // ");

            Timer2final();
            refreshmethod = true;

            millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;

            startcontrolb.setValue(1);
          }
        }
      }
    }
  }
}

String getRegionIdentifier(int mouseX, int mouseY, String[] regions) {
  for (String region : regions) {
    String[] parts = region.split(",");
    int x1 = Integer.parseInt(parts[0]);
    int x2 = Integer.parseInt(parts[1]);
    int y1 = Integer.parseInt(parts[2]);
    int y2 = Integer.parseInt(parts[3]);
    String identifier = parts[4];

    if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
      return identifier;
    }
  }
  return "";
}

void gpbr(float f) {
  // Implement gpbr function
}

void gpct(float f) {
  // Implement gpct function
}

void ratesampling(int f) {
  // Implement ratesampling function
}

void savedata(float f) {
  // Implement savedata function
}

void Task() {
  if (statusok == false) {

    if (admin == true) {

      if (unit1.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit1.setText(clipboarddt);
          }
        }
      }

      if (unit2.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit2.setText(clipboarddt);
          }
        }
      }

      if (unit3.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit3.setText(clipboarddt);
          }
        }
      }

      if (unit4.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit4.setText(clipboarddt);
          }
        }
      }

      if (unit5.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit5.setText(clipboarddt);
          }
        }
      }

      if (unit6.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit6.setText(clipboarddt);
          }
        }
      }

      if (unit7.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit7.setText(clipboarddt);
          }
        }
      }

      if (unit8.isFocus() == true) {
        if (iscontrol) {
          if (key == 'v') {
            clipboarddt = GetTextFromClipboard();
            unit8.setText(clipboarddt);
          }
        }
      }
    }

    configuration.setString("ip1", cp1.get(Textfield.class, "ip1").getText());
    configuration.setString("ip2", cp1.get(Textfield.class, "ip2").getText());
    configuration.setString("ip3", cp1.get(Textfield.class, "ip3").getText());
    configuration.setString("ip4", cp1.get(Textfield.class, "ip4").getText());

    configuration.setString("unit1", cp1.get(Textfield.class, "inputs_1").getText());
    configuration.setString("unit2", cp1.get(Textfield.class, "inputs_2").getText());
    configuration.setString("unit3", cp1.get(Textfield.class, "inputs_3").getText());
    configuration.setString("unit4", cp1.get(Textfield.class, "inputs_4").getText());
    configuration.setString("unit5", cp1.get(Textfield.class, "inputs_5").getText());
    configuration.setString("unit6", cp1.get(Textfield.class, "inputs_6").getText());
    configuration.setString("unit7", cp1.get(Textfield.class, "inputs_7").getText());
    configuration.setString("unit8", cp1.get(Textfield.class, "inputs_8").getText());
  }

  for (int i = 1; i <= 4; i++) {
    String key = "ip" + i;
    String ipValue = getConfigurationString(key);
    if (ipValue.length() > 3 || int(ipValue) < 0 || int(ipValue) > 255) {
      configuration.setString(key, "0");
    }
  }

  for (int i = 1; i <= 8; i++) {
    String key = "unit" + i;
    String unitValue = getConfigurationString(key);
    int maxLength = (i == 6) ? 3 : 7;
    if (unitValue.length() > maxLength) {
      configuration.setString(key, "");
    }
  }

  m.setMultiplier(-float(getScaleString("gpbr")));
  p.setMultiplier(-float(getScaleString("gpbr")));
  n.setMultiplier(-float(getScaleString("gpct")));
  l.setMultiplier(-float(getScaleString("gpct")));

  configuration.setString("controltemp", str((1023 * float(getConfigurationString("lgmultiplier6"))) + float(getConfigurationString("lgspan6"))));
  configuration.setString("controltempmin", str((float(getConfigurationString("lgspan6")))));

  cp1.getController("savedata").setLock(!admin || statusstartrec);
  cp1.getController("unit").setLock(!admin || statusstartrec);
  cp1.getController("ratesampling").setLock(!admin || statusok || democ);
  cp1.getController("login").setLock(RightAxis || authenticationwindows);

  cp1.getController("reccontrol").setLock(startcontrol);
  cp1.getController("startcontrol").setLock(reccontrol);

  cp1.getController("connect").setLock(democ || !licensec);
  cp1.getController("disconnect").setLock(democ || ipcon || !licensec);
  cp1.getController("refresh").setLock(democ || ipcon || !licensec || statusok);
  cp1.getController("up").setLock(democ || ipcon || !licensec || statusok);
  cp1.getController("down").setLock(democ || ipcon || !licensec || statusok);
  cp1.getController("ipenable").setLock(!admin || statusok || !licensec);
  ip1.setLock(!admin || statusok || !licensec);
  ip2.setLock(!admin || statusok || !licensec);
  ip3.setLock(!admin || statusok || !licensec);
  ip4.setLock(!admin || statusok || !licensec);

  cp1.getController("lgvisible1").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible2").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible3").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible4").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible5").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible6").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible7").setLock(!admin || !RightAxis);
  cp1.getController("lgvisible8").setLock(!admin || !RightAxis);

  unit1.setLock(!admin || !RightAxis);
  unit2.setLock(!admin || !RightAxis);
  unit3.setLock(!admin || !RightAxis);
  unit4.setLock(!admin || !RightAxis);
  unit5.setLock(!admin || !RightAxis);
  unit6.setLock(!admin || !RightAxis);
  unit7.setLock(!admin || !RightAxis);
  unit8.setLock(!admin || !RightAxis);

  if (ipcon) {
    cp1.getController("ip1").show();
    cp1.getController("ip2").show();
    cp1.getController("ip3").show();
    cp1.getController("ip4").show();
  } else {
    cp1.getController("ip1").hide();
    cp1.getController("ip2").hide();
    cp1.getController("ip3").hide();
    cp1.getController("ip4").hide();
  }

  if (RightAxis) {
    username = "SUPER_USER";
    cp1.getController("login").setLock(true);
    cp1.getController("eeprom").show();
    cp1.getController("savehex").show();

    if (statusok == false & !democ) {
      if (hexflash) {
        cp1.getController("savehex").setValue(1);
        cp1.getController("eeprom").setLock(true);
        cp1.getController("eeprom").setValue(0);
      } else {
        cp1.getController("savehex").setValue(0);
        cp1.getController("eeprom").setLock(false);
      }

      if (eepromst) {
        cp1.getController("eeprom").setValue(1);
        cp1.getController("savehex").setLock(true);
        cp1.getController("savehex").setValue(0);
        cp1.getController("inputs_1").setColorBackground(#FAC7C7);
        cp1.getController("inputs_2").setColorBackground(#FAC7C7);
        cp1.getController("inputs_3").setColorBackground(#FAC7C7);
        cp1.getController("inputs_4").setColorBackground(#FAC7C7);
        cp1.getController("inputs_5").setColorBackground(#FAC7C7);
        cp1.getController("inputs_6").setColorBackground(#FAC7C7);
      } else {
        cp1.getController("savehex").setLock(false);
        cp1.getController("eeprom").setValue(0);
        cp1.getController("inputs_1").setColorBackground(0xffffffff);
        cp1.getController("inputs_2").setColorBackground(0xffffffff);
        cp1.getController("inputs_3").setColorBackground(0xffffffff);
        cp1.getController("inputs_4").setColorBackground(0xffffffff);
        cp1.getController("inputs_5").setColorBackground(0xffffffff);
        cp1.getController("inputs_6").setColorBackground(0xffffffff);
      }
    } else {
      cp1.getController("savehex").setLock(statusok);
      cp1.getController("eeprom").setLock(statusok);
    }
  } else {
    cp1.getController("eeprom").hide();
    cp1.getController("savehex").hide();
    cp1.getController("savehex").setLock(true);
    cp1.getController("eeprom").setLock(true);
  }
}

void mousePressed() {
  if (activeTab.equals("tab_main")) {
    if (cp1 != null && admin) {
      for (int b = 0; b <= isizer; b++) {
        if (cp1.isMouseOver(cp1.getController("inputs_" + b))) {
          irtyr = b;
          break;
        }
      }
    }

    if (lastTime + wait > millis()) {
      checkMousePositionAndExecute(908, 954, 230, 276, this::Manual);
      checkMousePositionAndExecute(238, 823, 76, 246, () -> monitor(Viewgraph));
      checkMousePositionAndExecute(238, 823, 363, 533, this::normalizeview);
      checkMousePositionAndExecute(24, 128, 167, 271, this::snapshotcallmain);
    } else {
      lastTime = millis();
    }
  }
  // Handling mouse pressed event
  if (activeTab.equals("tab_display")) {
    selectGraphBasedOnMousePosition();
    if (lastTimedatadd + waitdatadd > millis()) {
      handleMouseInPlotArea();
      handleMouseInSnapshotArea();
    } else {
      lastTimedatadd = millis();
    }
  }
}

void mouseWheel(MouseEvent event) {

  if (isWindowFocused0 == true) {

    if (activeTab.equals("tab_main")) {
      if (isWithinBounds(mouseX, mouseY, 238, 823, 76, 246)) {
        adjustGraphs(event, "uppergraphb", "lowergraphb", "gpbr");
      } else if (isWithinBounds(mouseX, mouseY, 238, 823, 363, 533)) {
        adjustGraphs(event, "uppergraph", "lowergraph", "gpct");
      }
    }

    // Handling mouse wheel event
    else if (activeTab.equals("tab_display")) {

      try {

        if (windatabase != null) {
          if (folderPath.equals(topSketchPath + "/data/" + username)) {
            if ((mouseX > 728 & mouseX < 1165) & (mouseY > 40 & mouseY < 226)) {
              float e = event.getCount();
              int verif = selectedItemIndex;

              if (e < 0) {
                selectedItemIndex = max(0, selectedItemIndex - 1);
                updateScrollableListSelection();
                selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
                if (selectedItemIndex != verif) {
                  opendt();
                }
              } else if (e > 0) {
                selectedItemIndex = max(0, selectedItemIndex + 1);
                updateScrollableListSelection();
                selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
                if (selectedItemIndex != verif) {
                  opendt();
                }
              }
            }
          }
        }
      }
      catch (Exception e) {
        e.printStackTrace();
      }

      if ((mouseX > 20 & mouseX < 702) & (mouseY > 35 & mouseY < 400)) {
        float e = event.getCount();

        if (e < 0) {
          float[] y = plot1.getYLim();
          plot1.zoom(1.1);
          if (y[1]/y[0] == 0.9999999) {
            plot1.setXLim(0, sizefl);
            plot1.setYLim(yreal);
          }
        }

        if (e > 0) {
          float[] y = plot1.getYLim();
          float[] x = plot1.getXLim();
          plot1.zoom(0.9);
          if (y[1]/y[0] == -1.0 || x[1]/x[0] == -1.0) {
            plot1.setXLim(0, sizefl);
            plot1.setYLim(yreal);
          }
        }
      }
    }
  }
}

void keyReleased() {
  if (key == CODED && keyCode == ALT) {
    iscontrol = false;
  }
}

void keyPressed() {

  handleNumericKeySelection();

  if (activeTab.equals("tab_main")) {
    handleEscapeKey();
    handleEnterKey();
    handleCodedKey();
    handleAdminTabKey();
  }

  if (key == CODED) {
    if (keyCode == ALT) {
      iscontrol = true;
    }

    if (keyCode == java.awt.event.KeyEvent.VK_F1) {
      Manual();
    }

    if (int(getConfigurationString("fnkey")) == 1) {

      if (keyCode == java.awt.event.KeyEvent.VK_F2) {
        if (tab_display.isActive()) {
          exportdatacsv();
        } else {
          if (statusok) {
            if (statusstartrec) {
              startrecb.setValue(0);
            } else {
              startrecb.setValue(1);
            }
          }
        }
      }

      if (keyCode == UP) {
        if (tab_display.isActive()) {
          handleZoom(1.1);
        } else {
          if (float(getConfigurationString("savedata")) <= 1000 && admin && !statusstartrec) {
            cp1.getController("savedata").setValue(float(getConfigurationString("savedata")) + 1);
          }
        }
      }

      if (keyCode == DOWN) {
        if (tab_display.isActive()) {
          handleZoom(0.9);
        } else {
          if (float(getConfigurationString("savedata")) >= 0.1 && admin && !statusstartrec) {
            cp1.getController("savedata").setValue(float(getConfigurationString("savedata")) - 0.01);
          }
        }
      }

      if (keyCode == RIGHT) {
        if (tab_display.isActive()) {
          plot1.moveHorizontalAxesLim(2);
        } else {
          if (int(getConfigurationString("ratesampling")) <= 1820 && admin && !statusconnect) {
            cp1.getController("ratesampling").setValue(int(getConfigurationString("ratesampling")) + 1);
          }
        }
      }

      if (keyCode == LEFT) {
        if (tab_display.isActive()) {
          plot1.moveHorizontalAxesLim(-2);
        } else {
          if (int(getConfigurationString("ratesampling")) >= 10 && admin && !statusconnect) {
            cp1.getController("ratesampling").setValue(int(getConfigurationString("ratesampling")) - 1);
          }
        }
      }

      if (keyCode == java.awt.event.KeyEvent.VK_F12) {
        if (windowdisplayshow == true) {
          if (tab_main.isActive()) {
            tab_display.bringToFront();
          } else {
            tab_main.bringToFront();
          }
        }
      }

      if (keyCode ==  java.awt.event.KeyEvent.VK_PAGE_UP) {
        if (tab_display.isActive() && windatabase != null) {
          int verif = selectedItemIndex;

          try {
            selectedItemIndex = max(0, selectedItemIndex - 1);
            updateScrollableListSelection();
            selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
            if (selectedItemIndex != verif) {
              opendt();
            }
          }
          catch (Exception e) {
            e.printStackTrace();
          }
        } else {
          up();
        }
      }

      if (keyCode ==  java.awt.event.KeyEvent.VK_PAGE_DOWN) {
        if (tab_display.isActive() && windatabase != null) {
          int verif = selectedItemIndex;

          try {
            selectedItemIndex = max(0, selectedItemIndex + 1);
            updateScrollableListSelection();
            selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
            if (selectedItemIndex != verif) {
              opendt();
            }
          }
          catch (Exception e) {
            e.printStackTrace();
          }
        } else {
          down();
        }
      }

      if (keyCode == java.awt.event.KeyEvent.VK_HOME) {
        if (windowdisplayshow == true) {
          if (tab_main.isActive()) {
            snapshotcallmain();
          } else {
            snapshotcalldatadisplay();
          }
        }
      }
    }
  }

  // Handling key pressed event
  if (activeTab.equals("tab_display")) {
    if (key == ESC) {
      key = 0;
    }

    if (keyPressed && key == ' ') {
      plot1.setXLim(xLimAutoscale);
      plot1.setYLim(yLimAutoscale);
    }
  }
}

private void checkMousePositionAndExecute(int x1, int x2, int y1, int y2, Runnable action) {
  if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
    action.run();
  }
}

void normalizeview() {
  if (!RightAxis) {
    normalizesd();
  }
}

public void Manual() {
  launch(topSketchPath + localmanual);
}

boolean isWithinBounds(int x, int y, int xMin, int xMax, int yMin, int yMax) {
  return (x > xMin && x < xMax) && (y > yMin && y < yMax);
}

void adjustGraphs(MouseEvent event, String upperGraph, String lowerGraph, String scale) {
  float scaleValue = float(getScaleString(scale));
  if (event.getCount() < 0) {
    cp1.getController(upperGraph).setValue(float(getScaleString(upperGraph)) - scaleValue);
    cp1.getController(lowerGraph).setValue(float(getScaleString(lowerGraph)) + scaleValue);
  } else if (event.getCount() > 0) {
    cp1.getController(upperGraph).setValue(float(getScaleString(upperGraph)) + scaleValue);
    cp1.getController(lowerGraph).setValue(float(getScaleString(lowerGraph)) - scaleValue);
  }
}

void handleEscapeKey() {

  if (keyCode == ESC) {
    key = 0;

    if (int(getConfigurationString("fnkey")) == 1) {
      if (tab_main.isActive()) {
        if (!statusok) {
          if (eepromst == true || hexflash == true) {
            eepromst = false;
            hexflash = false;
          } else {
            closesec();
          }
        } else if (!statusstartrec && !startcontrol && !reccontrol) {
          disconnect();
        }
      }
    }
  }
}

void handleEnterKey() {
  if (key == ENTER) {
    connect();
  }
}

void handleCodedKey() {
  if (key == CODED) {

    if (int(getConfigurationString("fnkey")) == 1) {

      switch (keyCode) {

      case java.awt.event.KeyEvent.VK_F3:
        handleF3Key();
        break;

      case java.awt.event.KeyEvent.VK_F4:
        handleF4Key();
        break;

      case java.awt.event.KeyEvent.VK_F5:
        handleF5Key();
        break;

      case java.awt.event.KeyEvent.VK_F6:
        cp1.getController("database").setValue(1);
        break;

      case java.awt.event.KeyEvent.VK_F7:
        cp1.getController("settingssd").setValue(1);
        break;

      case java.awt.event.KeyEvent.VK_F8:
        cp1.getController("control").setValue(1);
        break;

      case java.awt.event.KeyEvent.VK_F9:
        handleF9Key();
        break;

      case java.awt.event.KeyEvent.VK_F10:
        refresh();
        break;

      case java.awt.event.KeyEvent.VK_F11:
        monitor(Viewgraph);
        break;

      case java.awt.event.KeyEvent.VK_END:
        if (int(getConfigurationString("fnkey")) == 1 && admin) {
          toggleUnitMode();
        }
        break;
      }
    }
  }
}

void handleF3Key() {
  if (statusok && !reccontrol) {
    if (startcontrol) {
      startcontrolb.setValue(0);
    } else {
      startcontrolb.setValue(1);
    }
  }
}

void handleF4Key() {
  if (statusok && !startcontrol) {
    if (reccontrol) {
      reccontrolb.setValue(0);
    } else {
      reccontrolb.setValue(1);
    }
  }
}

void handleF5Key() {
  if (!RightAxis) {
    cp1.getController("login").setValue(1);
  } else {
    if ( hexflash == false && statusok == false) {
      eeprom(true);
    }
  }
}

void toggleUnitMode() {
  if (modeunit == false) {
    cp1.getController("unit").setValue(1);
  } else {
    cp1.getController("unit").setValue(0);
  }
}

void handleF9Key() {
  if (!RightAxis) {
    normalizeview();
  } else {
    if ( eepromst == false && statusok == false) {
      savehex(true);
    }
  }
}

void handleAdminTabKey() {
  if (admin && key == TAB && RightAxis) {
    for (tempr = 1; tempr == isizer; tempr++) {
      Textfield tfTemp = (Textfield) cp1.getController("inputs_" + tempr);

      if (tfTemp.isFocus() == true) {
        irtyr = tempr;
      }
    }

    Textfield tf1 = (Textfield) cp1.getController("inputs_" + irtyr);

    if (irtyr == isizer) {
      irtyr = 1;
    } else {
      irtyr++;
    }

    Textfield tf0 = (Textfield) cp1.getController("inputs_" + irtyr);

    tf1.setFocus(false);
    tf0.setFocus(true);
  }
}

// handle gui actions
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Numberbox.class) || theEvent.isAssignableFrom(Button.class)) {
    String value = theEvent.getValue() + "";

    switch (theEvent.getName()) {
    case "lgvisible1":
    case "lgvisible2":
    case "lgvisible3":
    case "lgvisible4":
    case "lgvisible5":
    case "lgvisible6":
    case "lgvisible7":
    case "lgvisible8":
      configuration.setString(theEvent.getName(), value);
      break;
    case "savedata":
    case "ratesampling":
      configuration.setString(theEvent.getName(), value);
      break;
    case "marker":
      configuration.setString(theEvent.getName(), value);
      scalegraph.setString(theEvent.getName(), value);
      break;
    case "autoscale":
      configuration.setString(theEvent.getName(), value);
      scalegraph.setString(theEvent.getName(), value);
      break;
    case "ipenable":
      configuration.setString("ipserial", value);
      break;
    case "uppergraphb":
    case "uppergraph":
    case "lowergraphb":
    case "lowergraph":
    case "divp":
    case "gpbr":
    case "gpct":
      scalegraph.setString(theEvent.getName(), value);
      break;
    default:
      // Optionally handle unexpected event names
      break;
    }
  }
  setChartSettings();
}

//Exporting data to CSV
void exportdatacsv() {
  PrintWriter output = createWriter(topSketchPath + "/exported/" + cutStringUntil(namespec, ".sdpl") + ".csv");
  output.println(join((linesdata), "\n"));
  output.close();

  // Logging the export action
  logEvent(" - Analysis data exported to .CSV extension // " + cutStringUntil(namespec, ".sdpl") + ".csv" );
}

// Converting sample to time
float[] sampleTotime(float[] sample) {
  float[] time = new float[sample.length];
  for (int i = 0; i < sample.length; i++) {
    float x = timeshseldat/float(sizefl);
    time[i] = sample[i] * x;
  }

  return time;
}
// Cutting string until the delimiter
String cutStringUntil(String input, String delimiter) {
  int index = input.indexOf(delimiter);
  if (index != -1) {
    return input.substring(0, index); // Returns the string until before the delimiter
  } else {
    return input; // Returns the original string if the delimiter is not found
  }
}

void handleMouseInPlotArea() {
  if (isMouseInBounds(20, 702, 35, 400)) {
    plot1.setXLim(xLimAutoscale);
    plot1.setYLim(yLimAutoscale);
  }
}

void handleMouseInSnapshotArea() {
  if (isMouseInBounds(728, 1165, 40, 178)) {
    snapshotcalldatadisplay();
  }
}

void selectGraphBasedOnMousePosition() {
  if (isMouseInBounds(20, 234, 420, 567)) {
    selectgh = 2;
  } else if (isMouseInBounds(254, 468, 420, 567)) {
    selectgh = 3;
  } else if (isMouseInBounds(488, 702, 420, 567)) {
    selectgh = 4;
  } else if (isMouseInBounds(722, 936, 420, 567)) {
    selectgh = 5;
  } else if (isMouseInBounds(956, 1170, 420, 567)) {
    selectgh = 6;
  } else if (isMouseInBounds(722, 936, 220, 367)) {
    selectgh = 7;
  } else if (isMouseInBounds(956, 1170, 220, 367)) {
    selectgh = (selectgh == 9) ? 8 : 9;
  }
}

boolean isMouseInBounds(int xMin, int xMax, int yMin, int yMax) {
  return mouseX > xMin && mouseX < xMax && mouseY > yMin && mouseY < yMax;
}

// Handling numeric key selection
void handleNumericKeySelection() {

  if (iscontrol) {

    if (activeTab.equals("tab_display")) {
      if (key >= '1' && key <= '8') {
        selectgh = Character.getNumericValue(key) + 1;
      }
    }

    if (tab_main.isActive() && admin && !statusconnect) {
      if (key == '0') {
        if (int(getConfigurationString("ipserial")) == 0) {
          cp1.getController("ipenable").setValue(1);
        } else {
          cp1.getController("ipenable").setValue(0);
        }
      }
    }

    if (tab_main.isActive() && admin && RightAxis) {
      if (key >= '1' && key <= '8') {
        if (int(getConfigurationString("lgvisible" + key)) == 0) {
          cp1.getController("lgvisible" + key ).setValue(1);
        } else {
          cp1.getController("lgvisible" + key ).setValue(0);
        }
      }
    }
  }
}

// Handling zoom functionality
void handleZoom(float zoomFactor) {
  float[] y = plot1.getYLim();
  float[] x = plot1.getXLim();
  plot1.zoom(zoomFactor);
  plot1.setXLim(0, sizefl);

  if (isYOrXLimInvalid(y, x)) {
    plot1.setYLim(yreal);
  }
}

// Checking if Y or X limits are invalid
private boolean isYOrXLimInvalid(float[] y, float[] x) {
  return y[1] / y[0] == 0.9999999 || y[1] / y[0] == -1.0 || x[1] / x[0] == -1.0;
}

// Handling snapshot call
void snapshotcalldatadisplay() {
  datamomentsnap = "SDPlotterDB_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + "_" + username + ".png";
  saveFrame(topSketchPath + "/snapshot/" + username + "/" + datamomentsnap);

  if (int(getConfigurationString("ativdir")) == 1) {
    dirResources = topSketchPath + "/snapshot/" + username + "/";
    loadImageIntoDB(datamomentsnap, "Blob");
  }

  // Logging the snapshot action
  logEvent(" - Generated snapshot. // " + datamomentsnap);

  othersmain();
}

public String[] decryptFile(String pointer, String keys) throws Exception {
  String encryptedTextBase64 = join(loadStrings(pointer), "\n");
  byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

  SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
  Cipher cipher = Cipher.getInstance("AES");
  cipher.init(Cipher.DECRYPT_MODE, secretKey);

  byte[] decryptedText = cipher.doFinal(encryptedText);
  return split(new String(decryptedText), "\n");
}

public   void updateScrollableListSelection() {
  initialBodyList.setValue(selectedItemIndex);
}

public void opendt() {
  if (pointer != null) {
    if (folderPath.equals(topSketchPath + "/data/" + username)) {
      loadData(pointer, keys);
    } else if (folderPath.equals(topSketchPath + "/method/" + username)) {
      loadMethod(pointer, keys);
    } else if (folderPath.equals(topSketchPath + "/snapshot/" + username)) {
      launch(pointer);
    }
  }
}

public void loadData(String pointer, String keys) {
  try {
    linesdata = decryptFile(pointer, keys);
    if (linesdata != null) {
      parseData(linesdata);
      refreshdatadisplay = true;

      sizefl = numLinesdatadisplay - 9;
      Timer1final();

      // Resetting graph data displays
      graph2datadisplay = new GPointsArray();
      graph3datadisplay = new GPointsArray();
      graph4datadisplay = new GPointsArray();
      graph5datadisplay = new GPointsArray();
      graph6datadisplay = new GPointsArray();
      graph7datadisplay = new GPointsArray();
      graph8datadisplay = new GPointsArray();
      graph9datadisplay = new GPointsArray();

      // Filling arrays with data from the file
      for (int i = 7; i <= numLinesdatadisplay - 2; i++) {
        String[] valuesd = linesdata[i].split(";");
        graph2datadisplay.add(i - 7, float(valuesd[7].replace(',', '.')));
        graph3datadisplay.add(i - 7, float(valuesd[8].replace(',', '.')));
        graph4datadisplay.add(i - 7, float(valuesd[9].replace(',', '.')));
        graph5datadisplay.add(i - 7, float(valuesd[10].replace(',', '.')));
        graph6datadisplay.add(i - 7, float(valuesd[11].replace(',', '.')));
        graph7datadisplay.add(i - 7, float(valuesd[12].replace(',', '.')));
        graph8datadisplay.add(i - 7, float(valuesd[13].replace(',', '.')));
        graph9datadisplay.add(i - 7, float(valuesd[14].replace(',', '.')));
      }

      if (tab_main.isActive()) {
        tab_display.show().bringToFront();
        windowdisplayshow = true;
      }
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

public void loadMethod(String pointer, String keys) {
  if (!startcontrol && !reccontrol) {
    status_met = "  Loaded method";
    numberfile = namespec;
    datainfo = " - " + numberfile;

    try {
      myStringsmet = decryptFile(pointer, keys);
      refreshmethod = true;
      resetTimers();
      Timer2final();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}

public void resetTimers() {
  millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;
}

void parseData(String[] linesdata) {
  numLinesdatadisplay = linesdata.length;
  titledatadisplay = linesdata[0];
  userdatadisplay = linesdata[1];
  machinecodedatadisplay = linesdata[2];
  serialdatadisplay = linesdata[3];
  settingsdatadisplay = linesdata[4].split(";");
  probes = linesdata[5].split(";");
  units = linesdata[6].split(";");
  Datestimesstart = linesdata[7].split(";");
  timesdatadisplay = linesdata[linesdata.length - 1].split(";");
}

public void deleteData() {
  if (pointer != null) {
    File file = new File(pointer);
    file.delete();
    tablesmain();
    if (tab_display.isActive()) {
      tab_main.bringToFront();
    }
    tab_display.hide();
    windowdisplayshow = false;
  }
}

public void logEvent(String message) {
  oldlogs += year() + "/" + month() + "/" + day() + "_" + hour() + ":" + minute() + ":" + second() + message + " \r\n/\r\n";
}

public void logDeletion() {
  //log
  logEvent(" - Deleted file. // " + namespec);
}

GPointsArray downsamplePoints(GPointsArray data, int maxPoints) {
  GPointsArray reducedData = new GPointsArray();

  int totalPoints = data.getNPoints();
  if (totalPoints <= maxPoints) {
    return data;
  }

  int step = totalPoints / maxPoints;

  for (int i = 0; i < totalPoints; i += step) {
    reducedData.add(data.getX(i), data.getY(i));
  }

  return reducedData;
}


void Drawdisplay() {

  // Drawing the plots
  plot1.beginDraw();
  plot1.drawBox();
  plot1.drawTitle();
  plot1.drawGridLines(GPlot.BOTH);
  plot1.drawLabels();
  plot1.drawLines();
  plot1.drawYAxis();
  plot1.endDraw();

  plot11.beginDraw();
  plot11.drawXAxis();
  plot11.endDraw();

  plot2.beginDraw();
  plot2.drawBox();
  plot2.drawYAxis();
  plot2.drawXAxis();
  plot2.drawTitle();
  plot2.drawLabels();
  plot2.drawLines();
  plot2.endDraw();

  plot3.beginDraw();
  plot3.drawBox();
  plot3.drawYAxis();
  plot3.drawXAxis();
  plot3.drawTitle();
  plot3.drawLabels();
  plot3.drawLines();
  plot3.endDraw();

  plot4.beginDraw();
  plot4.drawBox();
  plot4.drawYAxis();
  plot4.drawXAxis();
  plot4.drawTitle();
  plot4.drawLabels();
  plot4.drawLines();
  plot4.endDraw();

  plot5.beginDraw();
  plot5.drawBox();
  plot5.drawYAxis();
  plot5.drawXAxis();
  plot5.drawTitle();
  plot5.drawLabels();
  plot5.drawLines();
  plot5.endDraw();

  plot6.beginDraw();
  plot6.drawBox();
  plot6.drawYAxis();
  plot6.drawXAxis();
  plot6.drawTitle();
  plot6.drawLabels();
  plot6.drawLines();
  plot6.endDraw();

  plot7.beginDraw();
  plot7.drawBox();
  plot7.drawYAxis();
  plot7.drawXAxis();
  plot7.drawTitle();
  plot7.drawLabels();
  plot7.drawLines();
  plot7.endDraw();

  plot8.beginDraw();
  plot8.drawBox();
  plot8.drawTitle();
  plot8.drawLabels();
  plot8.drawYAxis();
  plot8.drawXAxis();
  plot8.drawLines();
  plot8.endDraw();
}

void launchdatadisplay() {

  if (refreshdatadisplay == true) {

    // Setting up plot positions, dimensions, titles, labels, and enabling interactivity
    plot1.setPos(17, 35);
    plot1.setDim(570, 258);
    plot1.setTitleText("Sensor");
    plot1.getYAxis().setAxisLabelText("Unit");
    plot1.getXAxis().setAxisLabelText("Time");
    plot1.activatePointLabels();
    plot1.activatePanning();

    plot11.setPos(plot1.getPos());
    plot11.setDim(plot1.getDim());

    plot2.setPos(13, 417);
    plot2.setDim(130, 50);
    plot2.setLineColor(graphColors[0]);
    plot2.getYAxis().setDrawTickLabels(false);
    plot2.getXAxis().setDrawTickLabels(false);

    plot3.setPos(247, 417);
    plot3.setDim(130, 50);
    plot3.setLineColor(graphColors[1]);
    plot3.getYAxis().setDrawTickLabels(false);
    plot3.getXAxis().setDrawTickLabels(false);

    plot4.setPos(481, 417);
    plot4.setDim(130, 50);
    plot4.setLineColor(graphColors[2]);
    plot4.getYAxis().setDrawTickLabels(false);
    plot4.getXAxis().setDrawTickLabels(false);

    plot5.setPos(715, 417);
    plot5.setDim(130, 50);
    plot5.setLineColor(graphColors[3]);
    plot5.getYAxis().setDrawTickLabels(false);
    plot5.getXAxis().setDrawTickLabels(false);

    plot6.setPos(949, 417);
    plot6.setDim(130, 50);
    plot6.setLineColor(graphColors[4]);
    plot6.getYAxis().setDrawTickLabels(false);
    plot6.getXAxis().setDrawTickLabels(false);

    plot7.setPos(715, 250);
    plot7.setDim(130, 50);
    plot7.setLineColor(graphColors[5]);
    plot7.getYAxis().setDrawTickLabels(false);
    plot7.getXAxis().setDrawTickLabels(false);

    plot8.setPos(949, 250);
    plot8.setDim(130, 50);
    plot8.setLineColor(graphColors[6]);
    plot8.getYAxis().setDrawTickLabels(false);
    plot8.getXAxis().setDrawTickLabels(false);

    // Setting X and Y limits for plots
    plot1.setXLim(0, sizefl);
    plot2.setXLim(0, sizefl);
    plot3.setXLim(0, sizefl);
    plot4.setXLim(0, sizefl);
    plot5.setXLim(0, sizefl);
    plot6.setXLim(0, sizefl);
    plot7.setXLim(0, sizefl);
    plot8.setXLim(0, sizefl);

    plot11.setXLim(0, timeshseldat);
    plot11.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    // Setting titles and labels for plots
    plot2.setTitleText(probes[7]);
    plot2.getYAxis().setAxisLabelText(units[7]);
    plot2.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot3.setTitleText(probes[8]);
    plot3.getYAxis().setAxisLabelText(units[8]);
    plot3.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot4.setTitleText(probes[9]);
    plot4.getYAxis().setAxisLabelText(units[9]);
    plot4.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot5.setTitleText(probes[10]);
    plot5.getYAxis().setAxisLabelText(units[10]);
    plot5.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot6.setTitleText(probes[11]);
    plot6.getYAxis().setAxisLabelText(units[11]);
    plot6.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot7.setTitleText(probes[12]);
    plot7.getYAxis().setAxisLabelText(units[12]);
    plot7.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    plot8.setTitleText(probes[13]);
    plot8.getYAxis().setAxisLabelText(units[13]);
    plot8.getXAxis().setAxisLabelText("Time, " + timeshdat2);

    // Resetting plot points
    plot1.setPoints(new GPointsArray());
    plot2.setPoints(new GPointsArray());
    plot3.setPoints(new GPointsArray());
    plot4.setPoints(new GPointsArray());
    plot5.setPoints(new GPointsArray());
    plot6.setPoints(new GPointsArray());
    plot7.setPoints(new GPointsArray());
    plot8.setPoints(new GPointsArray());

    selectgh = 1;

    refreshdatadisplay = false;
  }
}
