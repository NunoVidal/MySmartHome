import 'package:flutter/material.dart';
import 'package:smart_home_app/home.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class DeviceList extends StatefulWidget {
  final String type;
  const DeviceList({super.key, required this.type});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    if (super.widget.type == "lighting") {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              for (var i = 0; i < lamps.length; i++)
                DeviceElevatedCard(name: lamps[i].name, id: lamps[i].id)
            ],
          ),
        ),
        drawer: const NavBar(),
      );
    } else {
      return const Scaffold();
    }
  }
}
