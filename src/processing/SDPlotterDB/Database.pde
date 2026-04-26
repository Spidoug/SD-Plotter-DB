public class PWindowd extends PApplet {
  int xLct, yLct;

  PWindowd(int xLct, int yLct) {
    super();
    this.xLct = xLct;
    this.yLct = yLct;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  int waitdatadt = 200, lastTimedatadt = -waitdatadt;

  boolean isWindowFocused3 = true;

  void settings() {
    smooth(2);
    size(565, 354);
  }

  void setup() {

    surface.setTitle("Database");
    surface.setLocation(xLct + 5, yLct + 52);

    final Frame frame = (Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
    frame.addWindowFocusListener(new WindowFocusListener() {
      @Override
        public void windowGainedFocus(WindowEvent e) {
        isWindowFocused3 = true;
      }

      @Override
        public void windowLostFocus(WindowEvent e) {
        isWindowFocused3 = false;
      }
    }
    );

    cp5 = new ControlP5(this);

    cp5.setAutoDraw(false);

    PImage[] Tables = loadImages("/lib/src/tables_a.png", "/lib/src/tables_b.png", "/lib/src/tables_c.png");
    PImage[] Method = loadImages("/lib/src/methods_a.png", "/lib/src/methods_b.png", "/lib/src/methods_c.png");
    PImage[] Logs = loadImages("/lib/src/logs_a.png", "/lib/src/logs_b.png", "/lib/src/logs_c.png");
    PImage[] Others = loadImages("/lib/src/others_a.png", "/lib/src/others_b.png", "/lib/src/others_c.png");
    PImage[] Startdb = loadImages("/lib/src/startdb_a.png", "/lib/src/startdb_b.png", "/lib/src/startdb_c.png");
    PImage[] Export = loadImages("/lib/src/export_a.png", "/lib/src/export_b.png", "/lib/src/export_c.png");
    PImage[] Open = loadImages("/lib/src/open_a.png", "/lib/src/open_b.png", "/lib/src/open_c.png");
    PImage[] Delete = loadImages("/lib/src/delete_a.png", "/lib/src/delete_b.png", "/lib/src/delete_c.png");

    cp5.addTextlabel("Data")
      .setText("Data")
      .setPosition(35, 306)
      .setColor(43)
      .setFont(createFont("Georgia", 14));

    cp5.addButton("tables")
      .setPosition(435, 25)
      .setWidth(100)
      .setImages(Tables)
      .updateSize();

    cp5.addButton("methods")
      .setPosition(435, 65)
      .setWidth(100)
      .setImages(Method)
      .updateSize();

    cp5.addButton("others")
      .setPosition(435, 105)
      .setWidth(100)
      .setImages(Others)
      .updateSize();

    cp5.addButton("logs")
      .setPosition(435, 145)
      .setWidth(100)
      .setImages(Logs)
      .updateSize();

    opendtbt = cp5.addButton("opendt")
      .setPosition(435, 204)
      .setWidth(100)
      .setImages(Open)
      .updateSize()
      .setLock(true);

    deletedtbt = cp5.addButton("deletedt")
      .setPosition(435, 244)
      .setWidth(100)
      .setImages(Delete)
      .updateSize()
      .setLock(true);

    cp5.addButton("startdb")
      .setPosition(107, 301)
      .setImages(Startdb)
      .updateSize();

    cp5.addButton("exportx")
      .setPosition(220, 301)
      .setImages(Export)
      .updateSize();

    directory = cp5.addTextfield("directory")
      .setPosition(362, 305)
      .setSize(170, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(40)
      .setText(getConfigurationString("directory"))
      .setColorCaptionLabel(int(getConfigurationString("graph3")))
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0)
      .setColorForeground(0xffffffff);

    if (admin && getConfigurationString("ativdir").equals("0") && !statusconnect && !democ && RightAxis) {
      directory.setFocus(true);
    }

    myTextarea = cp5.addTextarea("txt")
      .setPosition(30, 33)
      .setSize(364, 231)
      .setFont(createFont("arial", 11))
      .setLineHeight(20)
      .setColorBackground(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)))
      .setColor(int(getConfigurationString("graph2")))
      .setColorForeground(#F599A1)
      .setColorActive(#FF4655)
      .scroll(1);

    initialBodyList = cp5.addScrollableList("recorddata")
      .setPosition(30, 33)
      .setSize(364, 231)
      .setBarHeight(30)
      .setItemHeight(20)
      .setFont(createFont("arial", 10))
      .setColorBackground(color(255))
      .setColorForeground(#F599A1)
      .setColorActive(#FF4655)
      .setColorValueLabel(color(50))
      .setColorCaptionLabel(color(100))
      .setType(ScrollableList.LIST);

    if ( deletemt == true ) {

      initialBodyList.hide();
    } else {

      tablesmain();
      updateScrollableListSelection();
    }
  }

  void draw() {

    surface.setAlwaysOnTop(ontopdat); // Keep window always on top
    surface.setTitle("Database" +  window4);
    background(int(getConfigurationString("graph6")));

    fill(120);
    noStroke();
    rect(0, 0, width, 9);
    rect(0, height - 9, width, 9);

    Drawcontour_outer_Database(12, 13, 400, 270);

    fill(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 235)));
    stroke(40);
    rect(20, 20, 384, 256, 20);
    noFill();
    noStroke();

    Drawcontour_outer_Database(422, 13, 130, 270);
    Drawcontour_inner_Database(430, 19, 113, 160);
    Drawcontour_inner_Database(430, 197, 113, 80);

    Drawcontour_outer_Database(12, 290, 541, 50);
    Drawcontour_inner_Database(95, 295, 240, 40);
    Drawcontour_inner_Database(346, 295, 199, 40);

    if ((mouseX > 13 & mouseX < 413) & (mouseY > 14 & mouseY< 283)) {

      window4 = " - Browser";
    } else {

      window4 = "";
    }

    if ((mouseX > 430 & mouseX < 544) & (mouseY > 20 & mouseY< 181)) {

      window4 = " - Choose file type";
    }

    if ((mouseX > 430 & mouseX < 544) & (mouseY > 198 & mouseY< 277)) {

      window4 = " - Handle files";
    }

    if ((mouseX > 13 & mouseX < 552) & (mouseY > 290 & mouseY< 340)) {

      window4 = " - SQL database manager";
    }

    if (windatabase != null) {

      if (cp5 != null) {
        myTextarea.setText(oldlogs).setColorBackground(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255))).setColor(int(getConfigurationString("graph2")));
        if (!deletemt) {
          initialBodyList.setOpen(true);
        }

        cp5.getController("opendt").setLock(openmt);
        cp5.getController("deletedt").setLock(deletemt);

        if (!statusconnect & RightAxis) {
          if (int(getConfigurationString("ativdir")) == 1) {
            cp5.getController("directory").setLock(true);
            cp5.getController("startdb").setLock(true);
            cp5.getController("startdb").setValue(1);
            cp5.getController("exportx").setLock(!admin);
          }

          if (int(getConfigurationString("ativdir")) == 0) {
            if (directory.isFocus() == true) {
              if (iscontrol) {
                if (key == 'v') {
                  clipboarddt = GetTextFromClipboard();
                  directory.setText(clipboarddt);
                }
              }
            }

            configuration.setString("directory", cp5.get(Textfield.class, "directory").getText());
            cp5.getController("directory").setLock(!admin);
            cp5.getController("startdb").setLock(!admin);
            cp5.getController("exportx").setLock(true);
          }
        } else {
          if (int(getConfigurationString("ativdir")) == 1) {
            directory.setText(getConfigurationString("directory") + "/database");
            cp5.getController("startdb").setValue(1);
          }
          cp5.getController("directory").setLock(true);
          cp5.getController("startdb").setLock(true);
          cp5.getController("exportx").setLock(true);
        }
      }

      if (isWindowFocused3 == true) {
        ontopdat = false;
      }

      cp5.draw();
    }

    if (modevisible3 == 1) {
      surface.setVisible(!login);
      modevisible3 = 0;
    }
  }

  void logs() {

    folderPath = null;
    myTextarea.show();
    initialBodyList.hide();
    openmt = true;
    deletemt = true;
  }

  void deletedt() {
    if (folderPath.equals(topSketchPath + "/data/" + username)) {
      deleteData();
    } else if (folderPath.equals(topSketchPath + "/method/" + username)) {
      deleteMethod();
    } else if (folderPath.equals(topSketchPath + "/snapshot/" + username)) {
      deleteSnapshot();
    }

    logDeletion();
    updateScrollableListSelection();
  }

  void deleteMethod() {
    if (!startcontrol && !reccontrol) {
      if (namespec.equals(numberfile)) {
        stopMethod();
      }

      if (pointer != null) {
        File file = new File(pointer);
        file.delete();
      }
      methodsmain();
    }
  }

  void stopMethod() {
    status_met = "           Stop";
    millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;
    myStringsmet = null;
    refreshmethod = true;
    numberfile = "";
    datainfo = "";
  }

  void deleteSnapshot() {
    if (pointer != null) {
      File file = new File(pointer);
      file.delete();
      othersmain();
    }
  }

  public void tables() {
    folderPath =  topSketchPath + "/data/" + username;
    tablesmain();
    openmt = false;
    deletemt = false;
    Userinfo = "";
    selectedItemIndex = max(0, selectedItemIndex);
    updateScrollableListSelection();
  }

  public void methods() {
    folderPath =  topSketchPath + "/method/" + username;
    methodsmain();
    openmt = false;
    deletemt = false;
    Userinfo = "";
    selectedItemIndex = max(0, selectedItemIndex);
    updateScrollableListSelection();
  }

  public void others() {

    folderPath =  topSketchPath + "/snapshot/" + username;
    othersmain();
    openmt = false;
    deletemt = false;
    selectedItemIndex = max(0, selectedItemIndex);
    updateScrollableListSelection();
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isAssignableFrom(ScrollableList.class)) {
      handleScrollableListSelection(theEvent);
    }
  }

  void handleScrollableListSelection(ControlEvent theEvent) {
    String basePath = getBasePath();
    if (basePath != null) {
      pointer = basePath + "/" + fileNames[int(theEvent.getValue())];
      namespec = fileNames[int(theEvent.getValue())];
    }
  }

  String getBasePath() {
    if (folderPath.equals(topSketchPath + "/data/" + username)) {
      return folderPath;
    } else if (folderPath.equals(topSketchPath + "/method/" + username)) {
      return folderPath;
    } else if (folderPath.equals(topSketchPath + "/snapshot/" + username)) {
      return folderPath;
    }
    return null;
  }

  void mousePressed() {
    if (lastTimedatadt + waitdatadt > millis()) {

      if ((mouseX > 13 & mouseX < 413) & (mouseY > 14 & mouseY< 283)) {
        selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
        opendt();
      }

      if ((mouseX > 362 & mouseX < 532) & (mouseY > 305 & mouseY < 325)) {
        if (!statusconnect & RightAxis) {
          if (int(getConfigurationString("ativdir")) == 0 ) {
            if (directory.isFocus() == true) {
              clipboarddt = GetTextFromClipboard ();
              directory.setText(clipboarddt);
            }
          }
        }
      }
    } else {
      lastTimedatadt = millis();
    }
  }

  void keyReleased() {
    if (key == CODED && keyCode == ALT) {
      iscontrol = false;
    }
  }

  void keyPressed() {
    if (key == ESC) {
      key = 0;
    } else if (key == ENTER) {
      handleEnterKey();
    } else if (key == DELETE) {
      handleDeleteKey();
    } else if (key == CODED) {

      if (keyCode == ALT) {
        iscontrol = true;
      }

      if (keyCode == java.awt.event.KeyEvent.VK_F1) {
        Manual();
      }

      if (int(getConfigurationString("fnkey")) == 1) {

        if (keyCode == java.awt.event.KeyEvent.VK_F2) {
          if (admin && getConfigurationString("ativdir").equals("0") && !statusconnect && RightAxis) {
            startdb();
          }
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F3) {
          if (admin && getConfigurationString("ativdir").equals("1") && !statusconnect && RightAxis) {
            exportx();
          }
        }

        handleCodedKey();
      }
    }
  }

  void handleEnterKey() {
    if (!openmt) {
      opendtbt.setValue(1);
    }
  }

  void handleDeleteKey() {
    if (!deletemt) {
      deletedtbt.setValue(1);
    }
  }

  void handleCodedKey() {
    if (!deletemt) {
      handleArrowKeys();
    } else {
      handleScrollKeys();
    }

    switch (keyCode) {
    case java.awt.event.KeyEvent.VK_F5:
      tables();
      break;

    case java.awt.event.KeyEvent.VK_F6:
      methods();
      break;

    case java.awt.event.KeyEvent.VK_F7:
      others();
      break;

    case java.awt.event.KeyEvent.VK_F8:
      myTextarea.show();
      initialBodyList.hide();
      myTextarea.setText(oldlogs);
      openmt = true;
      deletemt = true;
      break;
    }
  }

  void handleArrowKeys() {
    if (keyCode == UP) {
      selectedItemIndex = max(0, selectedItemIndex - 1);
      updateScrollableListSelection();
    } else if (keyCode == DOWN) {
      selectedItemIndex = min(fileNames.length - 1, selectedItemIndex + 1);
      updateScrollableListSelection();
    }
  }

  void handleScrollKeys() {
    if (keyCode == UP) {
      myTextarea.scroll(0);
    } else if (keyCode == DOWN) {
      myTextarea.scroll(1);
    }
  }

  void startdb() {
    if (shouldStartDB()) {
      initializeDB();
      configureDB();
      logDBInitialization("Backup database reestablished");
      closeSecondaryProcesses();
      startServer();
      openDBbyServer("DB_SDP"); // If no exist the DB, it is created.
      createBlobsTable();       // Here is created the blobs table.
      logDBInitialization("Enabled backup database in SQL");
      closeSecondaryProcesses();
    }
  }

  boolean shouldStartDB() {
    return getConfigurationString("ativdir").equals("0") && !statusconnect && !democ;
  }

  void initializeDB() {
    configuration.setString("ativdir", "1");
    dbstart = loadStrings(getConfigurationString("directory") + "/database/DB_SDP/service.properties");
    if (dbstart != null) {
      updateDirectoryConfiguration();
      System.setProperty("derby.system.home", getConfigurationString("directory") + "/database");
    }
  }

  void configureDB() {
    updateDirectoryConfiguration();
    System.setProperty("derby.system.home", getConfigurationString("directory") + "/database");
  }

  void updateDirectoryConfiguration() {
    String local = cp5.get(Textfield.class, "directory").getText();
    configuration.setString("directory", local);
  }

  void logDBInitialization(String message) {
    logEvent(" - " + message + ". // Directory = " + getConfigurationString("directory") + "/database");
  }

  void closeSecondaryProcesses() {
    closesec();
  }

  void opendt() {
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

  void exportx() {
    if (isDirectoryActive()) {
      prepareResources();
      loadImageIntoDB("log.dat", "Blob");
    }

    exportLogData();
    logExportAction("SQL database data restored.");
    databaseview();
  }

  boolean isDirectoryActive() {
    return int(getConfigurationString("ativdir")) == 1;
  }

  void prepareResources() {
    dirResources = topSketchPath + "/lib/";
  }

  void exportLogData() {
    dataoutexp = getCurrentTimestamp();
    dataout = getConfigurationString("directory") + "/database/Exported_" + dataoutexp;
    createAndWriteLogFile();
  }

  String getCurrentTimestamp() {
    return year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + second();
  }

  void createAndWriteLogFile() {
    exp = createWriter(dataout + "/log.txt");
    exp.println("Exported the files generated by the SD Plotter DB program.");
    exp.println("The data present in this folder is part of what has been generated within the database to date: " + dataoutexp);
    exp.flush();
    exp.close();
  }

  void logExportAction(String message) {
    oldlogs += year() + "/" + month() + "/" + day() + "_" + hour() + ":" + minute() + "_" + second() + " - " + message + "\r\n";
    oldlogs += "/" + "\r\n";
  }

  // function for drawing a text box with title and contents
  void Drawcontour_outer_Database( int x, int y, int w, int h) {

    fill(int(getConfigurationString("graph5")));
    stroke(30);
    strokeWeight(0.5);
    rect(x, y, w, h, 20);
    noFill();
    noStroke();
  }

  // function for drawing a text box with title and contents
  void Drawcontour_inner_Database( int x, int y, int w, int h) {

    fill(205);
    stroke(240);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
    noFill();
    noStroke();
  }

  PApplet parent; // Reference to the parent PApplet

  void exit() {
    openmt = true;
    deletemt = true;
    delay(500);
    cp5 = null;
    windatabase = null;
    this.stop();
    this.dispose();
  }
}
