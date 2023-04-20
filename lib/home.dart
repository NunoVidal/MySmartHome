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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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

/*
for (var i = 0; i < lamps.length; i++)
              ElevatedCard(
                name: lamps[i].name,
                type: "lamp",
                nDevices: lamps.length,
                notifyParent: () {},
              )

              icon: const Icon(
                  Icons.lightbulb_outline,
                  size: 40.0,
                )
              */