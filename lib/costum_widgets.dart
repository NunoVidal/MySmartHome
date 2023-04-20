import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

import 'my_devices.dart';

class DeviceGroupElevatedCard extends StatelessWidget {
  final String name;
  final Icon icon;
  final int nDevices;

  const DeviceGroupElevatedCard(
      {Key? key,
      required this.name,
      required this.icon,
      required this.nDevices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: icon,
              title: Text(name),
              subtitle: Text("$nDevices devices"),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/device_list_$name',
                  );
                },
                child: const Text("Device List"),
              ),
              const SizedBox(width: 8),
              const PopupMenu(),
            ]),

            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                PopupMenu(),
              ],
            ),
            */
          ],
        ),
      ),
      onTap: () => {},
    ));
  }
}

class DeviceElevatedCard extends StatelessWidget {
  final String name;
  final int id;

  const DeviceElevatedCard({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LightConfig(deviceId: id),
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/light', arguments: id);
      },
    ));
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Oflutter.com'),
            accountEmail: const Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, 'device_list');
            },
          ),
        ],
      ),
    );
  }
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({
    super.key,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

enum SampleItem { delete, moreInfo }

class _PopupMenuState extends State<PopupMenu> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.delete,
          child: Text('delete'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.moreInfo,
          child: Text('info'),
        ),
      ],
    );
  }
}

class SwitchExample extends StatefulWidget {
  final int deviceId;
  const SwitchExample({super.key, required this.deviceId});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    bool light0 = lamps[widget.deviceId].state;
    return Switch(
      value: light0,
      onChanged: (bool value) {
        setState(() {
          light0 = value;
          lamps[widget.deviceId].state = light0;
        });
      },
    );
  }
}

// Widget with all the options for a light configuration
class LightConfig extends StatefulWidget {
  final int deviceId;
  const LightConfig({super.key, required this.deviceId});

  @override
  State<LightConfig> createState() => _LightConfigState();
}

class _LightConfigState extends State<LightConfig> {
  final _formKey = GlobalKey<FormState>();
  Color pickerColor = Color(0xffff0000);
  Color currentColor = Color(0xffff0000);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    lamps[widget.deviceId].color = color;
  }

  @override
  Widget build(BuildContext context) {
    currentColor = lamps[widget.deviceId].color;
    pickerColor = lamps[widget.deviceId].color;
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5),
              height: 35,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Select'),
                          onPressed: () {
                            setState(() => currentColor = pickerColor);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          SwitchExample(deviceId: widget.deviceId),
        ],
      ),
    );
  }
}

class ExplicitLightConfig extends StatefulWidget {
  final int deviceId;
  const ExplicitLightConfig({super.key, required this.deviceId});

  @override
  State<ExplicitLightConfig> createState() => _ExplicitLightConfigState();
}

class _ExplicitLightConfigState extends State<ExplicitLightConfig> {
  Color pickerColor = Color(0xffff0000);
  Color currentColor = Color(0xffff0000);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    lamps[widget.deviceId].color = color;
  }

  @override
  Widget build(BuildContext context) {
    currentColor = lamps[widget.deviceId].color;
    pickerColor = lamps[widget.deviceId].color;
    return Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 30.0),
        child: Column(children: [
          Row(
            children: const [
              Icon(Icons.color_lens_outlined),
              Text('Color'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
          Divider(color: Colors.black),
          Row(
            children: const [
              Icon(Icons.timer_outlined),
              Text('Timer'),
            ],
          ),
          TimerPicker(
              externalAction: (value) {
                lamps[widget.deviceId].timer =
                    '${(value).round()}:${(value * 10 % 10).round()}';
                lamps[widget.deviceId].timerDouble = value;
              },
              deviceId: widget.deviceId)
        ]));
  }
}

class GFG extends StatefulWidget {
  const GFG({Key? key}) : super(key: key);

  @override
  State<GFG> createState() => _GFGState();
}

class _GFGState extends State<GFG> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(15),
              height: 100,
              child: Center(
                child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Got it'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              )),
          Container(
              padding: const EdgeInsets.all(15),
              height: 100,
              child: Center(
                  child: TextField(
                controller:
                    dateController, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                    setState(() {
                      dateController.text =
                          formattedDate; //set foratted date to TextField value.
                    });
                  }
                },
              ))),
          Container(
              padding: const EdgeInsets.all(15),
              height: 100,
              child: Center(
                  child: TextField(
                controller:
                    timeController, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.access_time_rounded), //icon of text field
                    labelText: "Enter Hour" //label text of field
                    ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    setState(() {
                      timeController.text = pickedTime.format(context);
                    });
                  }
                },
              ))),
        ],
      ),
    );
  }
}

class TimerPicker extends StatefulWidget {
  final Function externalAction;
  final int deviceId;
  const TimerPicker(
      {Key? key, required this.externalAction, required this.deviceId})
      : super(key: key);

  @override
  State<TimerPicker> createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecimalNumberPicker(
          value: lamps[widget.deviceId].timerDouble,
          minValue: 0,
          maxValue: 99,
          onChanged: (value) {
            setState(() => _currentValue = value);
            widget.externalAction(value);
          },
        ),
        //Text('Current value: $_currentValue'),
      ],
    );
  }
}
