public class PWindowl extends PApplet {
  int xLct, yLct;

  // Constructor for the PWindowl class
  PWindowl(int xLct, int yLct) {
    super();
    this.xLct = xLct;
    this.yLct = yLct;
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  int admincheck = 0; // Variable to check if the admin is logged in
  public int ps = 0; // Password attempt counter
  public boolean valip = false; // Validates if the IP is valid
  public boolean petd = false; // State of some validation
  public int sertg = 0; // Error indicator
  public int ift = 0; // Counter for user navigation
  public String[] p = null; // Temporary string array for storage
  int rte = ift; // Auxiliary variable

  // Initial settings for the sketch
  void settings() {
    smooth(2); // Smoothing
    size(300, 170); // Window size
  }

  // Initialization and setup of the interface
  void setup() {

    surface.setTitle("SD Plotter DB®"); // Set window title
    surface.setLocation(xLct + 440, yLct + 240);
    surface.setAlwaysOnTop(true); // Keep window always on top

    cp4 = new ControlP5(this); // Initialize ControlP5 library
    cp4.setAutoDraw(false); // Disable automatic drawing

    // Load images for the GUI buttons
    PImage[] Ok = loadImages("/lib/src/ok_a.png", "/lib/src/ok_b.png", "/lib/src/ok_c.png");
    PImage[] Cancel = loadImages("/lib/src/cancel_a.png", "/lib/src/cancel_b.png", "/lib/src/cancel_c.png");
    PImage[] Createuser = loadImages("/lib/src/create_a.png", "/lib/src/create_b.png", "/lib/src/create_c.png");
    PImage[] Deleteuser = loadImages("/lib/src/deleteuser_a.png", "/lib/src/deleteuser_b.png", "/lib/src/deleteuser_c.png");
    PImage[] Windowslogin = loadImages("/lib/src/windowslogin_a.png", "/lib/src/windowslogin_b.png", "/lib/src/windowslogin_c.png");
    PImage[] Up = loadImages("/lib/src/up_a.png", "/lib/src/up_b.png", "/lib/src/up_c.png");
    PImage[] Down = loadImages("/lib/src/down_a.png", "/lib/src/down_b.png", "/lib/src/down_c.png");

    // Create and configure buttons
    createuser = cp4.addButton("createuser")
      .setPosition(75, 85)
      .setImages(Createuser)
      .updateSize()
      .hide();

    deleteuser = cp4.addButton("deleteuser")
      .setPosition(201, 85)
      .setImages(Deleteuser)
      .updateSize()
      .hide();

    windowslogin = cp4.addButton("winlogin")
      .setPosition(15, 15)
      .setImages(Windowslogin)
      .updateSize()
      .hide();

    administrator = cp4.addButton("admin")
      .setPosition(125, 25)
      .setSize(30, 20)
      .updateSize()
      .setColorBackground(color(#D8D8D8))
      .setColorActive(color(#CECCCC))
      .setColorForeground(color(#E3E3E3))
      .setColorLabel(color(0))
      .hide();

    downuser = cp4.addButton("downuser")
      .setPosition(125, 52)
      .setImages(Down)
      .updateSize()
      .hide();

    upuser = cp4.addButton("upuser")
      .setPosition(153, 51)
      .setImages(Up)
      .updateSize()
      .hide();

    cancel = cp4.addButton("cancel")
      .setPosition(30, 125)
      .setImages(Cancel)
      .updateSize();

    ok = cp4.addButton("ok")
      .setPosition(166, 125)
      .setImages(Ok)
      .updateSize();

    user = cp4.addTextfield("user")
      .setPosition(168, 25)
      .setSize(100, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setColorCaptionLabel(color(40))
      .setAutoClear(false)
      .setColorBackground(color(0xffffffff))
      .setColor(color(0))
      .setColorForeground(color(0xffffffff))
      .updateSize()
      .setColorActive(color(0x00000000))
      .setColorCursor(color(0))
      .setFocus(true)
      .show();

    password = cp4.addTextfield("password")
      .setPosition(168, 55)
      .setSize(100, 20)
      .setFont(createFont("Georgia", 10))
      .setLabel("")
      .setColorCaptionLabel(color(40))
      .setAutoClear(false)
      .setColorBackground(color(0xffffffff))
      .setColor(color(0))
      .setColorForeground(color(0xffffffff))
      .updateSize()
      .setColorActive(color(0x00000000))
      .setColorCursor(color(0))
      .setPasswordMode(true)
      .show();

    dotb = 1;

    if (authenticationwindows) {
      username = System.getProperty("user.name");
      admin = isAdmin();
      Systeminfo = " Login performed";

      // Log the login action
      logEvent(" - Login performed. // User = " + username);

      login = false;
      modelogin = false;
      user.setText("");
      password.setText("");
      userid = null;
      passwordid = null;
      ps = 0;
      valueps = null;
      dotb = 1;
      modevisible0 = 1;
      modevisible1 = 1;
      modevisible2 = 1;
      modevisible3 = 1;
      modevisible4 = 1;
    }
  }

  // Main drawing function
  void draw() {
    surface.setTitle(window3);
    background(int(getConfigurationString("graph6")));

    Drawcontour_outer_Login(5, 5, 290, 160);
    Drawcontour_inner_Login(10, 11, 280, 150);
    Drawcontour_medium_Login(25, 121, 250, 35);

    // Draw the text box (error)
    DrawTextBox_info(Systeminfo, 73, 82, 154, 30);

    fill(240);
    textSize(13);
    text("USERNAME:", 50, 39);

    if (winlogin != null) {
      if (cp4 != null) {
        if (admincheck == 1) {
          if (modemanageruser == 1 & !modelogin) {
            user.setColorForeground(color(#F20A0A));
          }
        }

        if (admincheck == 0) {
          user.setColorForeground(color(0xffffffff));
        }

        if (!modelogin & modemanageruser == 2) {
          if (derty.equals("pairsecrtid")) {
            ift = ift + rte;
            rte = 0;
          }

          if (ift > properties.length - 1) {
            ift = 0;
          }

          if (ift < 0) {
            ift = properties.length - 1;
          }

          Drawcontour_medium_Login(122, 49, 58, 28);

          p = splitTokens(properties[ift], "(*836*$#@)");
          derty = p[0];

          if (!derty.equals("pairsecrtid")) {
            user.setText(derty);
          }
        } else {
          textSize(13);
          text("PASSWORD:", 50, 69);
        }
      }
    }

    windowslogin.setLock(statusconnect);

    cp4.draw();
    surface.setVisible(login);
  }

  // Function to handle errors
  void errorx() {
    if (sertg == 1) {
      if (valip & !petd) {
        Systeminfo = "Wrong password";
        user.setText("");
        password.setText("");
        isTabPressed = false;
        userid = null;
        passwordid = null;
        user.setFocus(true);
        password.setFocus(false);

        // Log the wrong password attempt
        logEvent(" - Wrong password.");

        sertg = 0;
      }
    }
  }

  // Function to move up the user list
  void upuser() {
    if (admin & modemanageruser == 2) {
      rte = -1;
      ift--;
    }
  }

  // Function to move down the user list
  void downuser() {
    if (admin & modemanageruser == 2) {
      rte = 1;
      ift++;
    }
  }

  // Function to delete a user
  void deleteuser() {
    properties = (String[]) idlist.keys().toArray(new String[idlist.size()]);
    windowslogin.hide();
    upuser.show();
    downuser.show();
    password.hide();
    createuser.show();
    deleteuser.hide();
    administrator.hide();
    modelogin = false;
    modemanageruser = 2;
    window3 = "Delete User";
    Systeminfo = "";
  }

  // Function to handle admin actions
  void admin() {
    if (admincheck == 0) {
      if (("(*836*$#@)" + cp4.get(Textfield.class, "user").getText()).length() >= 15) {
        admincheck = 1;
      }
    } else {
      admincheck = 0;
    }
  }

  // Function to handle Windows login
  void winlogin() {
    user.setText("");
    password.setText("");
    userid = null;
    passwordid = null;
    Systeminfo = " Windows users";

    if (int(configuration.getString("winlogin")) == 0) {
      configuration.setString("winlogin", "1");
    }
  }

  // Function to handle cancel action
  void cancel() {
    if (modelogin) {
      if (statusstartrec || startcontrol || reccontrol) {
      } else {
        closesec();
      }
    }

    if (!modelogin) {
      if (int(configuration.getString("winlogin")) == 1) {
        configuration.setString("winlogin", "0");
      }

      login = false;
      Systeminfo = "";
      user.setText("");
      password.setText("");
      userid = null;
      passwordid = null;
    }
  }

  // Function to create a new user
  void createuser() {
    if (isAdmin()) {
      windowslogin.show();
    } else {
      windowslogin.hide();
    }

    createusermain();
  }

  // Function to handle OK action
  void ok() {
    valueps = cp4.get(Textfield.class, "user").getText();
    userid = "(*836*$#@)" + valueps;
    ps = cp4.get(Textfield.class, "password").getText().length();
    passwordid = get_hash(cp4.get(Textfield.class, "password").getText());

    int id = 0;

    if (!admin & !modelogin) {
      modelogin = true;
    }

    if (modemanageruser == 1 & !modelogin) {
      id = userid.length();

      if (int(configuration.getString("winlogin")) == 1 & id == 10) {

        // Log
        logEvent(" - Login defined by Windows authentication.");

        closesec();
      }

      if (id < 15) {
        Systeminfo = "         Short ID";
        admincheck = 0;
        user.setText("");
        password.setText("");
        userid = null;
        passwordid = null;
        user.setFocus(true);
        password.setFocus(false);
        configuration.setString("winlogin", "0");
      } else {
        if (ps < 5) {
          Systeminfo = "Short password";
          admincheck = 0;
          user.setText("");
          password.setText("");
          userid = null;
          passwordid = null;
          user.setFocus(true);
          password.setFocus(false);
          configuration.setString("winlogin", "0");
        } else {
          if ((cp4.get(Textfield.class, "password").getText()).equals(valueps)) {
            Systeminfo = "   Password = ID";
            admincheck = 0;
            user.setFocus(true);
            password.setFocus(false);
            configuration.setString("winlogin", "0");
          } else {

            // Log the new user creation
            logEvent(" - New user created. // User = " + valueps);

            Systeminfo = "    User created";
            usersid = new JSONArray();
            usersid.append(passwordid);

            if (userid.equals("(*836*$#@)Admin")) {
              usersid.append("1");
            } else {
              usersid.append(str(admincheck));
            }

            idlist.setJSONArray(userid, usersid);
            admincheck = 0;
            user.setText("");
            password.setText("");
            userid = null;
            passwordid = null;
            ps = 0;
            valueps = null;
            user.setFocus(true);
            password.setFocus(false);
            configuration.setString("winlogin", "0");

            encryptFile(keys, idlist.toString(), topSketchPath + "/users.dat");
          }
        }
      }
    }

    if (login & modelogin) {
      if (idlist.getJSONArray(userid) == null) {
        Systeminfo = "      Invalid User";
        isTabPressed = false;
        user.setText("");
        password.setText("");
        userid = null;
        passwordid = null;
        ps = 0;
        valueps = null;
        user.setFocus(true);
        password.setFocus(false);

        // Log the invalid user input
        logEvent(" - Invalid user input.");
      }

      int doter = 0;

      if (idlist.getJSONArray(userid) != null) {
        valip = true;
        sertg = 1;
        petd = false;
        JSONArray userlist = idlist.getJSONArray(userid);

        if ((passwordid).equals(userlist.getString(0))) {
          passwordsql = passwordid;

          if (!authenticationwindows) {
            petd = true;
          }

          if (statusstartrec || startcontrol || reccontrol) {
            String[] p = splitTokens(userid, "(*836*$#@)");

            if ((p[0]).equals(username)) {
              String[] l = splitTokens(userid, "(*836*$#@)");
              username = l[0];

              if (int(userlist.getString(1)) == 1) {
                admin = true;
              } else {
                admin = false;
              }

              Systeminfo = " Login performed";

              // Log the login action
              logEvent(" - Login performed. // User = " + username);

              login = false;
              modelogin = false;
              user.setText("");
              password.setText("");
              userid = null;
              passwordid = null;
              ps = 0;
              valueps = null;
              dotb = 1;
              doter = 1;
              modevisible0 = 1;
              modevisible1 = 1;
              modevisible2 = 1;
              modevisible3 = 1;
              modevisible4 = 1;
            } else if (doter == 0) {

              // Log the attempt to login with a different user for the open session
              logEvent(" - Attempt to login with different user for the open session. // User = " + p[0]);

              Systeminfo = "    Different user";
              user.setText("");
              password.setText("");
              userid = null;
              passwordid = null;
              ps = 0;
              valueps = null;
            }
          } else {
            String[] p = splitTokens(userid, "(*836*$#@)");
            username = p[0];

            if (int(userlist.getString(1)) == 1) {
              admin = true;
            } else {
              admin = false;
            }

            Systeminfo = " Login performed";

            // Log the login action
            logEvent(" - Login performed. // User = " + username);

            login = false;
            modelogin = false;
            user.setText("");
            password.setText("");
            userid = null;
            passwordid = null;
            ps = 0;
            valueps = null;
            dotb = 1;
            modevisible0 = 1;
            modevisible1 = 1;
            modevisible2 = 1;
            modevisible3 = 1;
            modevisible4 = 1;

            status_met = "           Stop";
            millisecs2 = seconds2 = minutes2 = hour2 = day2 = 0;

            myStringsmet = null;
            refreshmethod = true;
            numberfile = "";
            datainfo = "";
          }
        }
      }
    }

    if (modemanageruser == 2 & !modelogin) {
      userid = "(*836*$#@)" + derty;

      if (idlist.getJSONArray(userid) != null) {
        String[] p = splitTokens(userid, "(*836*$#@)");

        if ((p[0]).equals("Admin") || (p[0]).equals(username)) {
          Systeminfo = "Prohibited action";
          userid = null;
        } else {

          // Log the user deletion
          logEvent(" - Deleted user. // User = " + p[0]);

          Systeminfo = "      User erased";
          idlist.remove(userid);
          properties = (String[]) idlist.keys().toArray(new String[idlist.size()]);
          user.setText("");
          password.setText("");
          userid = null;
          passwordid = null;
          ps = 0;
          valueps = null;

          encryptFile(keys, idlist.toString(), topSketchPath + "/users.dat");
        }
      }
    }

    errorx();
  }

  // Function to handle key presses
  void keyPressed() {
    if (keyCode == TAB) {
      isTabPressed = !isTabPressed;

      if (isTabPressed) {
        user.setFocus(false);
        password.setFocus(true);
      } else {
        user.setFocus(true);
        password.setFocus(false);
      }
    }

    if (keyCode == ESC) {
      cancel.setValue(1);
    }

    if (keyCode == ENTER) {
      ok.setValue(1);
    }

    if (winlogin != null) {
      if (cp4 != null) {
        if (key == CODED) {
          if (keyCode == java.awt.event.KeyEvent.VK_F1) {
            Manual();
          }

          if (int(getConfigurationString("fnkey")) == 1) {

            if (keyCode == java.awt.event.KeyEvent.VK_F2) {
              if (!modelogin) {
                if (modemanageruser == 1) {
                  winlogin();
                }
              }
            }

            if (keyCode == java.awt.event.KeyEvent.VK_F3) {
              if (!modelogin) {
                if (modemanageruser == 1) {
                  admin();
                }
              }
            }

            if (keyCode == java.awt.event.KeyEvent.VK_F12) {
              if (!modelogin) {
                if (modemanageruser == 2) {
                  createuser();
                } else {
                  deleteuser();
                }
              }
            }


            if (keyCode == UP || keyCode == RIGHT) {
              upuser();
            }

            if (keyCode == DOWN || keyCode == LEFT) {
              downuser();
            }
          }
        }
      }
    }
  }

  // Function to get hash of the password
  String get_hash(String originalpw) {
    try {
      MessageDigest md = MessageDigest.getInstance("MD5");
      md.update(originalpw.getBytes());
      byte[] digest = md.digest();
      StringBuilder sb = new StringBuilder(32);
      for (byte b : digest) sb.append(String.format("%02x", b & 0xff));
      return sb.toString();
    }
    catch (java.security.NoSuchAlgorithmException e) {
      return null;
    }
  }

  // Function to draw the text box for status messages
  void DrawTextBox_info(String str, int x, int y, int w, int h) {
    rect(x, y, w, h, 20);
    fill(#FF3F3B);
    textAlign(LEFT);
    textSize(12);
    text(str, x + 35, y + 10, w - 20, h - 10);
  }

  // Function to draw the main contour box
  void Drawcontour_outer_Login(int x, int y, int w, int h) {
    fill(205);
    stroke(30);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
  }

  // Function to draw the inner contour box
  void Drawcontour_inner_Login(int x, int y, int w, int h) {
    fill(130);
    stroke(230);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
  }

  // Function to draw the smaller contour box
  void Drawcontour_medium_Login(int x, int y, int w, int h) {
    fill(220);
    stroke(255);
    strokeWeight(0.5);
    rect(x, y, w, h, 10);
  }

  PApplet parent; // Reference to the parent PApplet

  // Override exit function
  void exit() {
  }
}
