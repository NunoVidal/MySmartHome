import 'package:flutter/material.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class DeviceList extends StatefulWidget {
  final String type;
  const DeviceList({super.key, required this.type});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  refresh() async {
    setState(() {});
  }

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
                DeviceElevatedCard(
                  name: lamps[i].name,
                  id: lamps[i].id,
                  deviceType: "light",
                  updateParent: refresh,
                )
            ],
          ),
        ),
        drawer: const NavBar(),
      );
    
    } 
    
     else if (super.widget.type == "Sensor"){
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
              //for (var i = 0; i < blinds.length; i++){
              //  DeviceElevatedCard(name: blinds[i].name, id: blinds[i].id)
              //}
              for (var i = 0; i < sensores.length; i++)
                DeviceElevatedCard(
                  name: sensores[i].name,
                  id: sensores[i].id,
                  deviceType: "sensor",
                  updateParent: refresh,
                )
            ],
          ),
        ),
        drawer: const NavBar(),
      );
    }else{
      return const Scaffold();
    }
  }
}
