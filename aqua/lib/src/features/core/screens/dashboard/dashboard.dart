import 'package:aqua/src/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("sensorData");

  double tdsValue = 0.0;
  double temperature = 0.0;
  double waterLevelValue = 0.0;

  String temperatureStatus = "Unknown";
  String tdsStatus = "Unknown";
  int waterLevelStatus = 0;

  @override
  void initState() {
    super.initState();

    _databaseReference.onValue.listen((event) {
      try {
        var data = event.snapshot.value as Map<String, dynamic>?;

        if (data != null) {
          print("Data from Firebase: $data");

          setState(() {
            tdsValue = data["tdsValue"]?.toDouble() ?? 0.0;
            temperature = data["temperature"]?.toDouble() ?? 0.0;
            waterLevelValue = data["waterLevelValue"]?.toDouble() ?? 0.0;

            temperatureStatus = data["temperatureStatus"] ?? "Unknown";
            tdsStatus = data["tdsStatus"] ?? "Unknown";
            waterLevelStatus = data["waterLevelStatus"] ?? 0;
          });
        }
      } catch (e) {
        print("Error: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title:
            Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tCardBgColor),
            child: IconButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              icon: const Image(image: AssetImage(tUserProfileImage)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tDashboardTitle, style: txtTheme.bodyMedium),
              Text(tDashboardHeading, style: txtTheme.displayMedium),
              const SizedBox(height: tDashboardPadding),
              const Divider(),
              const SizedBox(height: 10),
              _buildSensorCard("TDS Value", tdsValue, tdsStatus),
              _buildSensorCard("Temperature", temperature, temperatureStatus),
              _buildSensorCard("Water Level", waterLevelValue,
                  waterLevelStatus == 0 ? "Below Optimal" : "Optimal"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard(String label, double value, String status) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Value: ${value.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue, // You can customize the color
                  ),
                ),
                Text(
                  'Status: $status',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green, // Customize the color based on status
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
