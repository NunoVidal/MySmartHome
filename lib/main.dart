import 'package:flutter/material.dart';
import 'package:smart_home_app/devices.dart';
import 'package:smart_home_app/light.dart';
import 'package:smart_home_app/my_devices.dart';

import 'home.dart';
import 'device_list.dart';

void main() {
  lamps[0].schedule.add(LampProgram(const Color.fromARGB(195, 100, 25, 200),
      true, "1:20", "10-06-2023", "15PM", "1 week"));
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
        '/light': (context) => const LightState(),
      },
    );
  }
}
