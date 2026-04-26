public class PWindowcl extends PApplet {
  int xLct, yLct;

  PWindowcl(int xLct, int yLct) {
    super();
    this.xLct = xLct;
    this.yLct = yLct;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  int waitprev = 200, lastTimeprev = -waitprev;
  int sizefl = 0; // Variable for size

  Tab tab_control, tab_preview;

  String activeTab = "tab_control";
  String[] values; // Array to hold values from data

  boolean isWindowFocused1 = true;
  boolean logScale; // Boolean for log scale toggle

  // GPlot instances for different plots
  GPlot plot1mp;
  GPlot plot2mp;
  GPlot plot3mp;
  GPlot plot4mp;

  GPlot plot11mp;
  GPlot plot12mp;
  GPlot plot13mp;
  GPlot plot14mp;

  // Arrays for storing data points
  GPointsArray temperaturep = new GPointsArray(numLinesmethod);
  GPointsArray speedp = new GPointsArray(numLinesmethod);
  GPointsArray dout1p = new GPointsArray(numLinesmethod);
  GPointsArray dout2p = new GPointsArray(numLinesmethod);

  void settings() {
    smooth(2);
    size(300, 530);
  }

  void setup() {
    surface.setTitle("Control");
    surface.setLocation(xLct + 885, yLct + 55);

    final Frame frame = (Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
    frame.addWindowFocusListener(new WindowFocusListener() {
      @Override
        public void windowGainedFocus(WindowEvent e) {
        isWindowFocused1 = true;
      }

      @Override
        public void windowLostFocus(WindowEvent e) {
        isWindowFocused1 = false;
      }
    }
    );

    PImage[] Relay1 = loadImages("/lib/src/relay1_a.png", "/lib/src/relay1_b.png", "/lib/src/null_a.png");
    PImage[] Relay2 = loadImages("/lib/src/relay2_a.png", "/lib/src/relay2_b.png", "/lib/src/null_a.png");
    PImage[] Dout1 = loadImages("/lib/src/dout1_a.png", "/lib/src/dout1_b.png", "/lib/src/null_a.png");
    PImage[] Dout2 = loadImages("/lib/src/dout2_a.png", "/lib/src/dout2_b.png", "/lib/src/null_a.png");

    cp2 = new ControlP5(this);
    cp2.setAutoDraw(false);

    cp2.getTab("default").remove();

    tab_control = cp2.addTab("Control")
      .setLabel("Control")
      .setColorBackground(color(160, 160, 160))
      .setColorForeground(color(82, 82, 82))
      .setColorActive(color(211, 211, 211));

    tab_control.getCaptionLabel().setFont(createFont("Georgia", 9, true));

    tab_preview = cp2.addTab("Preview")
      .setLabel("Preview")
      .setColorBackground(color(160, 160, 160))
      .setColorForeground(color(82, 82, 82))
      .setColorActive(color(211, 211, 211));

    tab_preview.getCaptionLabel().setFont(createFont("Georgia", 9, true));

    cp2.getTab("Control").bringToFront();

    cp2.addTextlabel("control1")
      .setText("TEMPERATURE CONTROL")
      .setPosition(64, 38)
      .setColor(250)
      .setFont(createFont("Georgia", 13))
      .moveTo(tab_control);

    cp2.addTextlabel("max_temp")
      .setText("Max. Limit")
      .setPosition(215, 72)
      .setColor(0)
      .setFont(createFont("Georgia", 10))
      .moveTo(tab_control);

    cp2.addTextlabel("min_temp")
      .setText("Min. Limit")
      .setPosition(215, 142)
      .setColor(0)
      .setFont(createFont("Georgia", 10))
      .moveTo(tab_control);

    cp2.addTextlabel("control2")
      .setText("(PROBE 6)")
      .setPosition(117, 180)
      .setColor(0)
      .setFont(createFont("Georgia", 11))
      .moveTo(tab_control);

    cp2.addTextlabel("control3")
      .setText("SPEED CONTROL")
      .setPosition(91, 220)
      .setColor(250)
      .setFont(createFont("Georgia", 13))
      .moveTo(tab_control);

    cp2.addTextlabel("torque1")
      .setText(getConfigurationString("sensor8"))
      .setPosition(222, 294)
      .setColor(0)
      .setFont(createFont("Georgia", 10))
      .moveTo(tab_control);

    cp2.addTextlabel("control5")
      .setText("(PROBE 7)")
      .setPosition(118, 365)
      .setColor(0)
      .setFont(createFont("Georgia", 11))
      .moveTo(tab_control);

    cp2.addTextlabel("control6")
      .setText("DIGITAL OUTPUT CONTROL")
      .setPosition(59, 418)
      .setColor(250)
      .setFont(createFont("Georgia", 13))
      .moveTo(tab_control);

    controltemp = cp2.addTextfield("controltemp")
      .setLabel(getConfigurationString("unit6"))
      .setPosition(218, 90)
      .setSize(50, 15)
      .setFont(createFont("Georgia", 8))
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColor(0)
      .setColorActive(0x00000000)
      .setColorCursor(0)
      .setText(str((1023 * float(getConfigurationString("lgmultiplier6"))) + float(getConfigurationString("lgspan6"))))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setLock(true)
      .moveTo(tab_control);

    controltemp.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE);
    controltemp.updateSize();

    controltempmin = cp2.addTextfield("controltempmin")
      .setLabel(getConfigurationString("unit6"))
      .setPosition(218, 159)
      .setSize(50, 15)
      .setFont(createFont("Georgia", 8))
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColor(0)
      .setColorActive(0x00000000)
      .setColorCursor(0)
      .setText(str((float(getConfigurationString("lgspan6")))))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setLock(true)
      .moveTo(tab_control);

    controltempmin.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE);
    controltempmin.updateSize();

    slider1 = cp2.addSlider("slider1")
      .setLabel(getConfigurationString("unit6"))
      .setPosition(36, 80)
      .setSize(10, 90)
      .setFont(createFont("Georgia", 9))
      .setColorActive(0xffff00ff)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorForeground(graphColors[5])
      .setColorBackground(0xffffffff)
      .setLock(true)
      .moveTo(tab_control);

    knob1 = cp2.addKnob("knob1")
      .setLabel("")
      .setPosition(99, 80)
      .setSize(100, 100)
      .setRange(float(getConfigurationString("controltempmin")), float(getConfigurationString("controltemp")))
      .setValue(float(getConfigurationString("knob1")))
      .setNumberOfTickMarks(500)
      .setTickMarkLength(3)
      .snapToTickMarks(true)
      .setFont(createFont("Georgia", 13))
      .setColorActive(graphColors[5])
      .setColorCaptionLabel(40)
      .setColorForeground(graphColors[5])
      .setColorBackground(120)
      .moveTo(tab_control);

    slider2 = cp2.addSlider("slider2")
      .setLabel(getConfigurationString("unit7"))
      .setPosition(36, 265)
      .setSize(10, 90)
      .setFont(createFont("Georgia", 9))
      .setColorActive(0x800000)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorForeground(graphColors[6])
      .setColorBackground(0xffffffff)
      .setLock(true)
      .moveTo(tab_control);

    knob2 = cp2.addKnob("knob2")
      .setLabel("")
      .setPosition(99, 265)
      .setSize(100, 100)
      .setRange(0, int(getConfigurationString("motorspeed")))
      .setValue(int(getConfigurationString("knob2")))
      .setTickMarkLength(3)
      .setNumberOfTickMarks(500)
      .snapToTickMarks(true)
      .setFont(createFont("Georgia", 13))
      .setColorActive(graphColors[6])
      .setColorCaptionLabel(40)
      .setColorForeground(graphColors[6])
      .setColorBackground(120)
      .moveTo(tab_control);

    torque = cp2.addTextfield("torque")
      .setLabel(getConfigurationString("unit8"))
      .setPosition(218, 309)
      .setSize(50, 15)
      .setFont(createFont("Georgia", 10))
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColor(0)
      .setColorActive(0x00000000)
      .setColorCursor(0)
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setLock(true)
      .moveTo(tab_control);

    torque.updateSize();

    torque.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE);
    torque.updateSize()
      .moveTo(tab_control);

    relay1 = cp2.addToggle("relay1")
      .setValue(int(getConfigurationString("relay1")))
      .setPosition(34, 450)
      .setImages(Relay1)
      .updateSize()
      .moveTo(tab_control);

    relay2 = cp2.addToggle("relay2")
      .setValue(int(getConfigurationString("relay2")))
      .setPosition(95, 450)
      .setImages(Relay2)
      .updateSize()
      .moveTo(tab_control);

    dout1 = cp2.addToggle("dout1")
      .setPosition(156, 450)
      .setValue(int(getConfigurationString("dout1")))
      .setImages(Dout1)
      .updateSize()
      .moveTo(tab_control);

    dout2 = cp2.addToggle("dout2")
      .setPosition(217, 450)
      .setValue(int(getConfigurationString("dout2")))
      .setImages(Dout2)
      .updateSize()
      .moveTo(tab_control);

    refreshmethod = true;

    // Create and configure plots
    plot1mp = new GPlot(this);
    plot2mp = new GPlot(this);
    plot3mp = new GPlot(this);
    plot4mp = new GPlot(this);

    plot11mp = new GPlot(this);
    plot12mp = new GPlot(this);
    plot13mp = new GPlot(this);
    plot14mp = new GPlot(this);

    plot1mp.setPos(15, 26);
    plot1mp.setDim(170, 40);
    plot1mp.setBoxBgColor(190);
    plot1mp.setTitleText(getConfigurationString("sensor6"));
    plot1mp.getYAxis().setAxisLabelText(getConfigurationString("unit6"));
    plot1mp.getYAxis().setDrawTickLabels(false);
    plot1mp.activatePointLabels();
    plot1mp.setLineColor(graphColors[5]);

    plot11mp.setPos(plot1mp.getPos());
    plot11mp.setDim(plot1mp.getDim());

    plot2mp.setPos(15, 143);
    plot2mp.setDim(170, 40);
    plot2mp.setBoxBgColor(190);
    plot2mp.setTitleText(getConfigurationString("sensor7"));
    plot2mp.getYAxis().setAxisLabelText(getConfigurationString("unit7"));
    plot2mp.getYAxis().setDrawTickLabels(false);
    plot2mp.activatePointLabels();
    plot2mp.setLineColor(graphColors[6]);

    plot12mp.setPos(plot2mp.getPos());
    plot12mp.setDim(plot2mp.getDim());

    plot3mp.setPos(15, 260);
    plot3mp.setDim(170, 40);
    plot3mp.setBoxBgColor(190);
    plot3mp.setTitleText("D.Out 1");
    plot3mp.getYAxis().setAxisLabelText("State");
    plot3mp.getYAxis().setDrawTickLabels(false);
    plot3mp.activatePointLabels();

    plot13mp.setPos(plot3mp.getPos());
    plot13mp.setDim(plot3mp.getDim());

    plot4mp.setPos(15, 377);
    plot4mp.setDim(170, 40);
    plot4mp.setBoxBgColor(190);
    plot4mp.setTitleText("D.Out 2");
    plot4mp.getYAxis().setAxisLabelText("State");
    plot4mp.getYAxis().setDrawTickLabels(false);
    plot4mp.activatePointLabels();

    plot14mp.setPos(plot4mp.getPos());
    plot14mp.setDim(plot4mp.getDim());
  }

  void draw() {

    surface.setAlwaysOnTop(ontopcont); // Keep window always on top
    background(int(getConfigurationString("graph6")));

    fill(120);
    noStroke();
    rect(0, 0, width, 16);
    rect(0, height - 9, width, 9);

    Drawcontour_outer2_Control(13, 25, 274, 490);

    if (wincontrol != null) {

      if (cp2 != null) {

        controltemp.setLabel(getConfigurationString("unit6")).setText(str((1023*float(getConfigurationString("lgmultiplier6")))+float(getConfigurationString("lgspan6"))));
        controltempmin.setLabel(getConfigurationString("unit6")).setText(str((float(getConfigurationString("lgspan6")))));

        knob1.setRange(float(getConfigurationString("controltempmin")), float(getConfigurationString("controltemp")));
        knob2.setRange(0, int(getConfigurationString("motorspeed")));

        if (statusok ) {
          slider1.setValue(avgrt[5]).setLabel(getConfigurationString("unit6")).setRange(float(getConfigurationString("controltempmin")), float(getConfigurationString("controltemp")));
          slider2.setValue(avgrt[6]).setRange(0, int(getConfigurationString("motorspeed")));

          torque.setText(str(avgrt[7]));

          knob1.setLock(!reccontrol & !admin);
          knob2.setLock(!reccontrol & !admin);
          dout1.setLock(!reccontrol & !admin);
          dout2.setLock(!reccontrol & !admin);

          if (startcontrol) {
            knob1.setValue(tptemp);
            knob2.setValue(mttemp);
            dout1.setValue(int(c));
            dout2.setValue(int(d));
          }

          relay1.setValue(int(a));
          relay2.setValue(int(b));
        }

        if (tab_control.isActive()) {
          activeTab = "tab_control";
        } else if (tab_preview.isActive()) {
          activeTab = "tab_preview";
        }

        if (activeTab.equals("tab_control")) {
          drawElementsFortab_control();
        } else if (activeTab.equals("tab_preview")) {
          drawElementsFortab_preview();
        }

        if (isWindowFocused1 == true) {
          ontopcont = false;
        }
        cp2.draw();
      }

      if (modevisible1 == 1) {

        surface.setVisible(!login);
        modevisible1 = 0;
      }
    }
  }

  void knob1( float theValuex1) {

    if (!startcontrol & tplock == true) {
      tptemp = theValuex1;
    }
  }

  void knob2( int theValuex1) {

    if (!startcontrol & mtlock == true) {
      mttemp = theValuex1;
    }
  }

  void slider1( float f) {
  }

  void slider2( int f) {
  }

  void controltemp( float f) {
  }

  void controltempmin( float f) {
  }

  void drawElementsFortab_control() {

    surface.setTitle("Control");

    Drawcontour_inner_Control(19, 30, 262, 5);

    Drawcontour_outer_Control(19, 60, 262, 140);
    Drawcontour_inner_Control(24, 68, 65, 125);
    Drawcontour_inner_Control(207, 68, 70, 55);
    Drawcontour_inner_Control(207, 138, 70, 55);

    Drawcontour_inner_Control(19, 212, 262, 5);

    Drawcontour_outer_Control(19, 245, 262, 140);
    Drawcontour_inner_Control(24, 253, 65, 125);
    Drawcontour_inner_Control(207, 290, 70, 55);

    Drawcontour_inner_Control(19, 399, 262, 10);

    Drawcontour_outer_Control(19, 442, 262, 65);
  }

  void drawElementsFortab_preview() {

    surface.setTitle("Method Preview");

    // Drawing contours
    Drawcontour_outer2_Preview(20, 30, 260, 478);

    fill(0);
    textSize(12);
    text("Time, " + timesh, 150, 499);
    noFill();
    noStroke();

    // Drawing lines to separate sections
    stroke(0);

    line(50, 136, 260, 136);
    line(50, 253, 260, 253);
    line(50, 370, 260, 370);
    line(50, 485, 260, 485);

    line(85, 50, 85, 495);

    stroke(#FC0505);

    if (myStringsmet != null) {
      if (startcontrol == true) {
        line(map(imet, 0, myStringsmet.length - 1, 85, 255), 60, map(imet, 0, myStringsmet.length - 1, 85, 255), 480);
      }
    }

    try {
      launchdatamethod();
    }
    catch (Exception e) {
      e.printStackTrace();
    }

    Drawmethod();
  }

  void keyPressed() {

    if (key == ESC) {
      key = 0;
    }

    if (key == ENTER) {
      Previewlog();
    }

    if (key == CODED) {

      if (activeTab.equals("tab_preview")) {

        if (windatabase != null) {

          try {
            if (int(getConfigurationString("fnkey")) == 1) {
              int verif = selectedItemIndex;
              if (keyCode ==  java.awt.event.KeyEvent.VK_PAGE_UP) {
                selectedItemIndex = max(0, selectedItemIndex - 1);
                updateScrollableListSelection();
                selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
                if (selectedItemIndex != verif) {
                  opendt();
                }
              }

              if (keyCode ==  java.awt.event.KeyEvent.VK_PAGE_DOWN) {
                selectedItemIndex = max(0, selectedItemIndex + 1);
                updateScrollableListSelection();
                selectedItemIndex = min(fileNames.length - 1, selectedItemIndex);
                if (selectedItemIndex != verif) {
                  opendt();
                }
              }
            }
          }
          catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }

    if (key == CODED) {
      switch (keyCode) {
      case java.awt.event.KeyEvent.VK_F1:
        Manual();
        break;

      case java.awt.event.KeyEvent.VK_F2:
        if (int(getConfigurationString("fnkey")) == 1 && statusok) {
          startrecb.setValue(statusstartrec ? 0 : 1);
        }
        break;

      case java.awt.event.KeyEvent.VK_F3:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && !reccontrol) {
          startcontrolb.setValue(startcontrol ? 0 : 1);
        }
        break;

      case java.awt.event.KeyEvent.VK_F4:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && !startcontrol) {
          reccontrolb.setValue(reccontrol ? 0 : 1);
        }
        break;

      case java.awt.event.KeyEvent.VK_F5:
        if (int(getConfigurationString("fnkey")) == 1 && statusok) {
          a = a == 0 ? 1 : 0;
        }
        break;

      case java.awt.event.KeyEvent.VK_F6:
        if (int(getConfigurationString("fnkey")) == 1 && statusok) {
          b = b == 0 ? 1 : 0;
        }
        break;

      case java.awt.event.KeyEvent.VK_F7:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          dout1.setValue(c == 1 ? 0 : 1);
        }
        break;

      case java.awt.event.KeyEvent.VK_F8:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          dout2.setValue(d == 1 ? 0 : 1);
        }
        break;

      case java.awt.event.KeyEvent.VK_F12:
        if (tab_control.isActive()) {
          tab_preview.bringToFront();
        } else {
          tab_control.bringToFront();
        }
        break;

      case LEFT:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          tplock = false;
          tptemp -= 0.1;
          tptemp = max(tptemp, float(getConfigurationString("controltempmin")));
          knob1.setValue(tptemp);
          tplock = true;
        }
        break;

      case RIGHT:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          tplock = false;
          tptemp += 0.1;
          tptemp = min(tptemp, float(getConfigurationString("controltemp")));
          knob1.setValue(tptemp);
          tplock = true;
        }
        break;

      case DOWN:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          mtlock = false;
          mttemp = max(mttemp - 1, 0);
          knob2.setValue(mttemp);
          mtlock = true;
        }
        break;

      case UP:
        if (int(getConfigurationString("fnkey")) == 1 && statusok && reccontrol) {
          mtlock = false;
          mttemp = min(mttemp + 1, int(getConfigurationString("motorspeed")));
          knob2.setValue(mttemp);
          mtlock = true;
        }
        break;
      }
    }
  }

  // Handling mouse click event
  void mousePressed() {
    if (lastTimeprev + waitprev > millis()) {
      Previewlog();
    } else {
      lastTimeprev = millis();
    }
  }

  void relay1(boolean theFlag) {
    if (theFlag) {
      a = 1;
    }

    if  (!theFlag) {
      a = 0;
    }
  }

  void relay2(boolean theFlag) {
    if (theFlag) {
      b = 1;
    }

    if  (!theFlag) {
      b = 0;
    }
  }

  void dout1(boolean theFlag) {
    if (theFlag) {
      c = 1;
    }

    if  (!theFlag) {
      c = 0;
    }
  }

  void dout2(boolean theFlag) {
    if (theFlag) {
      d = 1;
    }

    if  (!theFlag) {
      d = 0;
    }
  }

  // function for drawing a text box with title and contents
  void Drawcontour_outer2_Control( int x, int y, int w, int h) {

    fill(130);
    stroke(30);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
    noFill();
    noStroke();
  }

  // function for drawing a text box with title and contents
  void Drawcontour_outer_Control( int x, int y, int w, int h) {

    fill(int(map(int(getConfigurationString("graph5")), 150, 240, 210, 240)));
    stroke(150);
    strokeWeight(0.5);
    rect(x, y, w, h, 20);
    noFill();
    noStroke();
  }

  // function for drawing a text box with title and contents
  void Drawcontour_inner_Control( int x, int y, int w, int h) {

    fill(200);
    stroke(240);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
    noFill();
    noStroke();
  }

  // Function for drawing a text box with title and contents (vertical)
  void Drawcontour_outer2_Preview(int x, int y, int w, int h) {

    fill(int(map(int(getConfigurationString("graph2")), 0, 255, 255, 230)));
    stroke(255);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
    noFill();
    noStroke();
  }

  void Previewlog() {
    if (activeTab.equals("tab_preview")) {

      // Toggle log scale
      logScale = !logScale;

      if (logScale) {
        plot1mp.setLogScale("y");
        plot1mp.getYAxis().setAxisLabelText("log y");
        plot2mp.setLogScale("y");
        plot2mp.getYAxis().setAxisLabelText("log y");
        plot3mp.setLogScale("y");
        plot3mp.getYAxis().setAxisLabelText("log y");
        plot4mp.setLogScale("y");
        plot4mp.getYAxis().setAxisLabelText("log y");
      } else {
        plot1mp.setLogScale("");
        plot1mp.getYAxis().setAxisLabelText(getConfigurationString("unit6"));
        plot2mp.setLogScale("");
        plot2mp.getYAxis().setAxisLabelText(getConfigurationString("unit7"));
        plot3mp.setLogScale("");
        plot3mp.getYAxis().setAxisLabelText("State");
        plot4mp.setLogScale("");
        plot4mp.getYAxis().setAxisLabelText("State");
      }
    }
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Numberbox.class) || theEvent.isAssignableFrom(Button.class) || theEvent.isAssignableFrom(Knob.class)) {
      String value = theEvent.getValue() + "";

      switch (theEvent.getName()) {
      case "knob1":

      case "knob2":

      case "dout1":

      case "dout2":

      case "relay1":

      case "relay2":
        configuration.setString(theEvent.getName(), value);
        break;
      }
    }
  }

  void mouseWheel(MouseEvent event) {

    // Handling mouse wheel event
    if (activeTab.equals("tab_preview") && isWindowFocused1 == true) {

      if (windatabase != null) {

        try {

          if (folderPath.equals(topSketchPath + "/method/" + username)) {
            if ((mouseX > 10 & mouseX < 290) & (mouseY > 10 & mouseY < 520)) {
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
        catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
  }

  GPointsArray downsamplePoints_Met(GPointsArray data, int maxPoints) {
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

  void Drawmethod() {

    plot1mp.beginDraw();
    plot1mp.drawYAxis();
    plot1mp.drawTitle();
    plot1mp.drawLines();
    plot1mp.drawGridLines(GPlot.VERTICAL);
    plot1mp.endDraw();

    plot2mp.beginDraw();
    plot2mp.drawYAxis();
    plot2mp.drawTitle();
    plot2mp.drawLines();
    plot2mp.drawGridLines(GPlot.VERTICAL);
    plot2mp.endDraw();

    plot3mp.beginDraw();
    plot3mp.drawYAxis();
    plot3mp.drawTitle();
    plot3mp.drawLines();
    plot3mp.drawGridLines(GPlot.VERTICAL);
    plot3mp.endDraw();

    plot4mp.beginDraw();
    plot4mp.drawYAxis();
    plot4mp.drawTitle();
    plot4mp.drawLines();
    plot4mp.drawGridLines(GPlot.VERTICAL);
    plot4mp.endDraw();

    plot11mp.beginDraw();
    plot11mp.drawXAxis();
    plot11mp.endDraw();

    plot12mp.beginDraw();
    plot12mp.drawXAxis();
    plot12mp.endDraw();

    plot13mp.beginDraw();
    plot13mp.drawXAxis();
    plot13mp.endDraw();

    plot14mp.beginDraw();
    plot14mp.drawXAxis();
    plot14mp.endDraw();
  }

  void launchdatamethod() {

    if (refreshmethod) {
      temperaturep = new GPointsArray();
      speedp = new GPointsArray();
      dout1p = new GPointsArray();
      dout2p = new GPointsArray();

      if (myStringsmet != null) {
        numLinesmethod = myStringsmet.length - 1; // Exclude the header line

        plot1mp.setTitleText(getConfigurationString("sensor6"));
        plot1mp.getYAxis().setAxisLabelText(getConfigurationString("unit6"));
        plot2mp.setTitleText(getConfigurationString("sensor7"));
        plot2mp.getYAxis().setAxisLabelText(getConfigurationString("unit7"));

        plot11mp.setXLim(0, timeshsel);
        plot12mp.setXLim(0, timeshsel);
        plot13mp.setXLim(0, timeshsel);
        plot14mp.setXLim(0, timeshsel);

        plot1mp.setXLim(0, numLinesmethod);
        plot2mp.setXLim(0, numLinesmethod);
        plot3mp.setXLim(0, numLinesmethod);
        plot4mp.setXLim(0, numLinesmethod);

        for (int i = 0; i < numLinesmethod; i++) {
          values = myStringsmet[i].split(";");
          temperaturep.add(i, float(values[0]));
          speedp.add(i, float(values[1]));
          dout1p.add(i, float(values[2]));
          dout2p.add(i, float(values[3]));
        }

        // Add the points to the plots
        plot1mp.setPoints(downsamplePoints_Met(temperaturep, maxDisplayPoints));
        plot2mp.setPoints(downsamplePoints_Met(speedp, maxDisplayPoints));
        plot3mp.setPoints(downsamplePoints_Met(dout1p, maxDisplayPoints));
        plot4mp.setPoints(downsamplePoints_Met(dout2p, maxDisplayPoints));
      } else {
        plot1mp.setPoints(new GPointsArray());
        plot2mp.setPoints(new GPointsArray());
        plot3mp.setPoints(new GPointsArray());
        plot4mp.setPoints(new GPointsArray());
      }

      refreshmethod = false;
    }
  }

  PApplet parent; // Reference to the parent PApplet

  void exit() {
    try {
      delay(500);
      cp2 = null;
      wincontrol = null;
      this.stop();
      this.dispose();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}
