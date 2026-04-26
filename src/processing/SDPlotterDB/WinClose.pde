public class PWindowc extends PApplet {

  // Constructor for the PWindowc class
  PWindowc() {
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  // Initial settings for the sketch
  void settings() {
    smooth(2); // Smoothing
    size(260, 140); // Window size
  }

  // Setup function to initialize the window
  void setup() {

    frameRate(1); // Frame rate set to 1 frame per second

    surface.setTitle("SD Plotter DB®"); // Set the window title

    background(0); // Set background color to black

    fill(#FC0F03); // Set fill color to red

    text("DISCONNECT TO END THE PROGRAM", 38, height / 2); // Display text message

    surface.setAlwaysOnTop(true); // Keep window always on top
  }

  // Main draw function
  void draw() {
    surface.setVisible(!login); // Set window visibility based on the login status
  }

  // Function to handle key presses
  void keyPressed() {
    if (key == ESC) {
      key = 0; // Prevent default ESC key behavior
    }
  }

  PApplet parent; // Reference to the parent PApplet

  // Override exit function to handle closing of the window
  void exit() {
    delay(500); // Delay for 500 milliseconds
    winclose = null;
    this.dispose(); // Dispose of the window
    this.stop(); // Stop the PApplet
  }
}
