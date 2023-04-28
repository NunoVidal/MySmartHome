import 'package:flutter/material.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            DeviceGroupElevatedCard(
              icon: const Icon(
                Icons.lightbulb,
                size: 40.0,
              ),
              name: "Lighting",
              nDevices: lamps.length,
            )
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
