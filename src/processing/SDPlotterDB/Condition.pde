public class PWindowcnd extends PApplet {
  int xLct, yLct;

  PWindowcnd(int xLct, int yLct) {
    // Start the sketch with the name of the current class
    super();
    this.xLct = xLct;
    this.yLct = yLct;
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  int waitdatacn = 200, lastTimedatacn = -waitdatacn;

  void settings() {
    // Initial settings for the sketch
    smooth(2);  // Enable anti-aliasing
    size(466, 354);  // Set the window size
  }

  void setup() {

    surface.setTitle("Condition");  // Set the window title
    surface.setLocation(xLct + 400, yLct + 100);
    frameRate(10);  // Set the frame rate to 10 frames per second

    // Initialize the ControlP5 GUI
    cp7 = new ControlP5(this);
    cp7.setAutoDraw(false);  // Disable automatic drawing of the GUI

    // Add labels and number boxes for various conditions
    cp7.addTextlabel("1")
      .setText("When the value of probe          is greater than                            , relay            on")
      .setPosition(28, 34)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    cp7.addTextlabel("2")
      .setText("While the value of probe          is greater than                            , relay            on")
      .setPosition(28, 64)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    cp7.addTextlabel("3")
      .setText("When the value of probe              is less than                              , relay            on")
      .setPosition(28, 94)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    cp7.addTextlabel("4")
      .setText("While the value of probe              is less than                              , relay            on")
      .setPosition(28, 124)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    cp7.addTextlabel("5")
      .setText("When the value of probe          is greater than                            , start method:")
      .setPosition(28, 205)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    cp7.addTextlabel("6")
      .setText("When the value of probe              is less than                              , start method:")
      .setPosition(28, 265)
      .setColor(color(5, 5, 5))
      .setFont(createFont("Georgia", 12));

    // Add number boxes for probe conditions with initial values from configuration
    cp7.addNumberbox("probecond1")
      .setPosition(165, 35)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond1")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("probecond2")
      .setPosition(165, 65)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond2")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("probecond3")
      .setPosition(165, 95)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond3")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("probecond4")
      .setPosition(165, 125)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond4")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("probecond5")
      .setPosition(165, 206)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond5")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("probecond6")
      .setPosition(165, 266)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("probecond6")))
      .setRange(0, 8)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    // Add number boxes for value conditions with initial values from configuration
    cp7.addNumberbox("valuecond1")
      .setPosition(275, 35)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond1")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    cp7.addNumberbox("valuecond2")
      .setPosition(275, 65)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond2")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    cp7.addNumberbox("valuecond3")
      .setPosition(275, 95)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond3")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    cp7.addNumberbox("valuecond4")
      .setPosition(275, 125)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond4")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    cp7.addNumberbox("valuecond5")
      .setPosition(275, 206)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond5")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    cp7.addNumberbox("valuecond6")
      .setPosition(275, 266)
      .setSize(70, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(float(getConfigurationString("valuecond6")))
      .setRange(-999999, 999999)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-0.01);

    // Add number boxes for relay conditions with initial values from configuration
    cp7.addNumberbox("relaycond1")
      .setPosition(390, 35)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("relaycond1")))
      .setRange(1, 2)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("relaycond2")
      .setPosition(390, 65)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("relaycond2")))
      .setRange(1, 2)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("relaycond3")
      .setPosition(390, 95)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("relaycond3")))
      .setRange(1, 2)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    cp7.addNumberbox("relaycond4")
      .setPosition(390, 125)
      .setSize(20, 15)
      .setFont(createFont("Georgia", 10))
      .setValue(int(getConfigurationString("relaycond4")))
      .setRange(1, 2)
      .setLabel("")
      .setColorValue(0)
      .setColorBackground(color(255, 255, 255))
      .setColorForeground(color(0, 0, 0, 0))
      .setMultiplier(-1);

    // Add text fields for method conditions with initial values from configuration
    mtcd1 = cp7.addTextfield("methodcond1")
      .setLabel("")
      .setPosition(58, 236)
      .setSize(350, 15)
      .setFont(createFont("Georgia", 10))
      .setText(getConfigurationString("methodcond1"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(color(255, 255, 255))
      .setColorValue(0)
      .setColorForeground(color(255, 255, 255))
      .setUpdate(true)
      .updateSize()
      .setColorActive(color(0, 0, 0, 0))
      .setColorCursor(0);

    mtcd2 = cp7.addTextfield("methodcond2")
      .setLabel("")
      .setPosition(58, 296)
      .setSize(350, 15)
      .setFont(createFont("Georgia", 10))
      .setText(getConfigurationString("methodcond2"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(color(255, 255, 255))
      .setColorValue(0)
      .setColorForeground(color(255, 255, 255))
      .setUpdate(true)
      .updateSize()
      .setColorActive(color(0, 0, 0, 0))
      .setColorCursor(0);
  }

  void draw() {
    // Set the window title and background color
    surface.setTitle("Condition");
    background(int(getConfigurationString("graph6")));

    // Draw rectangles at the top and bottom
    fill(120);
    noStroke();
    rect(0, 0, width, 9);
    rect(0, height - 9, width, 9);

    // Draw contours
    Drawcontourd(12, 13, 442, 158);
    Drawcontourdx(20, 19, 426, 146);

    Drawcontourd(12, 183, 442, 156);
    Drawcontourdx(20, 189, 426, 144);

    if (wincondition != null) {
      if (cp7 != null) {

        // Update method condition 1 if in focus
        if (mtcd1.isFocus()) {
          configuration.setString("methodcond1", cp7.get(Textfield.class, "methodcond1").getText());
          if (iscontrol && key == 'v') {
            clipboarddt = GetTextFromClipboard();
            mtcd1.setText(clipboarddt);
          }
        }

        // Update method condition 2 if in focus
        if (mtcd2.isFocus()) {
          configuration.setString("methodcond2", cp7.get(Textfield.class, "methodcond2").getText());
          if (iscontrol && key == 'v') {
            clipboarddt = GetTextFromClipboard();
            mtcd2.setText(clipboarddt);
          }
        }

        // Update the colors of probe and value conditions based on their values
        updateProbeValueColor("probecond1", "valuecond1");
        updateProbeValueColor("probecond2", "valuecond2");
        updateProbeValueColor("probecond3", "valuecond3");
        updateProbeValueColor("probecond4", "valuecond4");
        updateProbeValueColor("probecond5", "valuecond5");
        updateProbeValueColor("probecond6", "valuecond6");

        // Lock or unlock controllers based on admin and RightAxis status
        lockControllers();
      }

      // Draw the ControlP5 GUI
      cp7.draw();
    }

    // Toggle window visibility based on login status
    if (modevisible4 == 1) {
      surface.setVisible(!login);
      modevisible4 = 0;
    }
  }

  // Placeholder methods for probe conditions
  void probecond1(int f) {
  }
  void probecond2(int f) {
  }
  void probecond3(int f) {
  }
  void probecond4(int f) {
  }
  void probecond5(int f) {
  }
  void probecond6(int f) {
  }

  // Placeholder methods for relay conditions
  void relaycond1(int f) {
  }
  void relaycond2(int f) {
  }
  void relaycond3(int f) {
  }
  void relaycond4(int f) {
  }

  void mousePressed() {
    // Check if enough time has passed since the last data update
    if (lastTimedatacn + waitdatacn > millis()) {
      // Check if the mouse is within the bounds of method condition 1 text field
      if ((mouseX > 58 && mouseX < 408) && (mouseY > 236 && mouseY < 251)) {
        if (mtcd1.isFocus() && myStringsmet != null) {
          configuration.setString("methodcond1", topSketchPath + "/method/" + username + "/" + numberfile);
          mtcd1.setText(getConfigurationString("methodcond1"));
        }
      }
      // Check if the mouse is within the bounds of method condition 2 text field
      if ((mouseX > 58 && mouseX < 408) && (mouseY > 296 && mouseY < 311)) {
        if (mtcd2.isFocus() && myStringsmet != null) {
          configuration.setString("methodcond2", topSketchPath + "/method/" + username + "/" + numberfile);
          mtcd2.setText(getConfigurationString("methodcond2"));
        }
      }
    } else {
      lastTimedatacn = millis();  // Update the last data update time
    }
  }

  void keyReleased() {
    if (key == CODED && keyCode == ALT) {
      iscontrol = false;
    }
  }

  void keyPressed() {
    if (key == ESC) {
      key = 0;  // Prevent the default behavior of ESC key
    }

    if (key == CODED) {

      if (keyCode == ALT) {
        iscontrol = true;
      }

      if (keyCode == java.awt.event.KeyEvent.VK_F1) {
        Manual();  // Call the Manual method when F1 is pressed
      }
    }
  }

  // Function to draw a contour with rounded corners
  void Drawcontourd(int x, int y, int w, int h) {
    fill(int(getConfigurationString("graph5")));  // Set fill color
    stroke(30);  // Set stroke color
    strokeWeight(0.5);  // Set stroke weight
    rect(x, y, w, h, 20);  // Draw rectangle with rounded corners
    noFill();  // Disable fill
    noStroke();  // Disable stroke
  }

  // Function to draw another contour with different styling
  void Drawcontourdx(int x, int y, int w, int h) {
    fill(205);  // Set fill color
    stroke(240);  // Set stroke color
    strokeWeight(0.5);  // Set stroke weight
    rect(x, y, w, h, 10);  // Draw rectangle with different rounded corners
    noFill();  // Disable fill
    noStroke();  // Disable stroke
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class) || theEvent.isAssignableFrom(Numberbox.class)) {
      String value = "";

      if (theEvent.isAssignableFrom(Numberbox.class))
        value = theEvent.getValue() + "";

      updateConfiguration(theEvent.getName(), value);
    }
  }

  // Method to update the color of probe and value conditions
  void updateProbeValueColor(String probeCond, String valueCond) {
    if (int(getConfigurationString(probeCond)) != 0) {
      cp7.getController(probeCond).setColorForeground(graphColors[int(getConfigurationString(probeCond)) - 1]);
      cp7.getController(valueCond).setColorForeground(graphColors[int(getConfigurationString(probeCond)) - 1]);
    } else {
      cp7.getController(probeCond).setColorForeground(graphColors[8]);
      cp7.getController(valueCond).setColorForeground(graphColors[8]);
    }
  }

  // Method to lock or unlock controllers based on admin and RightAxis status
  void lockControllers() {
    for (String cond : new String[]{"probecond1", "probecond2", "probecond3", "probecond4", "probecond5", "probecond6", "valuecond1", "valuecond2", "valuecond3", "valuecond4", "valuecond5", "valuecond6", "relaycond1", "relaycond2", "relaycond3", "relaycond4"}) {
      cp7.getController(cond).setLock(!admin || !RightAxis);
    }

    mtcd1.setLock(!admin || !RightAxis);
    mtcd2.setLock(!admin || !RightAxis);
  }

  // Method to update configuration based on control events
  void updateConfiguration(String name, String value) {
    configuration.setString(name, value);
  }

  PApplet parent; // Reference to the parent PApplet

  void exit() {
    delay(500);
    wincondition = null;
    this.dispose();
    this.stop();
  }
}
