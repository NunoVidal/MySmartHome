import 'package:flutter/material.dart';
import 'package:smart_home_app/devices.dart';
import 'package:smart_home_app/blind.dart';
import 'package:smart_home_app/light.dart';
import 'package:smart_home_app/my_devices.dart';
import 'package:smart_home_app/sensor.dart';

import 'home.dart';
import 'device_list.dart';

import 'dart:math';

void main() {
  lamps[0].schedule.add(LampProgram(const Color.fromARGB(195, 100, 25, 200),
      true, "1:20", "2023-05-15", "15:00", "1 week"));

  Map<DateTime, double> values = {};
  final random = Random();

  final startDate = DateTime(2023, 05, 02, 0, 0, 0);
  final endDate = DateTime(2023, 05, 20, 23, 50, 0);

  final difference = endDate.difference(startDate).inMinutes;
  final numberOfIntervals = (difference / 5).ceil();

  for (int i = 0; i < numberOfIntervals; i++) {
    final currentDate = startDate.add(Duration(minutes: i * 5));
    final randomDouble = random.nextDouble() * 100;
    values[currentDate] = randomDouble;
  }

  values[DateTime(2023, 5, 10, 11, 0, 0)] = 77.5;
  values[DateTime(2023, 5, 10, 11, 05, 0)] = 70;
  values[DateTime(2023, 5, 10, 11, 10, 0)] = 67.3;
  values[DateTime(2023, 5, 10, 11, 15, 0)] = 65;
  values[DateTime(2023, 5, 10, 11, 20, 0)] = 66.2;
  values[DateTime(2023, 5, 10, 11, 25, 0)] = 68;
  values[DateTime(2023, 5, 10, 11, 30, 0)] = 71.2;
  values[DateTime(2023, 5, 10, 11, 35, 0)] = 72.1;
  values[DateTime(2023, 5, 10, 11, 40, 0)] = 77.1;
  values[DateTime(2023, 5, 10, 11, 45, 0)] = 76.4;
  values[DateTime(2023, 5, 10, 11, 50, 0)] = 79.4;
  values[DateTime(2023, 5, 10, 11, 55, 0)] = 72;
  values[DateTime(2023, 5, 10, 12, 00, 0)] = 75.2;

  sensores[0].createHistory(values);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/device_list_Lighting': (context) =>
            const DeviceList(type: "lighting"),
        '/device_list_Blindings': (context) => const DeviceList(type: "blind"),
        '/device_list_Sensors': (context) => const DeviceList(type: "Sensor"),
        '/light': (context) => const LightState(),
        '/blind': (context) => const BlindState(),
        "/sensor": (context) => const SensorState(),
      },
    );
  }
}
