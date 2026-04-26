void ethernet_com() {
  EthernetServer server(serverport);

  if (!startethernet) {
    server.begin();
    startethernet = true;
  }

  EthernetClient client = server.available();
  if (client) {
    ativ_start = true;
    String request = client.readStringUntil('\r');
    client.flush();

    if (request.indexOf("GET /data") >= 0) {
      serveData(client);
    } else if (request.indexOf("GET /control?") >= 0) {
      handleControl(request);
      serveData(client);
      servePin4Status(client);
    } else if (request.indexOf("GET /status") >= 0) {

    } else {
      servePage(client);
    }
    client.stop();
  }
}

void serveData(EthernetClient client) {
  ap = (value0 * float(span0 * 0.0001)) + float(zero0 * 0.1);
  bp = (value1 * float(span1 * 0.0001)) + float(zero1 * 0.1);
  cp = (value2 * float(span2 * 0.0001)) + float(zero2 * 0.1);
  dp = (value3 * float(span3 * 0.0001)) + float(zero3 * 0.1);
  ep = (value4 * float(span4 * 0.0001)) + float(zero4 * 0.1);
  fp = (value5 * float(span5 * 0.0001)) + float(zero5 * 0.1);

  int rpmvirt = map(val_1_ethernet, 0, 1023, 0, maxspeed * 100);
  torqueout = (rpmvirt - filtered6 >= 0) ? (rpmvirt - filtered6) * (float(motorpower) / (float(maxspeed) * 100)) : 0;

  client.println(F("HTTP/1.1 200 OK"));
  client.println(F("Content-Type: text/plain"));
  client.println(F("Connection: close"));
  client.println();

  client.print(ap); client.print(F(";"));
  client.print(bp); client.print(F(";"));
  client.print(cp); client.print(F(";"));
  client.print(dp); client.print(F(";"));
  client.print(ep); client.print(F(";"));
  client.print(fp); client.print(F(";"));
  client.print(value9); client.print(F(";"));
  client.println(torqueout);
}

void handleControl(String request) {
  if (request.indexOf("RELAY1") >= 0) {
    digitalWrite(Pin6, !digitalRead(Pin6));
  } else if (request.indexOf("RELAY2") >= 0) {
    digitalWrite(Pin7, !digitalRead(Pin7));
  } else if (request.indexOf("DIGITALOUT1") >= 0) {
    digitalWrite(Pin8, !digitalRead(Pin8));
  } else if (request.indexOf("DIGITALOUT2") >= 0) {
    digitalWrite(Pin9, !digitalRead(Pin9));
  } else if (request.indexOf("temperature=") >= 0) {
    val_0_ethernet = request.substring(request.indexOf('=') + 1).toInt();
  } else if (request.indexOf("speed=") >= 0) {
    val_1_ethernet = request.substring(request.indexOf('=') + 1).toInt();
  }
}

void servePage(EthernetClient client) {
  client.println(F("HTTP/1.1 200 OK"));
  client.println(F("Content-Type: text/html"));
  client.println(F("Connection: close"));
  client.println();
  client.println(F("<html><head><title>SD PLOTTER DB</title>"));
  client.println(F("<link rel='icon' href='https://archive.org/download/SDPlotterDB/sdplotterdb.png' type='image/png'>"));
  client.println(F("<style>"));
  client.println(F("body {font-family: Arial, sans-serif; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #f0f0f0;}"));
  client.println(F(".container {display: flex; flex-direction: column; align-items: center; background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); max-width: 600px; width: 100%;}"));
  client.println(F("img {max-width: 50%; height: auto; border-radius: 10px;}"));
  client.println(F("h1 {margin-top: 0;}"));
  client.println(F(".buttons {display: flex; flex-direction: column; align-items: center; width: 100%; margin-top: 20px;}"));
  client.println(F(".buttons button {background-color: #4CAF50; color: white; padding: 15px 20px; margin: 5px 0; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;}"));
  client.println(F(".buttons button:hover {background-color: #45a049;}"));
  client.println(F(".sliders {width: 100%; margin-top: 20px;}"));
  client.println(F(".sliders label {display: block; margin-bottom: 5px;}"));
  client.println(F(".sliders input {width: 100%; margin-bottom: 20px;}"));
  client.println(F(".sliders input[type='range'] { -webkit-appearance: none; width: 100%; height: 10px; background: #ddd; outline: none; opacity: 0.7; -webkit-transition: .2s; transition: opacity .2s; }"));
  client.println(F(".sliders input[type='range']::-webkit-slider-thumb { -webkit-appearance: none; appearance: none; width: 25px; height: 25px; cursor: pointer; }"));
  client.println(F("#temperature::-webkit-slider-thumb { background-color: #FF00FC; }"));
  client.println(F("#temperature::-moz-range-thumb { background-color: #FF00FC; }"));
  client.println(F("#speed::-webkit-slider-thumb { background-color: #FF1797; }"));
  client.println(F("#speed::-moz-range-thumb { background-color: #FF1797; }"));

  client.println(F(".switch { position: relative; display: inline-block; width: 60px; height: 34px; }"));
  client.println(F(".switch input { opacity: 0; width: 0; height: 0; }"));
  client.println(F(".slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 34px; }"));
  client.println(F(".slider:before { position: absolute; content: ''; height: 26px; width: 26px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }"));
  client.println(F("input:checked + .slider { background-color: #2196F3; }"));
  client.println(F("input:checked + .slider:before { transform: translateX(26px); }"));

  client.println(F("</style><script>"));
  client.println(F("let recording = false;"));
  client.println(F("let csvData = '';"));

  client.println(F("function fetchData() {"));
  client.println(F("var xhr = new XMLHttpRequest();"));
  client.println(F("xhr.onreadystatechange = function() {"));
  client.println(F("if (xhr.readyState == 4 && xhr.status == 200) {"));
  client.println(F("let data = xhr.responseText.trim();"));
  client.println(F("let values = data.split(';');"));
  client.print(F("document.getElementById('data').innerHTML = '<b><font color=\"#FF0000\">PROBE 1: </font></b>' + values[0] + ' ")); client.print(unit0); client.print(F("<br />' + '<b><font color=\"#D88F2E\">PROBE 2: </font></b>' + values[1] + ' ")); client.print(unit1); client.print(F("<br />' + '<b><font color=\"#E0CA00\">PROBE 3: </font></b>' + values[2] + ' ")); client.print(unit2); client.print(F("<br />' + '<b><font color=\"#00D356\">PROBE 4: </font></b>' + values[3] + ' ")); client.print(unit3); client.print(F("<br />' + '<b><font color=\"#6978FF\">PROBE 5: </font></b>' + values[4] + ' ")); client.print(unit4); client.print(F("<br />' + '<b><font color=\"#FF00FC\">TEMPERATURE: </font></b>' + values[5] + ' ")); client.print(unit5); client.print(F("<br />' + '<b><font color=\"#FF1797\">SPEED: </font></b>' + values[6] + ' RPM<br />' + '<b><font color=\"#FF95AB\">TORQUE: </font></b>' + values[7] + ' Ncm';"));

  client.println(F("if (recording) {"));
  client.println(F("let currentTime = new Date().toLocaleTimeString();"));
  client.println(F("csvData += currentTime + ';' + data + '\\n';"));
  client.println(F("}"));

  client.println(F("}"));
  client.println(F("};"));
  client.println(F("xhr.open('GET', '/data', true);"));
  client.println(F("xhr.send();"));
  client.println(F("}"));
  client.println(F("setInterval(fetchData, 1000);"));

  client.println(F("function sendCommand(command) {"));
  client.println(F("var xhr = new XMLHttpRequest();"));
  client.println(F("xhr.open('GET', '/control?' + command, true);"));
  client.println(F("xhr.send();"));
  client.println(F("}"));

  client.println(F("function updatePWM(pin, value) {"));
  client.println(F("var xhr = new XMLHttpRequest();"));
  client.println(F("xhr.open('GET', '/control?' + pin + '=' + value, true);"));
  client.println(F("xhr.send();"));
  client.println(F("document.getElementById(pin + '_value').innerText = Math.round((value / 1023) * 100) + '%';"));
  client.println(F("}"));

  client.println(F("function startRecording() {"));
  client.println(F("recording = true;"));
  client.println(F("csvData = 'SDPlotterDB - Web Socket\\n';"));
  client.println(F("csvData += 'Time;Probe 1;Probe 2;Probe 3;Probe 4;Probe 5;Temperature;Speed;Torque\\n';"));
  client.println("csvData += ';" + unit0 + ";" + unit1 + ";" + unit2 + ";" + unit3 + ";" + unit4 + ";" + unit5 + ";RPM;Ncm\\n';");
  client.println(F("document.getElementById('recording-status').innerText = 'Recording...';"));
  client.println(F("}"));

  client.println(F("function stopRecording() {"));
  client.println(F("if (recording) {"));
  client.println(F("recording = false;"));
  client.println(F("document.getElementById('recording-status').innerText = 'Not recording.';"));
  client.println(F("downloadCSV();"));
  client.println(F("}"));
  client.println(F("}"));

  client.println(F("function downloadCSV() {"));
  client.println(F("var blob = new Blob([csvData], { type: 'text/csv' });"));
  client.println(F("var url = URL.createObjectURL(blob);"));
  client.println(F("var a = document.createElement('a');"));
  client.println(F("a.setAttribute('href', url);"));
  client.println(F("a.setAttribute('download', 'SDPlotterDB.csv');"));
  client.println(F("a.click();"));
  client.println(F("}"));

  client.println(F("function fetchStatuses() {"));
  client.println(F("document.getElementById('relay1-status').innerText = digitalRead(Pin6) == LOW ? 'ON' : 'OFF';"));
  client.println(F("document.getElementById('relay2-status').innerText = digitalRead(Pin7) == LOW ? 'ON' : 'OFF';"));
  client.println(F("document.getElementById('digitalout1-status').innerText = digitalRead(Pin8) == HIGH ? 'ON' : 'OFF';"));
  client.println(F("document.getElementById('digitalout2-status').innerText = digitalRead(Pin9) == HIGH ? 'ON' : 'OFF';"));
  client.println(F("}"));
  client.println(F("setInterval(fetchStatuses, 1000);"));

  client.println(F("function checkStartRec() {"));
  client.println(F("if (digitalRead(Pin4) == HIGH) {"));
  client.println(F("startRecording();"));
  client.println(F("}"));
  client.println(F("if (digitalRead(Pin5) == HIGH) {"));
  client.println(F("stopRecording();"));
  client.println(F("}"));
  client.println(F("}"));
  client.println(F("setInterval(checkStartRec, 1000);"));

  client.println(F("</script></head><body><div class='container'><h1>SD PLOTTER DB</h1>"));
  client.println(F("<img src=\"https://archive.org/download/SDPlotterDB/sdplotterdb.png\" alt='SD Plotter DB' />"));
  client.println(F("<HR SIZE=18 color=#FF0000><div id='data'></div>"));
  client.println(F("<div class='sliders'>"));
  client.println(F("<label for='temperature'>TEMPERATURE:</label>"));
  client.print(F("<input type='range' id='temperature' name='temperature' min='0' max='1023' value='")); client.print(val_0_ethernet); client.println(F("' oninput=\"updatePWM('temperature', this.value)\"><span id='temperature_value'>")); client.print(map(output1, 0, 1023, 0, 100)); client.println(F("%</span>"));
  client.println(F("<label for='speed'>SPEED:</label>"));
  client.print(F("<input type='range' id='speed' name='speed' min='0' max='1023' value='")); client.print(val_1_ethernet); client.println(F("' oninput=\"updatePWM('speed', this.value)\"><span id='speed_value'>")); client.print(map(output2, 0, 1023, 0, 100)); client.println(F("%</span>"));
  client.println(F("<HR SIZE=7><b></div>"));
  client.println(F("<div class='buttons'>"));
  client.println(F("<label>Relay 1</label><label class='switch'><input type='checkbox' onclick=\"sendCommand('RELAY1=toggle')\"><span class='slider'></span></label><span id='relay1-status'></span>"));
  client.println(F("<label>Relay 2</label><label class='switch'><input type='checkbox' onclick=\"sendCommand('RELAY2=toggle')\"><span class='slider'></span></label><span id='relay2-status'></span>"));
  client.println(F("<label>Digital Out 1</label><label class='switch'><input type='checkbox' onclick=\"sendCommand('DIGITALOUT1=toggle')\"><span class='slider'></span></label><span id='digitalout1-status'></span>"));
  client.println(F("<label>Digital Out 2</label><label class='switch'><input type='checkbox' onclick=\"sendCommand('DIGITALOUT2=toggle')\"><span class='slider'></span></label><span id='digitalout2-status'></span>"));
  client.println(F("<HR SIZE=7><b></div>"));
  client.println(F("<div class='buttons'>"));
  client.println(F("<button onclick=\"startRecording()\">START RECORD</button>"));
  client.println(F("<button onclick=\"stopRecording()\">STOP RECORD</button>"));
  client.println(F("<div id='recording-status' style='color:blue; font-weight:bold; margin-top: 10px;'>Not recording.</div>"));
  client.println(F("</div>"));
  client.println(F("<HR SIZE=7><b>START METHOD: </b>")); client.print(digitalRead(Pin4) == HIGH ?  F("ON") : F("OFF")); client.println(F("<br /><br />"));
  client.println(F("<b>START REC DATA: </b>")); client.print(digitalRead(Pin5) == HIGH ?   F("ON") : F("OFF")); client.println(F("<br /><br />"));
  client.println(F("</div></body></html>"));
}

void servePin4Status(EthernetClient client) {
  client.println(F("HTTP/1.1 200 OK"));
  client.println(F("Content-Type: text/plain"));
  client.println(F("Connection: close"));
  client.println();
  client.println(digitalRead(Pin4) == HIGH ? F("HIGH") : F("LOW"));
  client.println(F("startRecording()"));
}
