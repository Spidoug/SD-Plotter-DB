// Function for drawing a contour box
void Drawcontour(int x, int y, int w, int h) {
  fill(int(getConfigurationString("graph5"))); // Set fill color from configuration
  stroke(30); // Set stroke color
  strokeWeight(0.5); // Set stroke weight
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box (error)
void Drawcontourx(int x, int y, int w, int h) {
  fill(205); // Set fill color
  stroke(240); // Set stroke color
  strokeWeight(0.5); // Set stroke weight
  rect(x, y, w, h, 10); // Draw rectangle with rounded corners
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box containing the selected serial port
void DrawTextBox_port(String title, String str, int x, int y, int w, int h) {
  fill(50); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  fill(250); // Set fill color for text
  textAlign(CENTER); // Align text to center
  textSize(15); // Set text size
  text(title, x + 12, y + 15, w - 20, 20); // Draw title text
  textSize(12); // Set text size
  text(str, x + 11, y + 39, w - 20, h - 10); // Draw content text
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box (communication)
void DrawTextBox_connection(String title, String str, int x, int y, int w, int h) {
  fill(50); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  fill(250); // Set fill color for text
  textAlign(LEFT); // Align text to left
  textSize(12); // Set text size
  text(title, x + 64, y + 7, w - 20, 20); // Draw title text
  textSize(12); // Set text size
  text(str, x + 114, y + 7, w - 20, h - 10); // Draw content text
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box (received data)
void DrawTextBox_data(String title, String str, String str2, int x, int y, int w, int h) {
  fill(50); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  fill(250); // Set fill color for text
  textAlign(LEFT); // Align text to left
  textSize(12); // Set text size
  text(title, x + 115, y + 6, w - 20, 20); // Draw title text
  textSize(12); // Set text size
  text(str, x + 10, y + 7, w - 20, h - 10); // Draw first content text
  textSize(12); // Set text size
  text(str2, x + 157, y + 7, w - 20, h - 10); // Draw second content text
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box with title and contents
void DrawTextBox_status_big(int x, int y, int w, int h) {
  fill(#F0F0F0); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  if (statusdb) {
    fill(#FFCC7E); // Change fill color based on status
  }
  if (statusok) {
    fill(#08FA25); // Change fill color based on status
  }
  if (statusstartrec) {
    fill(#2D38ED); // Change fill color based on status
  }
  if (Userinfo == " - Connection lost") {
    fill(#F56376); // Change fill color based on user info
  }
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box with title and contents (minimized)
void DrawTextBox_status_little(int x, int y, int w, int h) {
  fill(205); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  if (reccontrol) {
    fill(#A9A3ED); // Change fill color based on reccontrol status
  }
  if (startcontrol) {
    fill(#EEFF08); // Change fill color based on startcontrol status
  }
  stroke(240); // Set stroke color
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box with title and contents
void DrawTextBox_monitor(String title1, String str1, String title2, String str2, String title3, String str3, String title4, String str4, String title5, String str5, String title6, String str6, String title7, String str7, String title8, String str8, int x, int y, int w, int h) {
  stroke(color(int(getConfigurationString("graph3")))); // Set stroke color from configuration
  strokeWeight(0.5); // Set stroke weight
  fill(int(getConfigurationString("graph4"))); // Set fill color from configuration
  rect(x, y, w, h, 20); // Draw rectangle with rounded corners
  fill(int(getConfigurationString("graph3"))); // Set fill color for text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title1, x + 15, y + 8, w + 20, 100); // Draw title1 text
  textSize(20); // Set text size
  text(str1, x + 195, y + 8, w - 20, h - 10); // Draw str1 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title2, x + 15, y + 28, w + 20, 100); // Draw title2 text
  textSize(20); // Set text size
  text(str2, x + 195, y + 28, w - 20, h - 10); // Draw str2 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title3, x + 15, y + 48, w + 20, 100); // Draw title3 text
  textSize(20); // Set text size
  text(str3, x + 195, y + 48, w - 20, h - 10); // Draw str3 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title4, x + 15, y + 68, w + 20, 100); // Draw title4 text
  textSize(20); // Set text size
  text(str4, x + 195, y + 68, w - 20, h - 10); // Draw str4 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title5, x + 15, y + 88, w + 20, 100); // Draw title5 text
  textSize(20); // Set text size
  text(str5, x + 195, y + 88, w - 20, h - 10); // Draw str5 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title6, x + 15, y + 108, w + 20, 100); // Draw title6 text
  textSize(20); // Set text size
  text(str6, x + 195, y + 108, w - 20, h - 10); // Draw str6 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title7, x + 15, y + 128, w + 20, 100); // Draw title7 text
  textSize(20); // Set text size
  text(str7, x + 195, y + 128, w - 20, h - 10); // Draw str7 text
  textAlign(LEFT); // Align text to left
  textSize(20); // Set text size
  text(title8, x + 15, y + 148, w + 20, 100); // Draw title8 text
  textSize(20); // Set text size
  text(str8, x + 195, y + 148, w - 20, h - 10); // Draw str8 text
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a graph text
void TextGraph() {
  fill(int(getConfigurationString("graph2"))); // Set fill color from configuration
  strokeWeight(0.5); // Set stroke weight
  textAlign(CENTER); // Align text to center
  textSize(12); // Set text size
  text("Scale factor adjustment = ", 727, 282); // Draw text
  textSize(12); // Set text size
  text("Scale factor adjustment = ", 727, 567); // Draw text
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing the text box containing the selected serial port
void DrawTextBoxabout(int x, int y) {
  fill(30); // Set fill color
  strokeWeight(0.5); // Set stroke weight
  textFont(createFont("Arial", 17)); // Set font and size
  text("SD Plotter DB® - v" + rev, x, y); // Draw version text
  textFont(createFont("Arial", 10)); // Set font and size
  text("Software developed by:", x + 38, y + 16); // Draw text
  text("Douglas Santana", x + 53, y + 35); // Draw name
  text("spidoug@gmail.com", x + 47, y + 51); // Draw email
  Drawcontourx(x - 38, y + 10, 46, 46); // Draw contour box
  image(logo, x - 38, y + 10, 46, 46); // Draw logo image
  noFill(); // Disable fill
  noStroke(); // Disable stroke
}

// Function for drawing a text box with title and contents (vertical)
void Drawcontoury( int x, int y, int w, int h) {
  fill(int(getConfigurationString("graph6")));
  stroke(255);
  strokeWeight(0.5);
  rect(x, y, w, h, 20);
  noFill();
  noStroke();
}
