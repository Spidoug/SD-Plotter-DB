public class PWindows extends PApplet {
  int xLct, yLct;

  // Constructor
  PWindows(int xLct, int yLct) {
    super();
    this.xLct = xLct;
    this.yLct = yLct;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  int irty = 1;
  int isize = irty;
  int temp;

  boolean isWindowFocused2 = true;

  // Settings method for smooth rendering and window size
  void settings() {
    smooth(2);
    size(824, 354);
  }

  // Setup method for initializing the window title and GUI elements
  void setup() {

    surface.setTitle("Settings");
    surface.setLocation(xLct + 5, yLct + 231);

    final Frame frame = (Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
    frame.addWindowFocusListener(new WindowFocusListener() {
      @Override
        public void windowGainedFocus(WindowEvent e) {
        isWindowFocused2 = true;
      }

      @Override
        public void windowLostFocus(WindowEvent e) {
        isWindowFocused2 = false;
      }
    }
    );

    // Load images for the GUI
    PImage[] Calibration = loadImages("/lib/src/calibration_a.png", "/lib/src/calibration_b.png", "/lib/src/calibration_a.png");
    PImage[] Manager = loadImages("/lib/src/manager_a.png", "/lib/src/manager_b.png", "/lib/src/manager_c.png");
    PImage[] Fnkey = loadImages("/lib/src/fnkey_a.png", "/lib/src/fnkey_b.png", "/lib/src/null_a.png");
    PImage[] Externalevent = loadImages("/lib/src/externalevent_a.png", "/lib/src/externalevent_b.png", "/lib/src/null_a.png");
    PImage[] Demo = loadImages("/lib/src/demo_a.png", "/lib/src/demo_b.png", "/lib/src/null_a.png");

    // Initialize ControlP5 library for GUI controls
    cp3 = new ControlP5(this);
    cp3.setAutoDraw(false);

    // Add labels to the GUI
    cp3.addTextlabel("color")
      .setText("Color")
      .setPosition(31, 22)
      .setColor(43)
      .setFont(createFont("Georgia", 12));

    cp3.addTextlabel("configurations1")
      .setText("Data").setPosition(35, 136)
      .setColor(43)
      .setFont(createFont("Georgia", 10));

    cp3.addTextlabel("configurations0")
      .setText("EEPROM")
      .setPosition(25, 185)
      .setColor(43)
      .setFont(createFont("Georgia", 10));

    cp3.addTextlabel("configurations2")
      .setText("Tx/Rx")
      .setPosition(32, 234)
      .setColor(43)
      .setFont(createFont("Georgia", 10));

    cp3.addTextlabel("serial")
      .setText("SN: SD")
      .setPosition(112, 249)
      .setColor(43)
      .setFont(createFont("Georgia", 11));

    cp3.addTextlabel("sensor")
      .setText("Sensor")
      .setPosition(257, 22)
      .setColor(43)
      .setFont(createFont("Georgia", 12));

    cp3.addTextlabel("span")
      .setText("Span")
      .setPosition(345, 22)
      .setColor(43)
      .setFont(createFont("Georgia", 12));

    cp3.addTextlabel("zero")
      .setText("Zero")
      .setPosition(420, 22)
      .setColor(43)
      .setFont(createFont("Georgia", 12));

    cp3.addTextlabel("softwaresmoothshow")
      .setText("Smooth/S")
      .setPosition(483, 23)
      .setColor(43)
      .setFont(createFont("Georgia", 11));

    cp3.addTextlabel("hardwaresmoothshow")
      .setText("Smooth/H")
      .setPosition(558, 23)
      .setColor(43)
      .setFont(createFont("Georgia", 11));

    cp3.addTextlabel("pid")
      .setText("PID (/1000)")
      .setPosition(649, 24)
      .setColor(43)
      .setFont(createFont("Georgia", 10));

    cp3.addTextlabel("tools")
      .setText("Motor")
      .setPosition(746, 23)
      .setColor(43)
      .setFont(createFont("Georgia", 11));

    cp3.addTextlabel("visible")
      .setText("On/Off")
      .setPosition(745, 159)
      .setColor(#050505)
      .setFont(createFont("Georgia", 10));

    cp3.addTextlabel("users")
      .setText("Users")
      .setPosition(32, 308)
      .setColor(43)
      .setFont(createFont("Georgia", 14));

    cp3.addTextlabel("sets")
      .setText("Sets")
      .setPosition(253, 308)
      .setColor(43)
      .setFont(createFont("Georgia", 14));

    // Add number boxes to the GUI
    graph1 = cp3.addNumberbox("graph1")
      .setPosition(31, 47)
      .setSize(39, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel(" Graph")
      .setValue(int(getConfigurationString("graph1")))
      .setRange(70, 255)
      .setColorValue(0)
      .setColorBackground(#00BFFF)
      .setColorForeground(0xffffffff)
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-256);

    graph4 = cp3.addNumberbox("graph4")
      .setPosition(31, 87)
      .setSize(39, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("Monitor")
      .setValue(int(getConfigurationString("graph4")))
      .setRange(0, 255)
      .setColorValue(0)
      .setColorBackground(#00BFFF)
      .setColorForeground(0xffffffff)
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-256);

    // Add more number boxes for various inputs
    lgmultiplier1 = cp3.addNumberbox("input_11")
      .setPosition(343, 45)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier1")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[0])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgmultiplier2 = cp3.addNumberbox("input_12")
      .setPosition(343, 85)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier2")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[1])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgmultiplier3 = cp3.addNumberbox("input_13")
      .setPosition(343, 125)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier3")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[2])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgmultiplier4 = cp3.addNumberbox("input_14")
      .setPosition(343, 165)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier4")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[3])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgmultiplier5 = cp3.addNumberbox("input_15")
      .setPosition(343, 205)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier5")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[4])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgmultiplier6 = cp3.addNumberbox("input_16")
      .setPosition(343, 245)
      .setSize(40, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("   /10000")
      .setValue(int(float(getConfigurationString("lgmultiplier6")) * 10000))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    // Add more number boxes for lgspan values
    lgspan1 = cp3.addNumberbox("input_17")
      .setPosition(418, 45)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan1")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[0])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgspan2 = cp3.addNumberbox("input_18")
      .setPosition(418, 85)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan2")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[1])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgspan3 = cp3.addNumberbox("input_19")
      .setPosition(418, 125)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan3")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[2])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgspan4 = cp3.addNumberbox("input_20")
      .setPosition(418, 165)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan4")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[3])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgspan5 = cp3.addNumberbox("input_21")
      .setPosition(418, 205)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan5")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[4])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    lgspan6 = cp3.addNumberbox("input_22")
      .setPosition(418, 245)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 8))
      .setLabel("      /10")
      .setValue(int(float(getConfigurationString("lgspan6")) * 10))
      .setRange(-999999, 999999)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setMultiplier(-1);

    // Add more number boxes for lgsmooth values
    lgsmooth1 = cp3.addNumberbox("input_23")
      .setPosition(493, 45)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth1")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[0])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    lgsmooth2 = cp3.addNumberbox("input_24")
      .setPosition(493, 85)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth2")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[1])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    lgsmooth3 = cp3.addNumberbox("input_25")
      .setPosition(493, 125)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth3")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[2])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    lgsmooth4 = cp3.addNumberbox("input_26")
      .setPosition(493, 165)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth4")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[3])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    lgsmooth5 = cp3.addNumberbox("input_27")
      .setPosition(493, 205)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth5")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[4])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    lgsmooth6 = cp3.addNumberbox("input_28")
      .setPosition(493, 245)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("lgsmooth6")))
      .setRange(0, 1000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    // Add number boxes for hardware smoothing values
    hardwarelgsmooth1 = cp3.addNumberbox("input_29")
      .setPosition(568, 45)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth1")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[0])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    hardwarelgsmooth2 = cp3.addNumberbox("input_30")
      .setPosition(568, 85)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth2")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[1])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    hardwarelgsmooth3 = cp3.addNumberbox("input_31")
      .setPosition(568, 125)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth3")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[2])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    hardwarelgsmooth4 = cp3.addNumberbox("input_32")
      .setPosition(568, 165)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth4")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[3])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    hardwarelgsmooth5 = cp3.addNumberbox("input_33")
      .setPosition(568, 205)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth5")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[4])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    hardwarelgsmooth6 = cp3.addNumberbox("input_34")
      .setPosition(568, 245)
      .setSize(40, 15)
      .setFont(createFont("Georgia", 9))
      .setLabel("weight")
      .setValue(int(getConfigurationString("hardwarelgsmooth6")))
      .setRange(1, 8)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    // Add number boxes for PID control parameters
    temppidkp = cp3.addNumberbox("temppidkp")
      .setPosition(651, 45)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Kp(temp)")
      .setValue(int(getConfigurationString("temppidkp")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    temppidki = cp3.addNumberbox("temppidki")
      .setPosition(651, 85)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Ki(temp)")
      .setValue(int(getConfigurationString("temppidki")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    temppidkd = cp3.addNumberbox("temppidkd")
      .setPosition(651, 125)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Kd(temp)")
      .setValue(int(getConfigurationString("temppidkd")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[5])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    speedpidkp = cp3.addNumberbox("speedpidkp")
      .setPosition(651, 165)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Kp(speed)")
      .setValue(int(getConfigurationString("speedpidkp")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    speedpidki = cp3.addNumberbox("speedpidki")
      .setPosition(651, 205)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Ki(speed)")
      .setValue(int(getConfigurationString("speedpidki")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    speedpidkd = cp3.addNumberbox("speedpidkd")
      .setPosition(651, 245)
      .setSize(58, 13)
      .setFont(createFont("Georgia", 9))
      .setLabel("  Kd(speed)")
      .setValue(int(getConfigurationString("speedpidkd")))
      .setRange(0, 32000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    // Add number boxes for motor parameters
    motorspeed = cp3.addNumberbox("motorspeed")
      .setPosition(741, 45)
      .setSize(50, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("  Max RPM")
      .setValue(int(getConfigurationString("motorspeed")))
      .setRange(1, 500000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-100);

    encoder = cp3.addNumberbox("encoder")
      .setPosition(741, 79)
      .setSize(50, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel("        CPR")
      .setValue(int(getConfigurationString("encoder")))
      .setRange(1, 500)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    motorpower = cp3.addNumberbox("motorpower")
      .setPosition(741, 112)
      .setSize(50, 13)
      .setFont(createFont("Georgia", 8))
      .setLabel(" Power (W)")
      .setValue(int(getConfigurationString("motorpower")))
      .setRange(1, 65000)
      .setColorCaptionLabel(40)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(graphColors[6])
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    buffer = cp3.addNumberbox("buffer")
      .setPosition(115, 125)
      .setSize(90, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("           Buffer")
      .setValue(int(getConfigurationString("buffer")))
      .setRange(300, 10000)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-1);

    baudrate = cp3.addNumberbox("baudrate")
      .setPosition(115, 165)
      .setSize(90, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel(" baud rate (bps)")
      .setValue(int(getConfigurationString("baudrate")))
      .setRange(19200, 115200)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColorActive(0x00000000)
      .setColorLabel(0)
      .setMultiplier(-24000);

    hardwarebaudrate = cp3.addNumberbox("hardwarebaudrate")
      .setPosition(115, 205)
      .setSize(90, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("    baud rate /H")
      .setValue(int(getConfigurationString("hardwarebaudrate")))
      .setRange(0, 3)
      .setColorValue(0)
      .setColorBackground(0xffffffff)
      .setColorForeground(0xffffffff)
      .setColorActive(#FC0808)
      .setColorLabel(0)
      .setMultiplier(-1);

    // Add text fields to the GUI
    cp3.addTextfield("machinecode")
      .setPosition(115, 28)
      .setSize(90, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("  Machine code")
      .setColorBackground(0xffffffff)
      .setColor(40)
      .setText(str(keyinopen))
      .setColorCaptionLabel(40)
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorForeground(0xffffffff)
      .setLock(true)
      .setColorCursor(0);

    license = cp3.addTextfield("input_1")
      .setPosition(115, 68)
      .setSize(90, 20)
      .setFont(createFont("Georgia", 9))
      .setLabel("            License")
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);

    serialnumber = cp3.addTextfield("input_2")
      .setPosition(155, 245)
      .setSize(50, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("serialnumber"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(0xffffffff)
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor1 = cp3.addTextfield("input_3")
      .setPosition(250, 45)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor1"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[0])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor2 = cp3.addTextfield("input_4")
      .setPosition(250, 85)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor2"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[1])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor3 = cp3.addTextfield("input_5")
      .setPosition(250, 125)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor3"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[2])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor4 = cp3.addTextfield("input_6")
      .setPosition(250, 165)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor4"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[3])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor5 = cp3.addTextfield("input_7")
      .setPosition(250, 205)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor5"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[4])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;

    sensor6 = cp3.addTextfield("input_8")
      .setPosition(250, 245)
      .setSize(59, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("sensor6"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColorValue(0)
      .setColorForeground(graphColors[5])
      .setUpdate(true)
      .updateSize()
      .setColorActive(0x00000000)
      .setColorCursor(0);
    irty++;
    isize = irty;
    irty = 1;

    // Add text fields for hardware IP and mask configurations, hidden by default
    hardwareip1 = cp3.addTextfield("hardwareip1")
      .setPosition(115, 125)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("    ip hardware")
      .setText(getConfigurationString("hardwareip1"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwareip2 = cp3.addTextfield("hardwareip2")
      .setPosition(137, 125)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwareip2"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwareip3 = cp3.addTextfield("hardwareip3")
      .setPosition(159, 125)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwareip3"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwareip4 = cp3.addTextfield("hardwareip4")
      .setPosition(181, 125)
      .setSize(22, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwareip4"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwaremask1 = cp3.addTextfield("hardwaremask1")
      .setPosition(115, 165)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("mask hardware")
      .setText(getConfigurationString("hardwaremask1"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwaremask2 = cp3.addTextfield("hardwaremask2")
      .setPosition(137, 165)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwaremask2"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwaremask3 = cp3.addTextfield("hardwaremask3")
      .setPosition(159, 165)
      .setSize(18, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwaremask3"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwaremask4 = cp3.addTextfield("hardwaremask4")
      .setPosition(181, 165)
      .setSize(22, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setText(getConfigurationString("hardwaremask4"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    hardwareport = cp3.addTextfield("hardwareport")
      .setPosition(115, 205)
      .setSize(90, 15)
      .setFont(createFont("Georgia", 10))
      .setLabel("port hardware")
      .setText(getConfigurationString("hardwareport"))
      .setColorCaptionLabel(40)
      .setAutoClear(false)
      .setColorBackground(0xffffffff)
      .setColor(0)
      .setColorForeground(0xffffffff)
      .updateSize()
      .setColorActive(#FC0808)
      .setColorCursor(0)
      .hide();

    // Add toggles and buttons to the GUI
    recparameters = cp3.addToggle("recparameters")
      .setPosition(31, 150)
      .setSize(39, 10)
      .setFont(createFont("Georgia", 7))
      .setLabel("Soft/Hard")
      .setValue(int(getConfigurationString("recparameters")))
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(#080000)
      .setColorBackground(0xffffffff);

    cleareeprom = cp3.addToggle("cleareeprom")
      .setPosition(31, 199)
      .setSize(39, 10)
      .setFont(createFont("Georgia", 7))
      .setLabel("Clear/Std")
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(#080000)
      .setColorBackground(0xffffffff);

    moderxtx = cp3.addToggle("moderxtx")
      .setPosition(31, 249)
      .setSize(39, 10)
      .setFont(createFont("Georgia", 7))
      .setLabel("Serial/USB")
      .setValue(0)
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(#080000)
      .setColorBackground(0xffffffff);

    hardwaresmooth = cp3.addToggle("hardwaresmooth")
      .setPosition(741, 182)
      .setSize(50, 10)
      .setFont(createFont("Georgia", 9))
      .setLabel("Smooth/H")
      .setValue(int(getConfigurationString("hardwaresmooth")))
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(#080000)
      .setColorBackground(0xffffffff);

    pidcontroltemperature = cp3.addToggle("pidcontroltemperature")
      .setPosition(741, 215)
      .setSize(50, 10)
      .setFont(createFont("Georgia", 9))
      .setLabel("  PID temp")
      .setValue(int(getConfigurationString("pidcontroltemperature")))
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(graphColors[5])
      .setColorBackground(0xffffffff);

    pidcontrolspeed = cp3.addToggle("pidcontrolspeed")
      .setPosition(741, 247)
      .setSize(50, 10)
      .setFont(createFont("Georgia", 9))
      .setLabel(" PID speed")
      .setValue(int(getConfigurationString("pidcontrolspeed")))
      .setColorCaptionLabel(0)
      .setMode(ControlP5.SWITCH)
      .setColorActive(graphColors[6])
      .setColorBackground(0xffffffff);

    cp3.addToggle("demo")
      .setPosition(317, 301)
      .setWidth(100)
      .setImages(Demo)
      .updateSize();

    cp3.addToggle("calibration")
      .setPosition(430, 301)
      .setWidth(100)
      .setImages(Calibration)
      .updateSize();

    cp3.addToggle("fnkey")
      .setPosition(575, 301)
      .setWidth(100)
      .setValue(int(getConfigurationString("fnkey")))
      .setImages(Fnkey)
      .updateSize();

    cp3.addToggle("externalevent")
      .setPosition(691, 301)
      .setWidth(100)
      .setValue(int(getConfigurationString("externalevent")))
      .setImages(Externalevent)
      .updateSize();

    cp3.addButton("manager")
      .setPosition(108, 301)
      .setWidth(100)
      .setImages(Manager)
      .updateSize();

    // Set license text field based on configuration
    if (getConfigurationString("license").equals(keyoutopen) || getConfigurationString("license").equals("All5@fe4u")) {
      license.setText(getConfigurationString("license"));
    } else {
      if (int(getConfigurationString("timeleft")) > 0) {
        license.setText("Trial");
      }
    }
  }

  // Draw method for rendering the GUI and handling interactions
  void draw() {

    surface.setAlwaysOnTop(ontopsett); // Keep window always on top
    surface.setTitle("Settings" + window2);
    background(int(getConfigurationString("graph6")));

    fill(120);
    noStroke();
    rect(0, 0, width, 9);
    rect(0, height - 9, width, 9);

    // Draw GUI contours
    Drawcontour_outer_Settings(13, 13, 74, 270);
    Drawcontour_inner_Settings(19, 19, 62, 105);
    Drawcontour_inner_Settings(19, 130, 62, 148);
    Drawcontour_outer_Settings(95, 13, 130, 270);
    Drawcontour_inner_Settings(103, 19, 113, 90);
    Drawcontour_inner_Settings(103, 116, 113, 162);
    Drawcontour_outer_Settings(233, 13, 393, 270);
    Drawcontour_inner_Settings(239, 19, 80, 260);
    Drawcontour_inner_Settings(330, 19, 65, 260);
    Drawcontour_inner_Settings(405, 19, 65, 260);
    Drawcontour_inner_Settings(480, 19, 65, 260);
    Drawcontour_inner_Settings(555, 19, 65, 260);
    Drawcontour_outer_Settings(634, 13, 174, 270);
    Drawcontour_inner_Settings(640, 19, 80, 260);
    Drawcontour_inner_Settings(730, 19, 72, 125);
    Drawcontour_inner_Settings(730, 153, 72, 125);
    Drawcontour_outer_Settings(13, 290, 212, 50);
    Drawcontour_inner_Settings(103, 295, 113, 40);
    Drawcontour_outer_Settings(233, 290, 319, 50);
    Drawcontour_inner_Settings(305, 295, 240, 40);
    Drawcontour_outer_Settings(560, 290, 250, 50);
    Drawcontour_inner_Settings(566, 295, 238, 40);

    // Handle mouse hover interactions for displaying window tooltips
    if ((mouseX > 31 & mouseX < 70) & (mouseY > 47 & mouseY < 73)) {
      window2 = " - Change the color of graphic characters and color of the chart";
    } else {
      window2 = "";
    }

    if ((mouseX > 31 & mouseX < 70) & (mouseY > 87 & mouseY < 113)) {
      window2 = " - Change the character color of the monitor display and background color of the monitor display";
    }

    if ((mouseX > 31 & mouseX < 70) & (mouseY > 136 & mouseY < 172)) {
      window2 = " - Selection of use of parameters by software or hardware";
    }

    if ((mouseX > 31 & mouseX < 70) & (mouseY > 185 & mouseY < 221)) {
      window2 = " - Function to clear EEPROM or write firmware";
    }

    if ((mouseX > 31 & mouseX < 70) & (mouseY > 235 & mouseY < 271)) {
      window2 = " - Function for serial communication";
    }

    if ((mouseX > 233 & mouseX < 626) & (mouseY > 14 & mouseY < 283)) {
      window2 = " - Signal processing parameters panel";
    }

    if ((mouseX > 95 & mouseX < 225) & (mouseY > 21 & mouseY < 108)) {
      window2 = " - Manage software license";
    }

    if ((mouseX > 95 & mouseX < 225) & (mouseY > 116 & mouseY < 277)) {
      window2 = " - General settings";
    }

    if ((mouseX > 13 & mouseX < 225) & (mouseY > 290 & mouseY < 340)) {
      window2 = " - Create and delete users";
    }

    if ((mouseX > 233 & mouseX < 552) & (mouseY > 290 & mouseY < 340)) {
      window2 = " - Enable signal demo and calibration mode";
    }

    if ((mouseX > 634 & mouseX < 808) & (mouseY > 21 & mouseY < 283)) {
      window2 = " - Hardware configuration";
    }

    if ((mouseX > 560 & mouseX < 810) & (mouseY > 290 & mouseY < 340)) {
      window2 = " - Enable external events and FN key control";
    }

    if (winsetting != null) {
      if (cp3 != null) {

        if (admin == true) {

          // Handle paste operation for sensor fields
          if (license.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                license.setText(clipboarddt);
              }
            }
          }

          if (sensor1.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor1.setText(clipboarddt);
              }
            }
          }

          if (sensor2.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor2.setText(clipboarddt);
              }
            }
          }

          if (sensor3.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor3.setText(clipboarddt);
              }
            }
          }

          if (sensor4.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor4.setText(clipboarddt);
              }
            }
          }

          if (sensor5.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor5.setText(clipboarddt);
              }
            }
          }

          if (sensor6.isFocus() == true) {
            if (iscontrol) {
              if (key == 'v') {
                clipboarddt = GetTextFromClipboard();
                sensor6.setText(clipboarddt);
              }
            }
          }
        }

        // Update configuration strings from the GUI controls
        configuration.setString("license", cp3.get(Textfield.class, "input_1").getText());
        configuration.setString("sensor1", cp3.get(Textfield.class, "input_3").getText());
        configuration.setString("sensor2", cp3.get(Textfield.class, "input_4").getText());
        configuration.setString("sensor3", cp3.get(Textfield.class, "input_5").getText());
        configuration.setString("sensor4", cp3.get(Textfield.class, "input_6").getText());
        configuration.setString("sensor5", cp3.get(Textfield.class, "input_7").getText());
        configuration.setString("sensor6", cp3.get(Textfield.class, "input_8").getText());
        configuration.setString("hardwareip1", cp3.get(Textfield.class, "hardwareip1").getText());
        configuration.setString("hardwareip2", cp3.get(Textfield.class, "hardwareip2").getText());
        configuration.setString("hardwareip3", cp3.get(Textfield.class, "hardwareip3").getText());
        configuration.setString("hardwareip4", cp3.get(Textfield.class, "hardwareip4").getText());
        configuration.setString("hardwaremask1", cp3.get(Textfield.class, "hardwaremask1").getText());
        configuration.setString("hardwaremask2", cp3.get(Textfield.class, "hardwaremask2").getText());
        configuration.setString("hardwaremask3", cp3.get(Textfield.class, "hardwaremask3").getText());
        configuration.setString("hardwaremask4", cp3.get(Textfield.class, "hardwaremask4").getText());
        configuration.setString("hardwareport", cp3.get(Textfield.class, "hardwareport").getText());

        // EEPROM handling and validation
        if (eepromst) {
          configuration.setString("serialnumber", cp3.get(Textfield.class, "input_2").getText());
        }

        // Validate and correct configuration values
        if (int(getConfigurationString("serialnumber")) > 9999 || int(getConfigurationString("serialnumber")) == 0) {
          configuration.setString("serialnumber", "1");
        }

        if (int(getConfigurationString("baudrate")) <= 20000) {
          configuration.setString("baudrate", "19200");
        } else if (int(getConfigurationString("baudrate")) <= 50000) {
          configuration.setString("baudrate", "38400");
        } else if (int(getConfigurationString("baudrate")) <= 80000) {
          configuration.setString("baudrate", "57600");
        } else if (int(getConfigurationString("baudrate")) <= 130000) {
          configuration.setString("baudrate", "115200");
        }

        // IP address validation
        if (int(getConfigurationString("hardwareip1")) > 255 || int(getConfigurationString("hardwareip1")) < 0 || getConfigurationString("hardwareip1").length() > 3) {
          configuration.setString("hardwareip1", "0");
        }

        if (int(getConfigurationString("hardwareip2")) > 255 || int(getConfigurationString("hardwareip2")) < 0 || getConfigurationString("hardwareip2").length() > 3) {
          configuration.setString("hardwareip2", "0");
        }

        if (int(getConfigurationString("hardwareip3")) > 255 || int(getConfigurationString("hardwareip3")) < 0 || getConfigurationString("hardwareip3").length() > 3) {
          configuration.setString("hardwareip3", "0");
        }

        if (int(getConfigurationString("hardwareip4")) > 255 || int(getConfigurationString("hardwareip4")) < 0 || getConfigurationString("hardwareip4").length() > 3) {
          configuration.setString("hardwareip4", "0");
        }

        // Mask validation
        if (int(getConfigurationString("hardwaremask1")) > 255 || int(getConfigurationString("hardwaremask1")) < 0 || getConfigurationString("hardwaremask1").length() > 3) {
          configuration.setString("hardwaremask1", "0");
        }

        if (int(getConfigurationString("hardwaremask2")) > 255 || int(getConfigurationString("hardwaremask2")) < 0 || getConfigurationString("hardwaremask2").length() > 3) {
          configuration.setString("hardwaremask2", "0");
        }

        if (int(getConfigurationString("hardwaremask3")) > 255 || int(getConfigurationString("hardwaremask3")) < 0 || getConfigurationString("hardwaremask3").length() > 3) {
          configuration.setString("hardwaremask3", "0");
        }

        if (int(getConfigurationString("hardwaremask4")) > 255 || int(getConfigurationString("hardwaremask4")) < 0 || getConfigurationString("hardwaremask4").length() > 3) {
          configuration.setString("hardwaremask4", "0");
        }

        // Port validation
        if (int(getConfigurationString("hardwareport")) > 9999 || int(getConfigurationString("hardwareport")) < 0 || getConfigurationString("hardwareport").length() > 4) {
          configuration.setString("hardwareport", "0");
        }

        // Graph and monitor color adjustments
        if (int(getConfigurationString("graph1")) == 70) {
          configuration.setString("graph2", "255");
        } else if (int(getConfigurationString("graph1")) == 255) {
          configuration.setString("graph2", "0");
        }

        if (int(getConfigurationString("graph4")) == 0) {
          configuration.setString("graph3", "255");
        } else if (int(getConfigurationString("graph4")) == 255) {
          configuration.setString("graph3", "0");
        }

        // Validate sensor strings length
        if (getConfigurationString("sensor1").length() > 11) {
          configuration.setString("sensor1", "");
        }

        if (getConfigurationString("sensor2").length() > 11) {
          configuration.setString("sensor2", "");
        }

        if (getConfigurationString("sensor3").length() > 11) {
          configuration.setString("sensor3", "");
        }

        if (getConfigurationString("sensor4").length() > 11) {
          configuration.setString("sensor4", "");
        }

        if (getConfigurationString("sensor5").length() > 11) {
          configuration.setString("sensor5", "");
        }

        if (getConfigurationString("sensor6").length() > 11) {
          configuration.setString("sensor6", "");
        }

        // Set text fields for hardware IP and mask
        hardwareip1.setText(getConfigurationString("hardwareip1"));
        hardwareip2.setText(getConfigurationString("hardwareip2"));
        hardwareip3.setText(getConfigurationString("hardwareip3"));
        hardwareip4.setText(getConfigurationString("hardwareip4"));
        hardwaremask1.setText(getConfigurationString("hardwaremask1"));
        hardwaremask2.setText(getConfigurationString("hardwaremask2"));
        hardwaremask3.setText(getConfigurationString("hardwaremask3"));
        hardwaremask4.setText(getConfigurationString("hardwaremask4"));
        hardwareport.setText(getConfigurationString("hardwareport"));
        serialnumber.setText(getConfigurationString("serialnumber"));
        sensor1.setText(getConfigurationString("sensor1"));
        sensor2.setText(getConfigurationString("sensor2"));
        sensor3.setText(getConfigurationString("sensor3"));
        sensor4.setText(getConfigurationString("sensor4"));
        sensor5.setText(getConfigurationString("sensor5"));
        sensor6.setText(getConfigurationString("sensor6"));

        // Update number box values
        lgmultiplier1.setValue(int(float(getConfigurationString("lgmultiplier1")) * 10000));
        lgmultiplier2.setValue(int(float(getConfigurationString("lgmultiplier2")) * 10000));
        lgmultiplier3.setValue(int(float(getConfigurationString("lgmultiplier3")) * 10000));
        lgmultiplier4.setValue(int(float(getConfigurationString("lgmultiplier4")) * 10000));
        lgmultiplier5.setValue(int(float(getConfigurationString("lgmultiplier5")) * 10000));
        lgmultiplier6.setValue(int(float(getConfigurationString("lgmultiplier6")) * 10000));
        lgspan1.setValue(int(float(getConfigurationString("lgspan1")) * 10));
        lgspan2.setValue(int(float(getConfigurationString("lgspan2")) * 10));
        lgspan3.setValue(int(float(getConfigurationString("lgspan3")) * 10));
        lgspan4.setValue(int(float(getConfigurationString("lgspan4")) * 10));
        lgspan5.setValue(int(float(getConfigurationString("lgspan5")) * 10));
        lgspan6.setValue(int(float(getConfigurationString("lgspan6")) * 10));
        lgsmooth1.setValue(int(getConfigurationString("lgsmooth1")));
        lgsmooth2.setValue(int(getConfigurationString("lgsmooth2")));
        lgsmooth3.setValue(int(getConfigurationString("lgsmooth3")));
        lgsmooth4.setValue(int(getConfigurationString("lgsmooth4")));
        lgsmooth5.setValue(int(getConfigurationString("lgsmooth5")));
        lgsmooth6.setValue(int(getConfigurationString("lgsmooth6")));
        graph1.setValue(int(getConfigurationString("graph1")));
        graph4.setValue(int(getConfigurationString("graph4")));
        temppidkp.setValue(int(getConfigurationString("temppidkp")));
        temppidki.setValue(int(getConfigurationString("temppidki")));
        temppidkd.setValue(int(getConfigurationString("temppidkd")));
        speedpidkp.setValue(int(getConfigurationString("speedpidkp")));
        speedpidki.setValue(int(getConfigurationString("speedpidki")));
        speedpidkd.setValue(int(getConfigurationString("speedpidkd")));
        hardwarelgsmooth1.setValue(int(getConfigurationString("hardwarelgsmooth1")));
        hardwarelgsmooth2.setValue(int(getConfigurationString("hardwarelgsmooth2")));
        hardwarelgsmooth3.setValue(int(getConfigurationString("hardwarelgsmooth3")));
        hardwarelgsmooth4.setValue(int(getConfigurationString("hardwarelgsmooth4")));
        hardwarelgsmooth5.setValue(int(getConfigurationString("hardwarelgsmooth5")));
        hardwarelgsmooth6.setValue(int(getConfigurationString("hardwarelgsmooth6")));
        motorspeed.setValue(int(getConfigurationString("motorspeed")));
        encoder.setValue(int(getConfigurationString("encoder")));
        motorpower.setValue(int(getConfigurationString("motorpower")));
        buffer.setValue(int(getConfigurationString("buffer")));
        baudrate.setValue(int(getConfigurationString("baudrate")));
        hardwarebaudrate.setValue(int(getConfigurationString("hardwarebaudrate")));
        hardwaresmooth.setValue(int(getConfigurationString("hardwaresmooth")));
        pidcontrolspeed.setValue(int(getConfigurationString("pidcontrolspeed")));
        pidcontroltemperature.setValue(int(getConfigurationString("pidcontroltemperature")));
        moderxtx.setValue(int(getConfigurationString("moderxtx")));

        // Color and lock adjustments for EEPROM state
        if (hexflash) {
          cleareeprom.setColorBackground(#FAC7C7);
        } else {
          cleareeprom.setColorBackground(#FFF8AA);
        }

        if (eepromst) {
          cp3.getController("input_2").setColorBackground(#FAC7C7);
          cp3.getController("input_11").setColorBackground(#FAC7C7);
          cp3.getController("input_12").setColorBackground(#FAC7C7);
          cp3.getController("input_13").setColorBackground(#FAC7C7);
          cp3.getController("input_14").setColorBackground(#FAC7C7);
          cp3.getController("input_15").setColorBackground(#FAC7C7);
          cp3.getController("input_16").setColorBackground(#FAC7C7);
          cp3.getController("input_17").setColorBackground(#FAC7C7);
          cp3.getController("input_18").setColorBackground(#FAC7C7);
          cp3.getController("input_19").setColorBackground(#FAC7C7);
          cp3.getController("input_20").setColorBackground(#FAC7C7);
          cp3.getController("input_21").setColorBackground(#FAC7C7);
          cp3.getController("input_22").setColorBackground(#FAC7C7);
          cp3.getController("input_23").setColorBackground(#FAC7C7);
          cp3.getController("input_24").setColorBackground(#FAC7C7);
          cp3.getController("input_25").setColorBackground(#FAC7C7);
          cp3.getController("input_26").setColorBackground(#FAC7C7);
          cp3.getController("input_27").setColorBackground(#FAC7C7);
          cp3.getController("input_28").setColorBackground(#FAC7C7);
          cp3.getController("input_29").setColorBackground(#FAC7C7);
          cp3.getController("input_30").setColorBackground(#FAC7C7);
          cp3.getController("input_31").setColorBackground(#FAC7C7);
          cp3.getController("input_32").setColorBackground(#FAC7C7);
          cp3.getController("input_33").setColorBackground(#FAC7C7);
          cp3.getController("input_34").setColorBackground(#FAC7C7);
          cp3.getController("speedpidkp").setColorBackground(#FAC7C7);
          cp3.getController("speedpidki").setColorBackground(#FAC7C7);
          cp3.getController("speedpidkd").setColorBackground(#FAC7C7);
          cp3.getController("temppidkp").setColorBackground(#FAC7C7);
          cp3.getController("temppidki").setColorBackground(#FAC7C7);
          cp3.getController("temppidkd").setColorBackground(#FAC7C7);
          cp3.getController("motorspeed").setColorBackground(#FAC7C7);
          cp3.getController("encoder").setColorBackground(#FAC7C7);
          cp3.getController("hardwaresmooth").setColorBackground(#FAC7C7);
          cp3.getController("pidcontrolspeed").setColorBackground(#FAC7C7);
          cp3.getController("pidcontroltemperature").setColorBackground(#FAC7C7);
          cp3.getController("moderxtx").setColorBackground(#FAC7C7);
          cp3.getController("motorpower").setColorBackground(#FAC7C7);
          cp3.getController("hardwarebaudrate").setColorBackground(#FAC7C7);
          cp3.getController("hardwareip1").setColorBackground(#FAC7C7);
          cp3.getController("hardwareip2").setColorBackground(#FAC7C7);
          cp3.getController("hardwareip3").setColorBackground(#FAC7C7);
          cp3.getController("hardwareip4").setColorBackground(#FAC7C7);
          cp3.getController("hardwaremask1").setColorBackground(#FAC7C7);
          cp3.getController("hardwaremask2").setColorBackground(#FAC7C7);
          cp3.getController("hardwaremask3").setColorBackground(#FAC7C7);
          cp3.getController("hardwaremask4").setColorBackground(#FAC7C7);
          cp3.getController("hardwareport").setColorBackground(#FAC7C7);
        } else {
          cp3.getController("input_2").setColorBackground(#FFF8AA);
          cp3.getController("input_11").setColorBackground(0xffffffff);
          cp3.getController("input_12").setColorBackground(0xffffffff);
          cp3.getController("input_13").setColorBackground(0xffffffff);
          cp3.getController("input_14").setColorBackground(0xffffffff);
          cp3.getController("input_15").setColorBackground(0xffffffff);
          cp3.getController("input_16").setColorBackground(0xffffffff);
          cp3.getController("input_17").setColorBackground(0xffffffff);
          cp3.getController("input_18").setColorBackground(0xffffffff);
          cp3.getController("input_19").setColorBackground(0xffffffff);
          cp3.getController("input_20").setColorBackground(0xffffffff);
          cp3.getController("input_21").setColorBackground(0xffffffff);
          cp3.getController("input_22").setColorBackground(0xffffffff);
          cp3.getController("input_23").setColorBackground(0xffffffff);
          cp3.getController("input_24").setColorBackground(0xffffffff);
          cp3.getController("input_25").setColorBackground(0xffffffff);
          cp3.getController("input_26").setColorBackground(0xffffffff);
          cp3.getController("input_27").setColorBackground(0xffffffff);
          cp3.getController("input_28").setColorBackground(0xffffffff);
          cp3.getController("speedpidkp").setColorBackground(0xffffffff);
          cp3.getController("speedpidki").setColorBackground(0xffffffff);
          cp3.getController("speedpidkd").setColorBackground(0xffffffff);
          cp3.getController("temppidkp").setColorBackground(0xffffffff);
          cp3.getController("temppidki").setColorBackground(0xffffffff);
          cp3.getController("temppidkd").setColorBackground(0xffffffff);
          cp3.getController("input_29").setColorBackground(#FFF8AA);
          cp3.getController("input_30").setColorBackground(#FFF8AA);
          cp3.getController("input_31").setColorBackground(#FFF8AA);
          cp3.getController("input_32").setColorBackground(#FFF8AA);
          cp3.getController("input_33").setColorBackground(#FFF8AA);
          cp3.getController("input_34").setColorBackground(#FFF8AA);
          cp3.getController("motorspeed").setColorBackground(#FFF8AA);
          cp3.getController("encoder").setColorBackground(#FFF8AA);
          cp3.getController("hardwaresmooth").setColorBackground(#FFF8AA);
          cp3.getController("pidcontrolspeed").setColorBackground(#FFF8AA);
          cp3.getController("pidcontroltemperature").setColorBackground(#FFF8AA);
          cp3.getController("moderxtx").setColorBackground(#FFF8AA);
          cp3.getController("motorpower").setColorBackground(#FFF8AA);
          cp3.getController("hardwarebaudrate").setColorBackground(#FFF8AA);
          cp3.getController("hardwareip1").setColorBackground(#FFF8AA);
          cp3.getController("hardwareip2").setColorBackground(#FFF8AA);
          cp3.getController("hardwareip3").setColorBackground(#FFF8AA);
          cp3.getController("hardwareip4").setColorBackground(#FFF8AA);
          cp3.getController("hardwaremask1").setColorBackground(#FFF8AA);
          cp3.getController("hardwaremask2").setColorBackground(#FFF8AA);
          cp3.getController("hardwaremask3").setColorBackground(#FFF8AA);
          cp3.getController("hardwaremask4").setColorBackground(#FFF8AA);
          cp3.getController("hardwareport").setColorBackground(#FFF8AA);
        }

        // License color adjustment
        if (licensec) {
          cp3.getController("input_1").setColorBackground(#D3FFD6);
        } else {
          cp3.getController("input_1").setColorBackground(#E5EA58);
        }

        cp3.getController("externalevent").setLock(!admin);

        // Lock/unlock controls based on user permissions and demo mode
        if (democ || !admin || !licensec || statusconnect) {
          cp3.getController("calibration").setLock(true);
          cp3.getController("baudrate").setLock(true);
          cp3.getController("input_2").setLock(true);
          cp3.getController("recparameters").setLock(true);
          cp3.getController("buffer").setLock(true);
        } else {
          cp3.getController("buffer").setLock(false);
          cp3.getController("calibration").setLock(false);
          cp3.getController("baudrate").setLock(false);
          cp3.getController("input_2").setLock(false);
          cp3.getController("recparameters").setLock(false);
        }

        // Set demo and calibration toggles based on conditions
        if (democ) {
          cp3.getController("demo").setValue(1);
        }

        if (RightAxis) {
          cp3.getController("calibration").setValue(1);
        }

        if (username == "SUPER_USER" || statusconnect) {
          cp3.getController("demo").setLock(true);
        } else {
          cp3.getController("demo").setLock(false);
        }

        // Lock/unlock hardware configuration fields
        hardwareip1.setLock(!eepromst);
        hardwareip2.setLock(!eepromst);
        hardwareip3.setLock(!eepromst);
        hardwareip4.setLock(!eepromst);
        hardwaremask1.setLock(!eepromst);
        hardwaremask2.setLock(!eepromst);
        hardwaremask3.setLock(!eepromst);
        hardwaremask4.setLock(!eepromst);
        hardwareport.setLock(!eepromst);
        lgmultiplier1.setLock(!admin || !RightAxis);
        lgmultiplier2.setLock(!admin || !RightAxis);
        lgmultiplier3.setLock(!admin || !RightAxis);
        lgmultiplier4.setLock(!admin || !RightAxis);
        lgmultiplier5.setLock(!admin || !RightAxis);
        lgmultiplier6.setLock(!admin || !RightAxis);
        lgspan1.setLock(!admin || !RightAxis);
        lgspan2.setLock(!admin || !RightAxis);
        lgspan3.setLock(!admin || !RightAxis);
        lgspan4.setLock(!admin || !RightAxis);
        lgspan5.setLock(!admin || !RightAxis);
        lgspan6.setLock(!admin || !RightAxis);
        lgsmooth1.setLock(!admin || !RightAxis);
        lgsmooth2.setLock(!admin || !RightAxis);
        lgsmooth3.setLock(!admin || !RightAxis);
        lgsmooth4.setLock(!admin || !RightAxis);
        lgsmooth5.setLock(!admin || !RightAxis);
        lgsmooth6.setLock(!admin || !RightAxis);
        hardwarelgsmooth1.setLock(!eepromst);
        hardwarelgsmooth2.setLock(!eepromst);
        hardwarelgsmooth3.setLock(!eepromst);
        hardwarelgsmooth4.setLock(!eepromst);
        hardwarelgsmooth5.setLock(!eepromst);
        hardwarelgsmooth6.setLock(!eepromst);
        motorspeed.setLock(!eepromst);
        motorpower.setLock(!eepromst);
        encoder.setLock(!eepromst);
        hardwaresmooth.setLock(!eepromst);
        pidcontrolspeed.setLock(!eepromst);
        pidcontroltemperature.setLock(!eepromst);
        moderxtx.setLock(!eepromst);
        cp3.getController("input_2").setLock(!eepromst);
        cp3.getController("hardwarebaudrate").setLock(!eepromst);
        cleareeprom.setLock(!hexflash);
        baudrate.setLock(statusconnect);

        if (statusconnect) {
          speedpidkp.setLock(!admin || !RightAxis);
          speedpidki.setLock(!admin || !RightAxis);
          speedpidkd.setLock(!admin || !RightAxis);
          temppidkp.setLock(!admin || !RightAxis);
          temppidki.setLock(!admin || !RightAxis);
          temppidkd.setLock(!admin || !RightAxis);
          sensor1.setLock(true);
          sensor2.setLock(true);
          sensor3.setLock(true);
          sensor4.setLock(true);
          sensor5.setLock(true);
          sensor6.setLock(true);
        } else {
          speedpidkp.setLock(true);
          speedpidki.setLock(true);
          speedpidkd.setLock(true);
          temppidkp.setLock(true);
          temppidki.setLock(true);
          temppidkd.setLock(true);
          sensor1.setLock(!admin || !RightAxis);
          sensor2.setLock(!admin || !RightAxis);
          sensor3.setLock(!admin || !RightAxis);
          sensor4.setLock(!admin || !RightAxis);
          sensor5.setLock(!admin || !RightAxis);
          sensor6.setLock(!admin || !RightAxis);
        }

        // Toggle visibility of fields based on connection status
        if (!ipcon) {
          cp3.getController("hardwareip1").hide();
          cp3.getController("hardwareip2").hide();
          cp3.getController("hardwareip3").hide();
          cp3.getController("hardwareip4").hide();
          cp3.getController("hardwaremask1").hide();
          cp3.getController("hardwaremask2").hide();
          cp3.getController("hardwaremask3").hide();
          cp3.getController("hardwaremask4").hide();
          cp3.getController("hardwareport").hide();
          cp3.getController("buffer").show();
          cp3.getController("baudrate").show();
          cp3.getController("hardwarebaudrate").show();
        } else {
          cp3.getController("buffer").hide();
          cp3.getController("baudrate").hide();
          cp3.getController("hardwarebaudrate").hide();
          cp3.getController("hardwareip1").show();
          cp3.getController("hardwareip2").show();
          cp3.getController("hardwareip3").show();
          cp3.getController("hardwareip4").show();
          cp3.getController("hardwaremask1").show();
          cp3.getController("hardwaremask2").show();
          cp3.getController("hardwaremask3").show();
          cp3.getController("hardwaremask4").show();
          cp3.getController("hardwareport").show();
        }

        // Handle license field focus and lock
        if (statusconnect) {
          license.setFocus(false);
          license.setLock(true);
        } else {
          license.setLock(!admin);
        }

        cp3.getController("manager").setLock(!admin || authenticationwindows);

        if (isWindowFocused2 == true) {
          ontopsett = false;
        }

        cp3.draw();
      }
    }

    if (modevisible2 == 1) {
      surface.setVisible(!login);
      modevisible2 = 0;
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
    }

    if (key == CODED) {

      if (keyCode == ALT) {
        iscontrol = true;
      }

      // Handle function key presses for special operations
      if (keyCode == java.awt.event.KeyEvent.VK_F7) {
        if (int(getConfigurationString("fnkey")) == 0) {
          cp3.getController("fnkey").setValue(1);
        } else {
          cp3.getController("fnkey").setValue(0);
        }
      }

      if (keyCode == java.awt.event.KeyEvent.VK_F1) {
        Manual();
      }

      if (int(getConfigurationString("fnkey")) == 1) {

        if (keyCode == java.awt.event.KeyEvent.VK_F2 && admin && hexflash) {
          if (cleeprom) {
            cleareeprom.setValue(0);
          } else {
            cleareeprom.setValue(1);
          }
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F3 && admin && eepromst) {
          if (int(getConfigurationString("moderxtx")) == 1) {
            moderxtx.setValue(0);
          } else {
            moderxtx.setValue(1);
          }
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F4 && admin && !authenticationwindows) {
          cp3.getController("manager").setValue(1);
        }

        if (!RightAxis && !statusconnect && keyCode == java.awt.event.KeyEvent.VK_F5) {
          cp3.getController("demo").setValue(democ ? 0 : 1);
        }

        if (!democ && admin && !statusconnect && keyCode == java.awt.event.KeyEvent.VK_F6 && !RightAxis) {
          cp3.getController("calibration").setValue(1);
        }

        if (admin && keyCode == java.awt.event.KeyEvent.VK_F8) {
          cp3.getController("externalevent").setValue(!externevent ? 1 : 0);
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F9 && admin && !statusconnect && !democ) {
          if (int(getConfigurationString("recparameters")) == 1) {
            recparameters.setValue(0);
          } else {
            recparameters.setValue(1);
          }
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F10 && admin && eepromst) {
          if (int(getConfigurationString("hardwaresmooth")) == 1) {
            hardwaresmooth.setValue(0);
          } else {
            hardwaresmooth.setValue(1);
          }
        }


        if (keyCode == java.awt.event.KeyEvent.VK_F11 && admin && eepromst) {
          if (int(getConfigurationString("pidcontroltemperature")) == 1) {
            pidcontroltemperature.setValue(0);
          } else {
            pidcontroltemperature.setValue(1);
          }
        }

        if (keyCode == java.awt.event.KeyEvent.VK_F12 && admin && eepromst) {
          if (int(getConfigurationString("pidcontrolspeed")) == 1) {
            pidcontrolspeed.setValue(0);
          } else {
            pidcontrolspeed.setValue(1);
          }
        }
      }
    }

    if (admin && key == TAB) {
      if (RightAxis) {
        for (temp = 1; temp == isize; temp++) {
          Textfield tfTemp = (Textfield) cp3.getController("input_" + temp);
          if (tfTemp.isFocus() == true) {
            irty = temp;
          }
        }

        Textfield tf1 = (Textfield) cp3.getController("input_" + irty);
        irty = irty == isize ? 2 : irty + 1;
        Textfield tf0 = (Textfield) cp3.getController("input_" + irty);
        license.setFocus(false);
        tf1.setFocus(false);
        tf0.setFocus(true);
      } else {
        license.setFocus(true);
      }
    }
  }

  // Placeholder methods for graph and input field events
  void graph1(int f) {
  }
  void graph2(int f) {
  }
  void graph3(int f) {
  }
  void graph4(int f) {
  }
  void graph5(int f) {
  }
  void graph6(int f) {
  }
  void input_11(int f) {
  }
  void input_12(int f) {
  }
  void input_13(int f) {
  }
  void input_14(int f) {
  }
  void input_15(int f) {
  }
  void input_16(int f) {
  }
  void input_17(int f) {
  }
  void input_18(int f) {
  }
  void input_19(int f) {
  }
  void input_20(int f) {
  }
  void input_21(int f) {
  }
  void input_22(int f) {
  }
  void input_23(int f) {
  }
  void input_24(int f) {
  }
  void input_25(int f) {
  }
  void input_26(int f) {
  }
  void input_27(int f) {
  }
  void input_28(int f) {
  }
  void input_29(int f) {
  }
  void input_30(int f) {
  }
  void input_31(int f) {
  }
  void input_32(int f) {
  }
  void input_33(int f) {
  }
  void input_34(int f) {
  }
  void speedpidkp(int f) {
  }
  void speedpidki(int f) {
  }
  void speedpidkd(int f) {
  }
  void temppidkp(int f) {
  }
  void temppidki(int f) {
  }
  void temppidkd(int f) {
  }
  void motorspeed(int f) {
  }
  void encoder(int f) {
  }
  void motorpower(int f) {
  }
  void baudrate(int f) {
  }
  void hardwarebaudrate(int f) {
  }
  void buffer(int f) {
  }

  // EEPROM clear toggle handler
  void cleareeprom(boolean theFlag) {
    cleeprom = theFlag;
  }

  // Demo mode toggle handler
  public void demo(boolean theFlag) {
    if (!statusconnect) {
      if (!theFlag) {
        if (ptr == 1) ptr = 0;
        setparameterscale = 1;
        democ = false;
        avg[0] = avg[1] = avg[2] = avg[3] = avg[4] = avg[5] = 0;
        avgr[0] = avgr[1] = avgr[2] = avgr[3] = avgr[4] = avgr[5] = avgr[6] = avgr[7] = 0;
      } else if (theFlag) {
        if (ptr == 0) {
          ptr = 1;
          setparameterscale = 1;
        }
        democ = true;
      }
    }
  }

  // Manager window handler
  void manager() {
    if (isAdmin()) {
      windowslogin.show();
    } else {
      windowslogin.hide();
    }
    createusermain();
  }

  // Calibration mode toggle handler
  public void calibration(boolean theFlag) {
    if (theFlag) {
      RightAxis = true;
      atsv.setValue(1);
      cp1.getController("eeprom").setLock(statusconnect);
      if (eepromst == true) {
        cp1.getController("eeprom").setValue(1);
      }

      if (dotb == 1) {
        logEvent(" - Login performed. // User = SUPER_USER");

        username = "SUPER_USER";
        admin = true;
        cp3.getController("demo").setValue(0);
        mode = " - Calibration";
        dotb = 0;
      }
    }
  }

  // External event toggle handler
  void externalevent(boolean theFlag) {
    externevent = theFlag;
  }

  // Mode toggle handler for serial/USB
  void moderxtx(boolean theFlag) {
    configuration.setString("moderxtx", theFlag ? "1" : "0");
  }

  // PID control toggle handler for speed
  void pidcontrolspeed(boolean theFlag) {
    configuration.setString("pidcontrolspeed", theFlag ? "1" : "0");
  }

  // PID control toggle handler for temperature
  void pidcontroltemperature(boolean theFlag) {
    configuration.setString("pidcontroltemperature", theFlag ? "1" : "0");
  }

  // Hardware smoothing toggle handler
  void hardwaresmooth(boolean theFlag) {
    configuration.setString("hardwaresmooth", theFlag ? "1" : "0");
  }

  // Save parameters toggle handler
  void saveparameters(boolean theFlag) {
    configuration.setString("saveparameters", theFlag ? "1" : "0");
  }

  // Function key toggle handler
  void fnkey(boolean theFlag) {
    configuration.setString("fnkey", theFlag ? "1" : "0");
  }

  // Function for drawing a text box with title and contents
  void Drawcontour_outer_Settings(int x, int y, int w, int h) {
    fill(int(getConfigurationString("graph5")));
    stroke(30);
    strokeWeight(0.5);
    rect(x, y, w, h, 20);
    noFill();
    noStroke();
  }

  // Function for drawing a text box with title and contents
  void Drawcontour_inner_Settings(int x, int y, int w, int h) {
    fill(205);
    stroke(240);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
    noFill();
    noStroke();
  }

  // Control event handler for updating configuration based on GUI interactions
  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class) || theEvent.isAssignableFrom(Numberbox.class)) {
      String value = theEvent.getValue() + "";

      switch (theEvent.getName()) {
      case "graph1":
      case "graph2":
      case "graph3":
      case "graph4":
      case "graph5":
      case "graph6":
        configuration.setString(theEvent.getName(), value);
        break;

      case "input_11":
      case "input_12":
      case "input_13":
      case "input_14":
      case "input_15":
      case "input_16":
        configuration.setString("lgmultiplier" + (Integer.parseInt(theEvent.getName().substring(6)) - 10), str(Float.parseFloat(value) / 10000));
        break;

      case "input_17":
      case "input_18":
      case "input_19":
      case "input_20":
      case "input_21":
      case "input_22":
        configuration.setString("lgspan" + (Integer.parseInt(theEvent.getName().substring(6)) - 16), str(Float.parseFloat(value) / 10));
        break;

      case "input_23":
      case "input_24":
      case "input_25":
      case "input_26":
      case "input_27":
      case "input_28":
        configuration.setString("lgsmooth" + (Integer.parseInt(theEvent.getName().substring(6)) - 22), value);
        break;

      case "speedpidkp":
      case "speedpidki":
      case "speedpidkd":
      case "temppidkp":
      case "temppidki":
      case "temppidkd":
        configuration.setString(theEvent.getName(), value);
        break;

      case "input_29":
      case "input_30":
      case "input_31":
      case "input_32":
      case "input_33":
      case "input_34":
        configuration.setString("hardwarelgsmooth" + (Integer.parseInt(theEvent.getName().substring(6)) - 28), value);
        break;

      case "encoder":
      case "motorspeed":
      case "motorpower":
      case "buffer":
      case "baudrate":
      case "hardwarebaudrate":
        configuration.setString(theEvent.getName(), value);
        break;

      case "fnkey":
      case "recparameters":
      case "externalevent":
        configuration.setString(theEvent.getName(), value);
        break;
      }
    }
  }

  PApplet parent; // Reference to the parent PApplet

  // Exit method for stopping and disposing of the applet
  void exit() {
    delay(500);
    cp3 = null;
    winsetting = null;
    this.stop();
    this.dispose();
  }
}
