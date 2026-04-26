// If you want to debug the plotter without using a real serial port

// Variables for mockup values
float mockupValue = random(50); // Initialize mockupValue with a random value between 0 and 50
float mockupDirection = random(5); // Initialize mockupDirection with a random value between 0 and 5

/**
 * Generates mockup serial data for debugging purposes.
 *
 * @return A string representing the mockup serial data.
 */
String mockupSerialFunction() {

  // Update mockupValue by adding mockupDirection
  mockupValue = (mockupValue + mockupDirection);

  // Change direction if mockupValue exceeds certain random thresholds
  if (mockupValue > random(160))
    mockupDirection = random(-10); // Change direction to negative if value is too high
  else if (mockupValue < random(-150))
    mockupDirection = random(10); // Change direction to positive if value is too low

  String r = ""; // Initialize the result string

  // Generate mockup data for 14 parameters
  for (int i = 0; i < 14; i++) {
    switch (i) {
    case 0:
      r += mockupValue + " "; // Add mockupValue to the result string
      break;
    case 1:
      r += 100 * cos(mockupValue * (3 * 3.14) / random(1003)) + " "; // Calculate and add a cosine-based value
      break;
    case 2:
      r += 10 * mockupValue * 3 / random(464) + " "; // Calculate and add a scaled value
      break;
    case 3:
      r += 50 * mockupValue * 4 / random(556) + " "; // Calculate and add another scaled value
      break;
    case 4:
      r += 20 * mockupValue * 8 / random(346) + 1 + " "; // Calculate and add a scaled value with an offset
      break;
    case 5:
      r += 1536 * sin(mockupValue * 7) / random(275) + 2 + " "; // Calculate and add a sine-based value with an offset
      break;
    case 6:
      r += 5 * mockupValue * 50 / random(185) + " "; // Calculate and add another scaled value
      break;
    case 7:
      r += 500 * mockupValue * 8 / random(56) + " "; // Calculate and add another scaled value
      break;
    case 8:
      r += 50 * mockupValue * 8 / random(2) + " "; // Calculate and add another scaled value
      break;
    case 9:
      r += mockupValue / random(3) + " "; // Calculate and add a simple division-based value
      break;
      // Cases 10 to 13 are not specified, and thus, no value is added for these indices.
    }

    if (i < 13) // Add a comma between the values, except after the last value
      r += ',';
  }

  return r; // Return the generated mockup data string
}
