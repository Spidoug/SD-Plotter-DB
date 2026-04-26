/*  //////////////////////////////////////////////////////////////////SD PLOTTER DB® VERSION 3.00 - PROGRAM/////////////////////////////////////////////////////////////////////////
 
 SOFTWARE DEVELOPED BY DOUGLAS SANTANA DA SILVA
 CONTACT EMAIL: SPIDOUG@GMAIL.COM
 
 THIS PROGRAM HAS THE CAPABILITY OF MONITORING AND CONTROLLING SIGNALS FROM A MICROCONTROLLER WITH DEDICATED FIRMWARE AND EXCLUSIVE COMMUNICATION PROTOCOL.
 */

// Import libraries for various functionalities

//_____________________________________________________ Build
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.BufferedOutputStream;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.StringReader;
import java.io.Writer;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Properties;
import java.util.Enumeration;
import java.util.*;
import java.util.prefs.Preferences;
import java.awt.Desktop;
import java.awt.Window;
import java.awt.Frame;
import java.awt.event.WindowEvent;
import java.awt.event.WindowFocusListener;

//_____________________________________________________ Panel
import processing.awt.PSurfaceAWT;

//_____________________________________________________ SQL
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLSyntaxErrorException;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.Blob;
import org.apache.derby.drda.NetworkServerControl;

//_____________________________________________________ Encrypted
import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.security.*;
import java.io.*;
import java.util.Base64;

//_____________________________________________________ Controls
import controlP5.*;

//_____________________________________________________ Serial module
import processing.serial.Serial;

//_____________________________________________________ MD5 for password
import java.security.MessageDigest;

//_____________________________________________________ Delete file
import java.io.File;

//_____________________________________________________ Networking controls
static NetworkServerControl server;

//_____________________________________________________ Graph controls
import grafica.*;

Connection conn;
Statement stmt;
ResultSet rset;

String dirResources = null;

PrintWriter exp;
PrintWriter hexfile;

/* SETTINGS END */

// Filename filter for text files
java.io.FilenameFilter txtFilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith("");
  }
};

// Function to check if the user is an admin
boolean isAdmin() {
  try {
    Process process = Runtime.getRuntime().exec("cmd /c net session");
    process.waitFor();
    int exitValue = process.exitValue();
    return (exitValue == 0);
  }
  catch (Exception e) {
    e.printStackTrace();
    return false; // Exception handling
  }
}

// Booleans for various states and flags
boolean mockupSerial = true;
boolean statusconnect = false;
boolean statusstartrec = false;
boolean reccontrol = false;
boolean startcontrol = false;
boolean Viewgraph = true;
boolean statusdb = false;
boolean statusok = false;
boolean licensec = false;
boolean ShowMouseLines = false;  // Draw lines and give values of the mouse position
boolean RightAxis = false;       // Draw the next graph using the right axis if true
boolean modeunit = false;
boolean democ = false;
boolean admin = true;
boolean login = true;
boolean modelogin = true;
boolean autoscale = false;
boolean isTabPressed = false;
boolean eepromst = false;
boolean externevent = false;
boolean hexflash = false;
boolean openmt = true;
boolean cleeprom = false;
boolean deletemt = true;
boolean tplock = true;
boolean mtlock = true;
boolean iscontrol = false;
boolean ipcon = true;
boolean refreshdatadisplay = false;
boolean refreshmethod = false;
boolean authenticationwindows = false;
boolean ontopsett = false;
boolean ontopcont = false;
boolean ontopdat = false;
boolean windowdisplayshow = false;
boolean isWindowFocused0 = true;

// Strings for various purposes
String activeTab = "Tab1";
String serialPortName = "/dev/tty.SDPlotter";
String dataout  = "";
String namespec  = "";
String datamoment  = "";
String datafilemethod  = "";
String oldlogs = "";
String status_on = "Not connected";
String timesh = "ms";
String dataoutexp = "";
String status_rec = "           Stop";
String status_met = "           Stop";
String mode = "";
String valueps;
String clipboarddt = "";
String mainKey = "/sdplotterdb";
String window1 = "";
String window2 = "";
String window3 = "SD Plotter DB® - Login";
String window4 = "";
String datainfo = "";
String statusoperation = "";
String keyoutopen = "";
String xcode = "";
String Userinfo = "";
String Systeminfo = " Press F1 for help";
String derty = "";
String laststatus_on = "";
String methodout = "";
String datasout = "";
String myString = "";
String out = "SDPlotterDB";
String rev = "3.00";
String localmanual = "/manual/Instruction Manual - SD PLOTTER DB.pdf";
String userid = null;
String passwordid = null;
String numberfile = null;
String username = null;
String pointer = null;
String folderPath = null;
String datamomentsnap = "";
String infopc = "";
String plust = "";
String hardwarehex = null;
String firmwareclearhex = null;
String firmwarestdhex = null;
String baudratehex = null;
String a1 = null;
String a2 = null;
String a3 = null;
String a4 = null;
String a5 = null;
String a6 = null;
String a10 = "";
String ut0 = "";
String ut1 = "";
String ut2 = "";
String ut3 = "";
String ut4 = "";
String ut5 = "";
String ut6 = "";
String keys = "5982465378194658";
String filename = null;
String pairsectvl;
String passwordsql = null;
String titledatadisplay = null;
String userdatadisplay = null;
String machinecodedatadisplay = null;
String serialdatadisplay =  null;
String timeshdat1 = ""; // Time data string
String timeshdat2 = ""; // Time data string

// Arrays of strings
String[] properties = null;
String[] oldlog = null;
String[] dbstart = null;
String[] valuesArray = {""};
String[] Values = null;
String[] settingsdatadisplay = null;
String[] timesdatadisplay = null;
String[] probes = null;
String[] units = null;
String[] linesdata = null;
String[] Datestimesstart = null;
String[] cmd = {"cmd", "/c", "wmic csproduct get uuid"};
String[] raw = null;
String[] rawvalues = null;
String[] fileNames = {""};
String[] myStringsmet = null;

// Floats for various purposes
float regpair = 0;
float scaleu = 0;
float scalel = 0;
float scaleub = 0;
float scalelb = 0;
float torqueout = 0;
float timeshsel = 0;
float tptemp = 0;
float prevMillis = 0;
float timeshseldat = 0; // Selected time data
float[] xLimAutoscale; // Autoscale limits for X
float[] yLimAutoscale; // Autoscale limits for Y
float[] yreal; // Real Y values

// Integers for various purposes
int mttemp = 0;
int selectedItemIndex = 0;
int modemanageruser = 0;
int wait = 200, lastTime = -wait;
int valrel = 0;
int setparametersdata = 0;
int setparameterscale = 1;
int keyinopen = 0;
int a = 0;
int b = 0;
int c = 0;
int d = 0;
int timesmooth = 0;
int prevMillisds;
int prevMilliscn;
int imet = 0;
int millisecs1 = 0;
int seconds1 = 0;
int minutes1 = 0;
int hour1 = 0;
int day1 = 0;
int millisecs2 = 0;
int seconds2 = 0;
int minutes2 = 0;
int hour2 = 0;
int day2 = 0;
int numberbt = 0;
int tret = 0;
int modevisible0 = 0;
int modevisible1 = 0;
int modevisible2 = 0;
int modevisible3 = 0;
int modevisible4 = 0;
int normaliz = 0;
int ptr = 1;
int irtyr = 1;
int isizer = irtyr;
int tempr = 0;
int numLinesmethod = 0;
int numLinesdatadisplay = 0;    // Number of lines in the file
int sizefl = 0; // Variable for size
int waitdatadd = 200, lastTimedatadd = -waitdatadd; // Timing variables
int selectgh = 2; // Selected graph
int maxDisplayPoints = 15000; //
int i = 0; // loop variable

int lastTimeUpdate_cr = 0;
int timePerRecord_cr = 500;
int lastTimeUpdate_pl = 0;
int timePerRecord_pl = 500;
int lastTimeUpdate_dt = 0;
float timePerRecord_dt = 1000;

// Start once time
int dotb = 0;
int dotr = 0;
int doty = 0;
int dotp = 0;
int dotpu = 0;
int dotre = 0;
int dotrwe = 0;

int primaryX = 0;
int primaryY = 0;

// Arrays of ints and floats
int[] scale = {1000, 1000, 1000, 1000, 1000, 1000};  // alpha = 1/2^beta
float[] avg = {0, 0, 0, 0, 0, 0};
float[] avgr = {0, 0, 0, 0, 0, 0, 0, 0};
float[] avgrt = {0, 0, 0, 0, 0, 0, 0, 0};
float[] k = {1000, 1000, 1000, 1000, 1000, 1000};

// Byte array
byte[] inBuffer = new byte[1000]; // holds serial message
// JSON Objects and Arrays
JSONObject configuration;
JSONObject idlist;
JSONObject scalegraph;
JSONArray usersid;
JSONArray vld;

// Plots
Graph BarChart = new Graph(238, 76, 585, 170, color(50, 20, 20), false);
Graph LineGraph = new Graph(238, 363, 585, 170, color(50, 20, 20), true);
float[] barChartValues = new float[8];
float[][] lineGraphValues;
float[] lineGraphSampleNumbers;
color[] graphColors = new color[9];

// Helper for saving the executing path
String topSketchPath = "";

// Serial
Serial serialPort = null;        // the serial port
String serial_list = "";         // list of serial ports
int serial_list_index = 0;       // currently selected serial port
int num_serial_ports = 0;        // number of serial ports in the list

// Image
PImage logo;

ControlP5 cp1;
ControlP5 cp2;
ControlP5 cp3;
ControlP5 cp4;
ControlP5 cp5;
ControlP5 cp6;
ControlP5 cp7;

PWindowcl wincontrol;
PWindowcnd wincondition;
PWindowl winlogin;
PWindowd windatabase;
PWindows winsetting;
PWindowc winclose;

// User interface variables
Textfield user;
Textfield password;
Textfield license;
Textfield serialnumber;
Textfield hardwareip1;
Textfield hardwareip2;
Textfield hardwareip3;
Textfield hardwareip4;
Textfield hardwaremask1;
Textfield hardwaremask2;
Textfield hardwaremask3;
Textfield hardwaremask4;
Textfield hardwareport;
Textfield torque;
Textfield controltemp;
Textfield controltempmin;
Textfield sensor1;
Textfield sensor2;
Textfield sensor3;
Textfield sensor4;
Textfield sensor5;
Textfield sensor6;
Textfield mtcd1;
Textfield mtcd2;
Textfield unit1;
Textfield unit2;
Textfield unit3;
Textfield unit4;
Textfield unit5;
Textfield unit6;
Textfield unit7;
Textfield unit8;

Numberbox n;
Numberbox l;
Numberbox m;
Numberbox p;
Numberbox lgmultiplier1;
Numberbox lgmultiplier2;
Numberbox lgmultiplier3;
Numberbox lgmultiplier4;
Numberbox lgmultiplier5;
Numberbox lgmultiplier6;
Numberbox lgspan1;
Numberbox lgspan2;
Numberbox lgspan3;
Numberbox lgspan4;
Numberbox lgspan5;
Numberbox lgspan6;
Numberbox lgsmooth1;
Numberbox lgsmooth2;
Numberbox lgsmooth3;
Numberbox lgsmooth4;
Numberbox lgsmooth5;
Numberbox lgsmooth6;
Numberbox graph1;
Numberbox graph4;
Numberbox speedpidkp;
Numberbox speedpidki;
Numberbox speedpidkd;
Numberbox temppidkp;
Numberbox temppidki;
Numberbox temppidkd;
Numberbox hardwarelgsmooth1;
Numberbox hardwarelgsmooth2;
Numberbox hardwarelgsmooth3;
Numberbox hardwarelgsmooth4;
Numberbox hardwarelgsmooth5;
Numberbox hardwarelgsmooth6;
Numberbox motorspeed;
Numberbox encoder;
Numberbox motorpower;
Numberbox buffer;
Numberbox baudrate;
Numberbox hardwarebaudrate;

Textfield ip1;
Textfield ip2;
Textfield ip3;
Textfield ip4;
Textfield directory;

Textarea myTextarea;
Textarea myTextareadata;

Toggle cleareeprom;
Toggle moderxtx;
Toggle recparameters;
Toggle hardwaresmooth;
Toggle pidcontrolspeed;
Toggle pidcontroltemperature;
Toggle Tfocus1;
Toggle Tfocus2;
Toggle Tfocus3;
Toggle Tfocus4;
Toggle Tfocus5;
Toggle Tfocus6;
Toggle Tfocus7;
Toggle Tfocus8;
Toggle relay1;
Toggle relay2;
Toggle dout1;
Toggle dout2;
Toggle atsv;
Toggle startrecb;
Toggle startcontrolb;
Toggle reccontrolb;

Tab tab_main, tab_display;

ScrollableList initialBodyList;

Knob knob1;
Knob knob2;

Slider slider1;
Slider slider2;

Button downuser;
Button upuser;
Button cancel;
Button ok;
Button deletedtbt;
Button opendtbt;
Button createuser;
Button deleteuser;
Button administrator;
Button windowslogin;

// GPlot instances for different plots
GPlot plot1;
GPlot plot2;
GPlot plot3;
GPlot plot4;
GPlot plot5;
GPlot plot6;
GPlot plot7;
GPlot plot8;

GPlot plot11;

// Arrays for graph data display
GPointsArray graph1datadisplay = new GPointsArray();
GPointsArray graph2datadisplay = new GPointsArray();
GPointsArray graph3datadisplay = new GPointsArray();
GPointsArray graph4datadisplay = new GPointsArray();
GPointsArray graph5datadisplay = new GPointsArray();
GPointsArray graph6datadisplay = new GPointsArray();
GPointsArray graph7datadisplay = new GPointsArray();
GPointsArray graph8datadisplay = new GPointsArray();
GPointsArray graph9datadisplay = new GPointsArray();

void setup() {

  java.awt.Frame winmain = (java.awt.Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
  primaryX = winmain.getX();
  primaryY = winmain.getY();

  winlogin = new PWindowl(primaryX, primaryY);

  surface.setVisible(!modelogin);

  smooth(2);
  surface.setTitle("SD Plotter DB®");
  size(1190, 600);
  topSketchPath = sketchPath();

  // set line graph colors
  graphColors[0] = color(255, 0, 0);
  graphColors[1] = color(216, 143, 46);
  graphColors[2] = color(224, 202, 0);
  graphColors[3] = color(0, 211, 86);
  graphColors[4] = color(105, 120, 255);
  graphColors[5] = color(255, 0, 252);
  graphColors[6] = color(255, 23, 151);
  graphColors[7] = color(255, 149, 171);
  graphColors[8] = color(152, 152, 152);

  final Frame frame = (Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
  frame.addWindowFocusListener(new WindowFocusListener() {
    @Override
      public void windowGainedFocus(WindowEvent e) {
      isWindowFocused0 = true;
    }

    @Override
      public void windowLostFocus(WindowEvent e) {
      isWindowFocused0 = false;
    }
  }
  );

  // Read the JSON object from the registry
  readJsonFromRegistry(mainKey, "Settings");

  try {
    String encryptedTextBase64 = join(loadStrings(topSketchPath + "/log.dat"), "\n");
    byte[] encryptedText = Base64.getDecoder().decode(encryptedTextBase64);

    SecretKeySpec secretKey = new SecretKeySpec(keys.getBytes(), "AES");
    Cipher cipher = Cipher.getInstance("AES");
    cipher.init(Cipher.DECRYPT_MODE, secretKey);

    byte[] decryptedText = cipher.doFinal(encryptedText);
    oldlogs = new String(decryptedText);
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  // Log the startup event
  logEvent(" - Started the software.");

  logo = loadImage(topSketchPath + "/lib/src/sdplotterdb.png");
  infopc = executeCommand(cmd);

  Machinecode();

  if (int(configuration.getString("winlogin")) == 1) {
    authenticationwindows = true;
  }

  scalegraph = new JSONObject();
  scalegraph.setString("uppergraph", "5");
  scalegraph.setString("uppergraphb", "5");
  scalegraph.setString("lowergraph", "-5");
  scalegraph.setString("lowergraphb", "-5");
  scalegraph.setString("gpbr", "0.01");
  scalegraph.setString("gpct", "0.01");
  scalegraph.setString("div", "5");
  scalegraph.setString("autoscale", "1");
  scalegraph.setString("marker", "1");

  // Initializing plots
  plot1 = new GPlot(this);
  plot2 = new GPlot(this);
  plot3 = new GPlot(this);
  plot4 = new GPlot(this);
  plot5 = new GPlot(this);
  plot6 = new GPlot(this);
  plot7 = new GPlot(this);
  plot8 = new GPlot(this);

  plot11 = new GPlot(this);

  // Build the GUI (images)
  PImage[] Connect = loadImages("/lib/src/connect_a.png", "/lib/src/connect_b.png", "/lib/src/connect_c.png");
  PImage[] Disconnect = loadImages("/lib/src/disconnect_a.png", "/lib/src/disconnect_b.png", "/lib/src/disconnect_c.png");
  PImage[] Refresh = loadImages("/lib/src/refresh_a.png", "/lib/src/refresh_b.png", "/lib/src/refresh_c.png");
  PImage[] Up = loadImages("/lib/src/up_a.png", "/lib/src/up_b.png", "/lib/src/up_c.png");
  PImage[] Down = loadImages("/lib/src/down_a.png", "/lib/src/down_b.png", "/lib/src/down_c.png");
  PImage[] Login = loadImages("/lib/src/login_a.png", "/lib/src/login_b.png", "/lib/src/login_c.png");
  PImage[] Control = loadImages("/lib/src/control_a.png", "/lib/src/control_b.png", "/lib/src/control_c.png");
  PImage[] Marker = loadImages("/lib/src/marker_a.png", "/lib/src/marker_b.png", "/lib/src/null_a.png");
  PImage[] Settings = loadImages("/lib/src/settings_a.png", "/lib/src/settings_b.png", "/lib/src/settings_c.png");
  PImage[] Rec = loadImages("/lib/src/rec_a.png", "/lib/src/stop_b.png", "/lib/src/null_a.png");
  PImage[] Startcontrol = loadImages("/lib/src/start_a.png", "/lib/src/stop_b.png", "/lib/src/null_a.png");
  PImage[] Reccontrol = loadImages("/lib/src/rec_a.png", "/lib/src/stop_b.png", "/lib/src/null_a.png");
  PImage[] Unit = loadImages("/lib/src/raw_a.png", "/lib/src/unit_a.png", "/lib/src/null_a.png");
  PImage[] Database = loadImages("/lib/src/database_a.png", "/lib/src/database_b.png", "/lib/src/database_c.png");
  PImage[] Autoscale = loadImages("/lib/src/autoscale_a.png", "/lib/src/autoscale_b.png", "/lib/src/null_a.png");
  PImage[] Eeprom = loadImages("/lib/src/eeprom_a.png", "/lib/src/eeprom_b.png", "/lib/src/null_a.png");
  PImage[] Hex = loadImages("/lib/src/hex_a.png", "/lib/src/hex_b.png", "/lib/src/null_a.png");
  PImage[] Exportdata = loadImages("/lib/src/export_a.png", "/lib/src/export_b.png", "/lib/src/export_c.png");

  cp1 = new ControlP5(this);
  cp1.setAutoDraw(false);

  cp1.getTab("default").remove();

  tab_main = cp1.addTab("main")
    .setLabel("Analysis")
    .setColorBackground(color(160, 160, 160))
    .setColorForeground(color(82, 82, 82))
    .setColorActive(color(211, 211, 211));

  tab_main.getCaptionLabel().setFont(createFont("Georgia", 9, true));

  tab_display = cp1.addTab("display")
    .setLabel("Data Display")
    .setColorBackground(color(160, 160, 160))
    .setColorForeground(color(82, 82, 82))
    .setColorActive(color(211, 211, 211)).hide();

  tab_display.getCaptionLabel().setFont(createFont("Georgia", 9, true));

  cp1.getTab("main").bringToFront();

  cp1.addTextlabel("visible")
    .setText("On/Off")
    .setPosition(28, 324)
    .setFont(createFont("Georgia", 8))
    .setColor(#050505)
    .moveTo(tab_main);

  cp1.addTextlabel("Unit")
    .setText("Unit")
    .setPosition(91, 323)
    .setFont(createFont("Georgia", 10))
    .setColor(#050505)
    .moveTo(tab_main);

  Tfocus1 = cp1.addToggle("lgvisible1")
    .setLabel("Probe 1")
    .setPosition(30, 342)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible1")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[0])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus2 = cp1.addToggle("lgvisible2")
    .setLabel("Probe 2")
    .setPosition(30, 372)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible2")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[1])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus3 = cp1.addToggle("lgvisible3")
    .setLabel("Probe 3")
    .setPosition(30, 402)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible3")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[2])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus4 = cp1.addToggle("lgvisible4")
    .setLabel("Probe 4")
    .setPosition(30, 432)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible4")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[3])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus5 = cp1.addToggle("lgvisible5")
    .setLabel("Probe 5")
    .setPosition(30, 462)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible5")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[4])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus6 = cp1.addToggle("lgvisible6")
    .setLabel("Probe 6")
    .setPosition(30, 492)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible6")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[5])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus7 = cp1.addToggle("lgvisible7")
    .setLabel("Probe 7")
    .setPosition(30, 522)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible7")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[6])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  Tfocus8 = cp1.addToggle("lgvisible8")
    .setLabel("Probe 8")
    .setPosition(30, 552)
    .setSize(30, 8)
    .setFont(createFont("Georgia", 8))
    .setValue(int(getConfigurationString("lgvisible8")))
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(graphColors[7])
    .setColorBackground(0xffffffff)
    .setColorForeground(0xffffffff)
    .moveTo(tab_main);

  unit1 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 342)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit1"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[0])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit2 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 372)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit2"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[1])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit3 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 402)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit3"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[2])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit4 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 432)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit4"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[3])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit5 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 462)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit5"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[4])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit6 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(95, 492)
    .setSize(20, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit6"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[5])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit7 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 522)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit7"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[6])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  irtyr++;

  unit8 = cp1.addTextfield("inputs_" + irtyr)
    .setLabel("")
    .setPosition(85, 552)
    .setSize(40, 20)
    .setFont(createFont("Georgia", 10))
    .setText(getConfigurationString("unit8"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(0xffffffff)
    .setColorForeground(graphColors[7])
    .setColor(40)
    .updateSize()
    .setColorActive(0x00000000)
    .setColorCursor(0)
    .moveTo(tab_main);
  isizer = irtyr;
  irtyr = 1;

  cp1.addButton("up")
    .setPosition(1017, 37)
    .setImages(Up)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("down")
    .setPosition(1017, 67)
    .setImages(Down)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("connect")
    .setPosition(1058, 38)
    .setImages(Connect)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("disconnect")
    .setPosition(1058, 73)
    .setImages(Disconnect)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("refresh")
    .setPosition(1058, 108)
    .setValue(0)
    .setImages(Refresh)
    .updateSize()
    .moveTo(tab_main);

  Drawcontourx(16, 145, 120, 25);

  cp1.addToggle("eeprom")
    .setSize(1, 1)
    .setPosition(25, 149)
    .setImages(Eeprom)
    .updateSize()
    .hide()
    .moveTo(tab_main);

  cp1.addToggle("savehex")
    .setSize(1, 1)
    .setPosition(79, 149)
    .setImages(Hex)
    .updateSize()
    .hide().moveTo(tab_main);

  startcontrolb = cp1.addToggle("startcontrol")
    .setValue(false)
    .setPosition(1057, 323)
    .setSize(40, 40)
    .setImages(Startcontrol)
    .updateSize().moveTo(tab_main);

  reccontrolb = cp1.addToggle("reccontrol")
    .setValue(false)
    .setPosition(1113, 323)
    .setSize(40, 40)
    .setImages(Reccontrol)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("control")
    .setPosition(917, 332)
    .setImages(Control)
    .updateSize()
    .moveTo(tab_main);

  startrecb = cp1.addToggle("startrec")
    .setPosition(1113, 463)
    .setImages(Rec)
    .updateSize()
    .moveTo(tab_main);

  cp1.addToggle("unit")
    .setPosition(1057, 463)
    .setValue(1)
    .setImages(Unit)
    .updateSize()
    .moveTo(tab_main);

  cp1.addNumberbox("savedata")
    .setSize(45, 20)
    .setValue(float(getConfigurationString("savedata")))
    .setRange(0.5, 1000)
    .setPosition(947, 488)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(0xffffffff)
    .setColorForeground(0x00000000)
    .setFont(createFont("Georgia", 9))
    .setMultiplier(-0.01)
    .moveTo(tab_main);

  cp1.addToggle("marker")
    .setSize(1, 1)
    .setPosition(264, 557)
    .setValue(int(getScaleString("marker")))
    .setImages(Marker)
    .updateSize()
    .moveTo(tab_main);

  atsv = cp1.addToggle("autoscale")
    .setSize(1, 1)
    .setPosition(320, 557)
    .setValue(int(getScaleString("autoscale")))
    .setImages(Autoscale)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("login")
    .setPosition(24, 38)
    .setImages(Login)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("database")
    .setPosition(24, 73)
    .setImages(Database)
    .updateSize()
    .moveTo(tab_main);

  cp1.addButton("settingssd")
    .setPosition(24, 108)
    .setImages(Settings)
    .updateSize()
    .moveTo(tab_main);

  m = cp1.addNumberbox("uppergraphb")
    .setValue(float(getScaleString("uppergraphb")))
    .setSize(70, 20)
    .setRange(0.01, 999999)
    .setPosition(176, 35)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0x00000000)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0)
    .moveTo(tab_main);

  p = cp1.addNumberbox("lowergraphb")
    .setValue(float(getScaleString("lowergraphb")))
    .setSize(70, 20)
    .setRange(-999999, -0.01)
    .setPosition(176, 268)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0).moveTo(tab_main);

  n = cp1.addNumberbox("uppergraph")
    .setValue(float(getScaleString("uppergraph")))
    .setSize(70, 20)
    .setRange(-999999, 999999)
    .setPosition(176, 321)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0)
    .moveTo(tab_main);

  l = cp1.addNumberbox("lowergraph")
    .setValue(float(getScaleString("lowergraph")))
    .setSize(70, 20)
    .setRange(-999999, 999999)
    .setPosition(176, 554)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0)
    .moveTo(tab_main);

  cp1.addNumberbox("ratesampling")
    .setValue(int(getConfigurationString("ratesampling")))
    .setSize(50, 20)
    .setRange(10, 1820)
    .setPosition(567, 554)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setMultiplier(-5)
    .moveTo(tab_main);

  cp1.addNumberbox("gpbr")
    .setSize(52, 20)
    .setValue(float(getScaleString("gpbr")))
    .setRange(0.01, 1000)
    .setPosition(800, 268)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0x00000000)
    .setMultiplier(-0.1)
    .moveTo(tab_main);

  cp1.addNumberbox("gpct")
    .setSize(52, 20)
    .setValue(float(getScaleString("gpct")))
    .setRange(0.01, 1000)
    .setPosition(800, 554)
    .setLabel("")
    .setColorValue(0)
    .setColorBackground(#D4DAFA)
    .setColorForeground(0)
    .setFont(createFont("Georgia", 10))
    .setColorActive(0x00000000)
    .setMultiplier(-0.1)
    .moveTo(tab_main);

  ip1 = cp1.addTextfield("ip1")
    .setLabel("")
    .setPosition(917, 65)
    .setSize(18, 20)
    .setFont(createFont("Georgia", 9))
    .setText(getConfigurationString("ip1"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(#D4DAFA)
    .setColor(0)
    .setColorForeground(0)
    .updateSize()
    .setColorActive(#FC0808)
    .setColorCursor(0)
    .hide()
    .moveTo(tab_main);

  ip2 = cp1.addTextfield("ip2")
    .setLabel("")
    .setPosition(937, 65)
    .setSize(18, 20)
    .setFont(createFont("Georgia", 9))
    .setText(getConfigurationString("ip2"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(#D4DAFA)
    .setColor(0)
    .setColorForeground(0)
    .updateSize()
    .setColorActive(#FC0808)
    .setColorCursor(0)
    .hide()
    .moveTo(tab_main);

  ip3 = cp1.addTextfield("ip3")
    .setLabel("")
    .setPosition(957, 65)
    .setSize(18, 20)
    .setFont(createFont("Georgia", 9))
    .setText(getConfigurationString("ip3"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(#D4DAFA)
    .setColor(0)
    .setColorForeground(0)
    .updateSize()
    .setColorActive(#FC0808)
    .setColorCursor(0)
    .hide()
    .moveTo(tab_main);

  ip4 = cp1.addTextfield("ip4")
    .setLabel("")
    .setPosition(977, 65)
    .setSize(18, 20)
    .setFont(createFont("Georgia", 9))
    .setText(getConfigurationString("ip4"))
    .setColorCaptionLabel(0)
    .setAutoClear(false)
    .setColorBackground(#D4DAFA)
    .setColor(0)
    .setColorForeground(0)
    .updateSize()
    .setColorActive(#FC0808)
    .setColorCursor(0)
    .hide()
    .moveTo(tab_main);

  cp1.addToggle("ipenable")
    .setLabel("       IP/Serial")
    .setValue(int(getConfigurationString("ipserial")))
    .setFont(createFont("Georgia", 9))
    .setPosition(933, 110)
    .setSize(80, 13)
    .setColorCaptionLabel(0)
    .setMode(ControlP5.SWITCH)
    .setColorActive(#F56376)
    .setColorBackground(0)
    .setColorForeground(0)
    .moveTo(tab_main);

  cp1.addButton("exportdatacsv")
    .setPosition(585, 360)
    .setImages(Exportdata)
    .updateSize()
    .moveTo(tab_display);

  if (!ipcon) {
    refresh();
  }

  prevMillis = millis() + 1000;
  prevMilliscn = millis() + 1000;

  if (getConfigurationString("uuid").equals(infopc)) {
    // Valid license
  } else {

    // Log
    logEvent(" - License file is different from the computer where it was validated.");
  }

  if (getConfigurationString("pairsecrtst").equals(vld.getString(0))) {
    // Valid parameter files
  } else {

    // Log
    logEvent(" - Unpaired parameter files.");
  }

  if (getConfigurationString("license").equals(keyoutopen)) {

    // Log
    logEvent(" - Registered software.");
  } else {

    // Log
    logEvent(" - Unregistered software.");
  }

  System.setProperty("derby.system.home", getConfigurationString("directory") + "/database");
  System.setProperty("user.home", topSketchPath);

  if (getConfigurationString("ativdir").equals("1")) {
    dbstart = loadStrings(getConfigurationString("directory") + "/database/DB_SDP/service.properties");
    startServer();
    openDBbyServer("DB_SDP");

    if (dbstart == null) {
      createBlobsTable();

      // Log
      logEvent(" - Recreated Backup Database. // Directory = " + getConfigurationString("directory") + "/database");
    }
  }

  if (int(getConfigurationString("timeleft")) > 0) {
    configuration.setString("timeleft", str(int(getConfigurationString("timeleft")) - 1));
  }
}

void draw() {

  background(int(getConfigurationString("graph6")));

  java.awt.Frame winmain = (java.awt.Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
  primaryX = winmain.getX();
  primaryY = winmain.getY();

  fill(120);
  noStroke();
  rect(0, 0, width, 16);
  rect(0, height - 11, width, 11);

  if (tab_main.isActive()) {
    activeTab = "tab_main";
  } else if (tab_display.isActive()) {
    activeTab = "tab_display";
  }

  if (statusok) {
    if (doty == 1) {
      logEvent(" - Connection started.");
      doty = 0;
    }

    democ = false;
    status_on = "    Connected";
    statusoperation = " - SD" + getConfigurationString("serialnumber") + " in Realtime";
  } else {
    status_on = "Not Connected";
    cp1.getController("startcontrol").setValue(0);
    cp1.getController("reccontrol").setValue(0);
    cp1.getController("startrec").setValue(0);

    if (democ) {
      statusoperation = " - Demonstration";
    } else
      statusoperation = " - Offline";
  }

  try {

    Activation();
    Communication();
    thread("Recorderdata");
    thread("Createmethod");
    thread("Loadmethod");
    Conditions();
    Timer1();
    Timer2();
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  if (activeTab.equals("tab_main")) {

    surface.setTitle("SD Plotter DB®" + mode + statusoperation + " - " + username + window1 + datainfo + Userinfo);

    laststatus_on = status_on;

    window1 = ""; // Default value

    // Define the regions with their respective messages
    String[] regions = {
      "10,142,311,584,ENABLING_CHART",
      "890,1180,25,195,COMMUNICATION_PANEL",
      "890,1180,311,444,ANALYSIS_METHOD",
      "890,1180,451,584,SAVE_ANALYTICS",
      "500,618,553,575,CHANGE_SAMPLING_RATE",
      "908,954,240,286,OPEN_MANUAL",
      "238,823,76,246,MONITOR",
      "238,823,363,533,CORRECT_SCALE",
      "24,128,178,282,CAPTURE_PRINT"
    };

    String regionIdentifier = getRegionIdentifier(mouseX, mouseY, regions);

    Drawcontour(10, 25, 132, 272);
    Drawcontourx(16, 32, 120, 110);
    Drawcontourx(16, 145, 120, 22);
    Drawcontourx(16, 170, 120, 120);

    Drawcontour(10, 311, 132, 272);
    Drawcontourx(20, 318, 50, 258);
    Drawcontourx(77, 318, 55, 258);

    Drawcontour(890, 25, 290, 170);
    Drawcontourx(1014, 32, 30, 63);
    Drawcontourx(1050, 32, 120, 110);
    Drawcontourx(900, 103, 145, 40);
    Drawcontourx(900, 147, 270, 40);

    Drawcontour(890, 203, 290, 95);

    Drawcontour(890, 311, 290, 133);
    Drawcontourx(900, 318, 138, 60);
    Drawcontourx(1048, 318, 122, 60);
    Drawcontourx(900, 383, 270, 40);

    Drawcontour(890, 451, 290, 133);
    Drawcontourx(900, 458, 140, 60);
    Drawcontourx(1048, 458, 120, 60);
    Drawcontourx(900, 523, 270, 40);

    Drawcontour(157, 25, 715, 272);

    Drawcontour(157, 311, 715, 272);

    DrawTextBox_status_big(24, 178, 104, 104);
    DrawTextBox_status_little(92, 192, 20, 20);

    if (!ipcon) {
      DrawTextBox_port("Select Port:", serial_list, 900, 32, 110, 62);
    } else {
      DrawTextBox_port("Select IP:", serial_list, 900, 32, 110, 62);
    }

    DrawTextBox_connection("Status:", status_on, 910, 155, 250, 25);
    DrawTextBox_data("|| Time:", status_met, nf(day2, 3) + " / " + nf(hour2, 2)+ ":" + nf(minutes2, 2) + ":" + nf(seconds2, 2) + "." + nf(millisecs2, 1), 910, 391, 250, 25);
    DrawTextBox_data("|| Time:", status_rec, (nf(day1, 3) + " / " +nf(hour1, 2)+ ":" + nf(minutes1, 2) + ":" + nf(seconds1, 2) + "." + nf(millisecs1, 1)), 910, 531, 250, 25);

    DrawTextBoxabout(946, 230);

    fill(30);
    textFont(createFont("Arial", 15));
    textAlign(CENTER);
    textSize(13);
    text("Recording every ", 972, 477);
    textSize(12);
    text("s", 1001, 501);
    textSize(11);
    text("Method", 1035, 437);
    text("Data", 1036, 577);

    Task();
    Creategraph();

    ip1.setText(getConfigurationString("ip1"));
    ip2.setText(getConfigurationString("ip2"));
    ip3.setText(getConfigurationString("ip3"));
    ip4.setText(getConfigurationString("ip4"));

    unit1.setText(getConfigurationString("unit1"));
    unit2.setText(getConfigurationString("unit2"));
    unit3.setText(getConfigurationString("unit3"));
    unit4.setText(getConfigurationString("unit4"));
    unit5.setText(getConfigurationString("unit5"));
    unit6.setText(getConfigurationString("unit6"));
    unit7.setText(getConfigurationString("unit7"));
    unit8.setText(getConfigurationString("unit8"));

    switch (regionIdentifier) {
    case "ENABLING_CHART":
      window1 = " - Enabling and naming data inputs for the chart";
      break;

    case "COMMUNICATION_PANEL":
      window1 = " - Communication panel";
      if ((mouseX > 900 && mouseX < 1170) && (mouseY > 25 && mouseY < 195)) {
        if (statusstartrec || startcontrol || reccontrol) {
          if (!admin) {
            status_on = "Currently disabled";
          }
        } else {
          status_on = laststatus_on;
        }
      }
      break;

    case "ANALYSIS_METHOD":
      window1 = " - Create and reproduce analysis method";
      if (reccontrol) {
        datainfo = " - " + datafilemethod;
      }
      if (startcontrol) {
        datainfo = " - " + numberfile;
      }
      break;

    case "SAVE_ANALYTICS":
      window1 = " - Save analytics data";
      if (statusstartrec) {
        datainfo = " - " + datamoment;
      }
      break;

    case "CHANGE_SAMPLING_RATE":
      window1 = " - Change the data sampling rate";
      break;

    case "OPEN_MANUAL":
      window1 = " - Double click to open the manual";
      break;

    case "MONITOR":
      window1 = " - Double click to view values and units";
      break;

    case "CORRECT_SCALE":
      window1 = " - Double click to correct current scale";
      break;

    case "CAPTURE_PRINT":
      window1 = " - Double click to capture print";
      break;

    default:
      window1 = "";
    }

    if (statusok) {

      if (Viewgraph) {
        DrawTextBox_monitor(
          nfc(avgrt[0], 2), getConfigurationString("unit" + (1)),
          nfc(avgrt[1], 2), getConfigurationString("unit" + (2)),
          nfc(avgrt[2], 2), getConfigurationString("unit" + (3)),
          nfc(avgrt[3], 2), getConfigurationString("unit" + (4)),
          nfc(avgrt[4], 2), getConfigurationString("unit" + (5)),
          nfc(avgrt[5], 2), getConfigurationString("unit" + (6)),
          nfc(avgrt[6], 0), getConfigurationString("unit" + (7)),
          nfc(avgrt[7], 2), getConfigurationString("unit" + (8)),
          375, 75, 305, 172);
      }
    }
  } else if (activeTab.equals("tab_display")) {

    launchdatadisplay();

    // Drawing contours for plots

    Drawcontourx(10, 25, 1170, 550);

    Drawcontoury(20, 35, 682, 365); // Plot 1
    Drawcontour(25, 40, 672, 355);

    Drawcontoury(20, 420, 214, 147); // Plot 2
    Drawcontour(25, 425, 204, 137);

    Drawcontoury(254, 420, 214, 147); // Plot 3
    Drawcontour(259, 425, 204, 137);

    Drawcontoury(488, 420, 214, 147); // Plot 4
    Drawcontour(493, 425, 204, 137);

    Drawcontoury(722, 420, 214, 147); // Plot 5
    Drawcontour(727, 425, 204, 137);

    Drawcontoury(956, 420, 214, 147); // Plot 6
    Drawcontour(961, 425, 204, 137);

    Drawcontour(722, 35, 448, 195); // Box
    fill(int(map(int(getConfigurationString("graph1")), 0, 255, 100, 255)));
    rect(728, 40, 437, 186, 20);

    Drawcontoury(722, 253, 214, 147); // Plot 7
    Drawcontour(727, 258, 204, 137);

    Drawcontoury(956, 253, 214, 147); // Plot 8
    Drawcontour(961, 258, 204, 137);

    fill(int(getConfigurationString("graph2"))); // Change color words
    textSize(17);
    textAlign(LEFT);

    try {
      text(titledatadisplay  + "\r\n" + userdatadisplay + "\r\n" + machinecodedatadisplay + "\r\n" + serialdatadisplay + "\r\n" + "Recording started: " + Datestimesstart[1] + "/" + Datestimesstart[2] + "/" + Datestimesstart[3] + "  " + Datestimesstart[4] + ":" + Datestimesstart[5] + ":" + Datestimesstart[6] + "\r\n" + "Total time: "
        + int(timesdatadisplay[3])
        + " day(s) / " + int(timesdatadisplay[4])
        + ":" + int(timesdatadisplay[5])
        + ":" + int(timesdatadisplay[6])
        + "." + int(timesdatadisplay[7]) + " " + timeshdat1, 760, 87);

      if (numLinesdatadisplay > 7) {
        plot11.setXLim(sampleTotime(plot1.getXLim()));
      }
    }

    catch (Exception e) {
      e.printStackTrace();

      // Log
      logEvent(" - Corrupt file, automatic deletion.");
      logDeletion();
      deleteData();
    }

    // Setting background color for plot boxes
    plot1.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot2.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot3.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot4.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot5.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot6.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot7.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));
    plot8.setBoxBgColor(int(map(int(getConfigurationString("graph1")), 0, 255, 60, 255)));

    Drawdisplay();

    // Actions over the fourth plot (scrolling)
    if (plot1.isOverBox(mouseX, mouseY) && isWindowFocused0 == true) {
      // Get the cursor relative position inside the inner plot area
      float[] relativePos = plot1.getRelativePlotPosAt(mouseX, mouseY);

      if (relativePos[0] < 0.05) {
        plot1.moveHorizontalAxesLim(-2);
      } else if (relativePos[0] > 0.95) {
        plot1.moveHorizontalAxesLim(2);
      }
    }

    switch (selectgh) {
    case 1:
      plot1.setLineColor(graphColors[0]);
      plot1.setPoints(downsamplePoints(graph2datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[7]);
      plot1.getYAxis().setAxisLabelText(units[7]);
      plot1.getXAxis().setAxisLabelText("Time");
      xLimAutoscale = plot2.getXLim();
      yLimAutoscale = plot2.getYLim();
      yreal = plot2.getYLim();
      plot2.setPoints(downsamplePoints(graph2datadisplay, maxDisplayPoints));
      plot3.setPoints(downsamplePoints(graph3datadisplay, maxDisplayPoints));
      plot4.setPoints(downsamplePoints(graph4datadisplay, maxDisplayPoints));
      plot5.setPoints(downsamplePoints(graph5datadisplay, maxDisplayPoints));
      plot6.setPoints(downsamplePoints(graph6datadisplay, maxDisplayPoints));
      plot7.setPoints(downsamplePoints(graph7datadisplay, maxDisplayPoints));
      plot8.setPoints(downsamplePoints(graph8datadisplay, maxDisplayPoints));
      break;

    case 2:
      plot1.setLineColor(graphColors[0]);
      plot1.setPoints(downsamplePoints(graph2datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[7]);
      plot1.getYAxis().setAxisLabelText(units[7]);
      plot1.getXAxis().setAxisLabelText("Time");
      xLimAutoscale = plot2.getXLim();
      yLimAutoscale = plot2.getYLim();
      yreal = plot2.getYLim();
      break;

    case 3:
      plot1.setLineColor(graphColors[1]);
      plot1.setPoints(downsamplePoints(graph3datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[8]);
      plot1.getYAxis().setAxisLabelText(units[8]);
      plot1.getXAxis().setAxisLabelText("Time");
      xLimAutoscale = plot3.getXLim();
      yLimAutoscale = plot3.getYLim();
      yreal = plot3.getYLim();
      break;

    case 4:
      plot1.setLineColor(graphColors[2]);
      plot1.setPoints(downsamplePoints(graph4datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[9]);
      plot1.getYAxis().setAxisLabelText(units[9]);
      plot1.getXAxis().setAxisLabelText("Time");
      xLimAutoscale = plot4.getXLim();
      yLimAutoscale = plot4.getYLim();
      yreal = plot4.getYLim();
      break;

    case 5:
      plot1.setLineColor(graphColors[3]);
      plot1.setPoints(downsamplePoints(graph5datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[10]);
      plot1.getYAxis().setAxisLabelText(units[10]);
      xLimAutoscale = plot5.getXLim();
      yLimAutoscale = plot5.getYLim();
      yreal = plot5.getYLim();
      break;

    case 6:
      plot1.setLineColor(graphColors[4]);
      plot1.setPoints(downsamplePoints(graph6datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[11]);
      plot1.getYAxis().setAxisLabelText(units[11]);
      xLimAutoscale = plot6.getXLim();
      yLimAutoscale = plot6.getYLim();
      yreal = plot6.getYLim();
      break;

    case 7:
      plot1.setLineColor(graphColors[5]);
      plot1.setPoints(downsamplePoints(graph7datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[12]);
      plot1.getYAxis().setAxisLabelText(units[12]);
      xLimAutoscale = plot7.getXLim();
      yLimAutoscale = plot7.getYLim();
      yreal = plot7.getYLim();
      break;

    case 8:
      plot1.setLineColor(graphColors[6]);
      plot1.setPoints(downsamplePoints(graph8datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[13]);
      plot1.getYAxis().setAxisLabelText(units[13]);
      plot8.setLineColor(graphColors[6]);
      plot8.setPoints(downsamplePoints(graph8datadisplay, maxDisplayPoints));
      plot8.setTitleText(probes[13]);
      plot8.getYAxis().setAxisLabelText(units[13]);
      xLimAutoscale = plot8.getXLim();
      yLimAutoscale = plot8.getYLim();
      yreal = plot8.getYLim();
      break;

    case 9:
      plot1.setLineColor(graphColors[7]);
      plot1.setPoints(downsamplePoints(graph9datadisplay, maxDisplayPoints));
      plot1.setTitleText(probes[14]);
      plot1.getYAxis().setAxisLabelText(units[14]);
      plot8.setLineColor(graphColors[7]);
      plot8.setPoints(downsamplePoints(graph9datadisplay, maxDisplayPoints));
      plot8.setTitleText(probes[14]);
      plot8.getYAxis().setAxisLabelText(units[14]);
      xLimAutoscale = plot8.getXLim();
      yLimAutoscale = plot8.getYLim();
      yreal = plot8.getYLim();
      break;
    }
  }

  if (modevisible0 == 1) {
    surface.setVisible(!login);
    modevisible0 = 0;
  }
  cp1.draw();
}

void exit() {
  if (readyToClose()) {
    if (winclose == null) {
      winclose = new PWindowc();
    }
    exit();
  }
  closesec();
}
