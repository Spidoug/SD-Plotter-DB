/*   =================================================================================
 The Graph class contains functions and variables that have been created to draw
 graphs. Here is a quick list of functions within the graph class:
 
 Graph(int x, int y, int w, int h,color k)
 DrawAxis()
 Bar([])
 smoothLine([][])
 DotGraph([][])
 LineGraph([][])
 
 =================================================================================*/

class Graph {

  int     xDiv=10, yDiv=10;            // Number of sub divisions
  int     xPos, yPos;            // location of the top left corner of the graph
  int     Width, Height;         // Width and height of the graph


  color   GraphColor;
  color   BackgroundColor = color(int(getConfigurationString("graph1")));   // Change color Background
  color   StrokeColor = color(int(getConfigurationString("graph2")));

  String  Title="Title";          // Default titles
  String  Alert="";
  String  xLabel="x - Label";
  String  yLabel="y - Label";

  float   yMax=1023, yMin=0;      // Default axis dimensions
  float   xMax=10, xMin=0;
  float   yMaxRight=1023, yMinRight=0;

  PFont   Font;                   // Selected font used for text

  int Peakcounter=0, nPeakcounter=0;

  boolean Axisxtime = true;



  Graph(int x, int y, int w, int h, color k, boolean r) {  // The main declaration function

    xPos = x;
    yPos = y;
    Width = w;
    Height = h;
    GraphColor = k;
    Axisxtime = r;
  }

  void DrawAxis() {

    /*  =========================================================================================
     Main axes Lines, Graph Labels, Graph Background
     ==========================================================================================  */

    fill(int(getConfigurationString("graph1")));
    color(30);
    stroke(int(getConfigurationString("graph2")));
    strokeWeight(0.5);
    int t=45;

    rect(xPos-t*1.6, yPos-t, Width+t*2.5, Height+t*2, 10);            // outline
    textAlign(CENTER);
    textSize(18);
    float c=textWidth(Title);
    fill(int(getConfigurationString("graph1")));
    stroke(int(getConfigurationString("graph2")));
    rect((xPos+Width/2-c/2) - 4, yPos-20, c + 8, -20);                         // Heading Rectangle

    fill(int(getConfigurationString("graph2"))); // Change color words
    text(Title, xPos+Width/2, yPos-23);                            // Heading Title
    textAlign(CENTER);
    textSize(12);
    text(xLabel, xPos+Width/2, yPos+Height+t/1.28);                     // x-axis Label

    rotate(-PI/2);                                               // rotate -90 degrees
    text(yLabel, (-yPos-Height/2), (xPos-t*1.6+20) - 5);                   // y-axis Label
    rotate(PI/2);                                                // rotate back

    textSize(10);
    noFill();
    stroke(int(getConfigurationString("graph2")));

    //Edges

    if (statusok ) {

      strokeWeight(0.5);
      line(xPos, yPos+Height-186, xPos+Width, yPos+Height-186);           // xTop-axis line Title probes

      for (int x=0; x<9; x++) {

        line(int(xPos+x*float(Width)/8), yPos+Height-186, //  x-axis Sub devisions
          int(xPos+x*float(Width)/8), yPos+Height-180);
      }
    }

    strokeWeight(3);
    line(xPos-49, yPos+Height+15, xPos-49, yPos-15);                        // yRight-axis line
    line(xPos-2, yPos+Height-172, xPos+Width + 2, yPos+Height-172);           // xTop-axis line
    line(xPos-2, yPos+Height+2, xPos-2, yPos);                        // yLeft-axis line
    line(xPos-2, yPos+Height+2, xPos+Width + 2, yPos+Height+2);           // xGround-axis line

    for (int x=0; x<8; x++) {        // Title

      if (statusok ) {

        fill(graphColors[x]);

        textSize(10);
        text(getConfigurationString("sensor"+(x+1)), // Right Y axis text
          int(xPos+35+x*float(Width)/8), yPos - 7);   // it's x,y location
      }

      noFill();
    }

    strokeWeight(0.8);
    fill(#FC0F03);
    textSize(15);
    text(Alert, xPos+Width - 130 /2, yPos-20);

    if (yMin<0) {          // zero line

      if ( yPos+Height-(abs(yMin)/(yMax-yMin))*Height > yPos    &     yPos+Height-(abs(yMin)/(yMax-yMin))*Height < (yPos+Height)) {

        line(xPos - 2,
          yPos+Height-(abs(yMin)/(yMax-yMin))*Height,
          xPos+Width,
          yPos+Height-(abs(yMin)/(yMax-yMin))*Height
          );
      } else

        noStroke();
    }

    stroke(int(getConfigurationString("graph2")));
    strokeWeight(3);
    line(xPos+Width+2, yPos+Height +2, xPos+Width+2, yPos);   // Right-axis line
    strokeWeight(0.5);

    /*  =========================================================================================
     Sub-devisions for both axes, left and right
     ==========================================================================================  */

    /*  =========================================================================================
     x-axis
     ==========================================================================================  */

    if ( Axisxtime == true) {

      for (int x=0; x<=xDiv; x++) {

        line(float(x)/xDiv*Width+xPos, yPos+Height + 5, //  x-axis Sub devisions
          float(x)/xDiv*Width+xPos, yPos+Height-170);

        String xAxis=str(xMin+float(x)/xDiv*(xMax-xMin));  // the only way to get a specific number of decimals
        String[] xAxisMS=split(xAxis, '.');                 // is to split the float into strings

        textSize(8);
        fill(int(getConfigurationString("graph2"))); // Change color scale left
        text(xAxisMS[0]+"."+xAxisMS[1].charAt(0), // ...
          float(x)/xDiv*Width+xPos-3, yPos+Height+15);   // x-axis Labels
      }
    }

    noFill();

    /*  =========================================================================================
     left y-axis
     ==========================================================================================  */

    for (int y=0; y<=yDiv; y++) {

      line(xPos-5, float(y)/yDiv*Height+yPos, // ...
        xPos+585, float(y)/yDiv*Height+yPos);              // y-axis lines

      String yAxis=str(yMin+float(y)/yDiv*(yMax-yMin));     // Make y Label a string
      String[] yAxisMS=split(yAxis, '.');                    // Split string

      textAlign(RIGHT);
      textSize(8);
      fill(int(getConfigurationString("graph2"))); // Change color scale left
      text(yAxisMS[0]+"."+yAxisMS[1].charAt(0), // ...
        xPos-10, float(yDiv-y)/yDiv*Height+yPos+3);       // y-axis Labels

      noFill();


      /*  =========================================================================================
       right y-axis
       ==========================================================================================  */

      if (RightAxis) {

        line(xPos+Width+3, float(y)/yDiv*Height+yPos, // ...
          xPos+Width+6, float(y)/yDiv*Height+yPos);            // Right Y axis sub devisions

        textAlign(LEFT);

        String yAxisRight=str(yMinRight+float(y)/                // ...
          yDiv*(yMaxRight-yMinRight));           // convert axis values into string
        String[] yAxisRightMS=split(yAxisRight, '.');             //

        textSize(10);
        fill(int(getConfigurationString("graph2"))); // Change color scale left
        text(yAxisRightMS[0], // Right Y axis text
          xPos+Width+10, float(yDiv-y)/yDiv*Height+yPos+2);   // it's x,y location

        noFill();
      }
    }
  }

  /*  =========================================================================================
   Bar graph
   ==========================================================================================  */

  void Bar(float[] a ) {

    for (int x=0; x<(a.length); x++) {        // of the array, adjust them

      fill(graphColors[x]);

      if (ShowMouseLines) {
        strokeWeight(1);
        stroke(graphColors[x]);

        float axisYbarline = yPos+Height-(a[x]/(yMax-yMin)*Height)+(yMin)/(yMax-yMin)*Height;

        if ( axisYbarline < yPos) {
          axisYbarline = yPos;
        }

        if ( axisYbarline > (yPos+Height)) {
          axisYbarline = (yPos+Height);
        }

        line(int(xPos+x*float(Width)/(a.length)) + 4, axisYbarline, xPos, axisYbarline);
      }

      float axisY = -a[x]/(yMax-yMin)*Height;

      if ((a[x]) <=  scalelb) {
        axisY = ((abs(yMin)/(yMax-yMin))*Height) - 2;
      }

      if ((a[x]) >=  scaleub) {
        axisY = (((yMax)/(yMin-yMax))*Height);
      }

      rect(int(xPos+x*float(Width)/(a.length)) + 4,
        yPos+Height-(abs(yMin)/(yMax-yMin))*Height,
        Width/a.length-10,
        axisY);
    }
  }

  /*  =========================================================================================
   Streight line graph
   ==========================================================================================  */

  void LineGraph(float[] x, float[] y) {
    for (int i=0; i<(x.length-1); i++) {

      strokeWeight(1);
      stroke(GraphColor);

      float axisYi = (yPos+Height-(y[i+1]/(yMax-yMin)*Height)+(yMin)/(yMax-yMin)*Height);
      float axisYf = (yPos+Height-(y[i]/(yMax-yMin)*Height)+(yMin)/(yMax-yMin)*Height);

      if ( axisYi < yPos) {
        axisYi = yPos;
      }

      if ( axisYf < yPos) {
        axisYf = yPos;
      }

      if ( axisYi > (yPos+Height)) {
        axisYi = (yPos+Height);
      }

      if ( axisYf > (yPos+Height)) {
        axisYf = (yPos+Height);
      }

      line((Width + (xPos)+ (x[i]-x[0])/-(x[x.length-1]-x[0]) * Width), axisYf,
        (Width + (xPos)+(x[i+1]-x[0])/-(x[x.length-1]-x[0]) * Width),
        axisYi);
    }

    smoothLine(x, y);
    return;
  }

  /*  =========================================================================================
   smoothLine
   ==========================================================================================  */

  void smoothLine(float[] x, float[] y) {

    textSize(9);
    float tempyMax=yMax, tempyMin=yMin;

    if (RightAxis) {
      yMax= yPos+Height;
      yMin=yMinRight;
    }

    int xlocation=0, ylocation=0;

    yMax=tempyMax;
    yMin=tempyMin;
    float xAxisTitleWidth=textWidth(str(map(xlocation, xPos, xPos+Width, x[0], x[x.length-1])));


    if ((mouseX>xPos&mouseX<(xPos+Width))&(mouseY>yPos&mouseY<(yPos+Height))) {
      if (ShowMouseLines) {
        if (mouseX<xPos)xlocation=xPos;
        if (mouseX>xPos+Width)xlocation=xPos+Width;
        else xlocation=mouseX;
        stroke(140);
        strokeWeight(0.5);
        fill(#D4DAFA);
        color(int(getConfigurationString("graph1")));

        //Rectangle and x position
        line(xlocation, yPos, xlocation, yPos+Height -2);
        rect(xlocation-xAxisTitleWidth/2+5, yPos+Height+5, 50, 12);
        textAlign(CENTER);
        fill(0);
        textSize(8);
        text(map(xlocation, xPos, xPos+Width, x[0], x[x.length-1]), xlocation + 5, yPos+Height + 15);

        if (mouseY<yPos)ylocation=yPos;
        if (mouseY>yPos+Height)ylocation=yPos+Height;
        else ylocation=mouseY;

        // Rectangle and y position
        stroke(140);
        strokeWeight(0.5);
        fill(#D4DAFA);
        color(int(getConfigurationString("graph1")));
        line(xPos + 1, ylocation, xPos+Width - 1, ylocation);
        rect(xPos-62, ylocation-6, 55, 12);
        textAlign(RIGHT);
        fill(0);
        textSize(8);
        text(map(ylocation, yPos+Height, yPos, yMin, yMax), xPos - 10, ylocation+4);

        if (RightAxis) {
          if (statusconnect) {
            stroke(140);
            strokeWeight(0.5);
            fill(#D4DAFA);
            color(int(getConfigurationString("graph1")));
            rect(xPos+Width+10, ylocation-6, 26, 12);
            textAlign(LEFT);
            fill(0);
            textSize(8);
            text(int(map(ylocation, yPos+Height, yPos, yMinRight, yMaxRight)), xPos+Width+12, ylocation + 4);
          }
        }
      }
    }
  }
}
