// We can connect to the database through a server or in embedded mode.

// If we access through a server, it must be running.
void startServer() {
  try {
    // Initialize and start the network server
    server = new NetworkServerControl();
    server.start(null);
    println("Server started");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Stops the running server
void stopServer() {
  try {
    // Check if the server is running and shut it down
    if (server != null)
      server.shutdown();
    println("Server stopped");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Opens the database via server connection
void openDBbyServer(String db2Open) {
  try {
    statusdb = true;
    // Connect to the database using the server address
    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/" + db2Open + ";create=true");
    stmt = conn.createStatement();
    println("DB is open");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Closes the database via server connection
void closeDBbyServer() {
  try {
    if (conn != null) {
      statusdb = false;
      // Retrieve the connection URL
      String myURL = conn.getMetaData().getURL();
      // Shutdown the database
      DriverManager.getConnection(myURL + ";shutdown=true");
      conn.close();
      print("DB is closed");
    }
  }
  catch (Exception e) {
    // Silence the exception for shutdown errors
  }
}

// Opens the embedded database
void openEmbeddedDB(String db2Open) {
  try {
    statusdb = true;
    // Connect to the embedded database
    conn = DriverManager.getConnection("jdbc:derby:" + db2Open + ";create=true");
    stmt = conn.createStatement();
    print("DB is open");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Closes the embedded database
void closeEmbeddedDB(String db2Close) {
  try {
    statusdb = false;
    // Shutdown the embedded database
    conn = DriverManager.getConnection("jdbc:derby:" + db2Close + ";shutdown=true");
    stmt = conn.createStatement();
    print("DB is closed");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Deletes a table from the database
void deleteTable(String tableName) {
  try {
    // Execute the SQL statement to drop the table
    stmt.execute("drop table " + tableName);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Displays the contents of the database
public void databaseview() {
  try {
    stmt = conn.createStatement();
    String sql = "SELECT * from TUTTIBLOBS";
    ResultSet rs = stmt.executeQuery(sql);
    File tempFile = null;

    while (rs.next()) {
      String mode = rs.getString("MODE");

      switch (mode) {
      case "Blob":
        filename = rs.getString("FILENAME");
        tempFile = File.createTempFile("exp", filename, new File(dataout));
        Blob blob = rs.getBlob("IMAGE");
        copyFile(new FileOutputStream(tempFile), blob.getBinaryStream());
        break;

      default:
        // Handle other modes if necessary
      }
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Creates a table for storing blobs in the database
void createBlobsTable() {
  String order0 = "DROP TABLE TUTTIBLOBS "; // SQL statement to drop the table
  String order1 = "CREATE TABLE TUTTIBLOBS " +
    "(IDKEY INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY " +
    "(START WITH 1, INCREMENT BY 1)," +  // Autoincrement field
    "MODE VARCHAR(10), " +     // Mode can be Stream or Blob
    "FILENAME VARCHAR(50), " + // Save the file name
    "IMAGE BLOB)";             // BLOB data
  String order2 = "ALTER TABLE TUTTIBLOBS ADD CONSTRAINT ANYNAME PRIMARY KEY (IDKEY)"; // Primary key constraint

  try {
    stmt.execute(order0);
  }
  catch (Exception e) {
    // Ignore if there is no table to delete
  }

  try {
    stmt.execute(order1);
    stmt.execute(order2);
  }
  catch (SQLSyntaxErrorException s) {
    // Ignore syntax errors related to table creation
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Loads an image into the database
void loadImageIntoDB(String fileName, String mode) {
  try {
    PreparedStatement ps = conn.prepareStatement("INSERT INTO TUTTIBLOBS(MODE, FILENAME, IMAGE) " +
      "VALUES (?, ?, ?)");
    ps.setString(1, mode);
    ps.setString(2, fileName);

    File file2Load = new File(dirResources + "/" + fileName);

    if (mode.equals("Stream")) {
      InputStream fInStream = new FileInputStream(file2Load);
      ps.setBinaryStream(3, fInStream);
    } else if (mode.equals("Blob")) {
      Blob blob = conn.createBlob();
      copyFile(blob.setBinaryStream(1), new FileInputStream(file2Load));
      ps.setBlob(3, blob);
    }

    ps.executeUpdate();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

// Copies data from an input stream to an output stream
void copyFile(OutputStream os, InputStream is) throws IOException {
  BufferedOutputStream bos = new BufferedOutputStream(os);
  BufferedInputStream bis = new BufferedInputStream(is);

  int aByte;
  while ((aByte = is.read()) != -1) {
    bos.write(aByte);
  }

  bis.close();
  bos.close();
}
