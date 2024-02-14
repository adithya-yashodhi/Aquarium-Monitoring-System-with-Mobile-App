#include <WiFi.h>
#include <Wire.h>
#include <OneWire.h>
#include <DallasTemperature.h> //simplify the process of read temperature value from temperature sensor
#include <ESP32Firebase.h>

const int tdsSensorPin = 35; // Pin configuration
const int tempSensorPin = 2;
const int waterLevelPin = 34;

OneWire oneWire(tempSensorPin); // Setup DS18B20 sensor
DallasTemperature sensors(&oneWire);

#define _SSID "Your_WIFI_NAME"
#define _PASSWORD "YOUR_WIFI_PASSWORD"
#define REFERENCE_URL "FIREBASE_PROJECT_URL"

Firebase firebase(REFERENCE_URL);

void setup() {
  Serial.begin(115200);
  pinMode(tdsSensorPin, INPUT);
  pinMode(waterLevelPin, INPUT);
  sensors.begin();   // Start DS18B20 sensor

  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(1000);

  // Connect to WiFi
  Serial.println();
  Serial.println();
  Serial.print("Connecting to: ");
  Serial.println(_SSID);
  WiFi.begin(_SSID, _PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print("-");
  }

  Serial.println("");
  Serial.println("WiFi Connected");

  // Print the IP address
  Serial.print("IP Address: ");
  Serial.print(WiFi.localIP());
  Serial.println("/");
}

void loop() {
  float tdsValue = analogRead(tdsSensorPin);   // Read TDS sensor
  sensors.requestTemperatures();   // Read DS18B20 sensor
  float temperature = sensors.getTempCByIndex(0);
  float waterLevelValue = analogRead(waterLevelPin);

  // Convert analog readings to meaningful values
  String temperatureStatus = getTemperatureStatus(temperature);
  String tdsStatus = getTDSStatus(tdsValue);
  String waterLevelStatus = getWaterLevelStatus(waterLevelValue);

  // Send data to Firebase
  firebase.setFloat("sensorData/temperature/value", temperature);
  firebase.setString("sensorData/temperature/status", temperatureStatus);
  
  firebase.setFloat("sensorData/tds/value", tdsValue);
  firebase.setString("sensorData/tds/status", tdsStatus);
  
  firebase.setFloat("sensorData/waterLevel/value", waterLevelValue);
  firebase.setString("sensorData/waterLevel/status", waterLevelStatus);

  // Print data to Serial Monitor
   Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.print(" | Temperature Status: ");
  Serial.print(temperatureStatus);
  Serial.print(" | TDS Value: ");
  Serial.print(tdsValue);
  Serial.print(" | TDS Status: ");
  Serial.print(tdsStatus);
  Serial.print(" | Water Level: ");
  Serial.print(waterLevelValue);
  Serial.print(" | Water Level Status: ");
  Serial.println(waterLevelStatus);


  delay(1000); // Adjust the delay based on your needs
}

String getTemperatureStatus(float temperature) {
  if (temperature < 23) {
    return "Low";
  } else if (temperature >= 23 && temperature <= 30) {
    return "Normal";
  } else {
    return "High";
  }
}

String getTDSStatus(float tdsValue) {
  if (tdsValue < 400) {
    return "Low";
  } else if (tdsValue >= 400 && tdsValue <= 450) {
    return "Normal";
  } else {
    return "High";
  }
}

String getWaterLevelStatus(float waterLevelValue) {
  float lowThreshold = 300.0;
  float highThreshold = 700.0;

  if (waterLevelValue < lowThreshold) {
    return "Low";
  } else if (waterLevelValue >= lowThreshold && waterLevelValue < highThreshold) {
    return "Medium";
  } else {
    return "High";
  }
}
