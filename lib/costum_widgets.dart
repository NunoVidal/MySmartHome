import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'my_devices.dart';
import 'devices.dart';

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
              //const PopupMenu(),
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
  final String deviceType;
  final Function updateParent;

  const DeviceElevatedCard({
    Key? key,
    required this.name,
    required this.id,
    required this.deviceType,
    required this.updateParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (deviceType == 'light') {
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
          Navigator.pushNamed(context, '/light', arguments: id)
              .then((result) => updateParent());
        },
      ));
    } else if (deviceType == "blind") {
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
                    Text(
                        "${blinds[id].state.toInt()}%"),
                    const SizedBox(
                      width: 30,
                    ),
                    //const PopupMenu(),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/blind', arguments: id)
              .then((result) => updateParent());
        },
      ));
    } else if (deviceType == "sensor") {
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
                    Text(
                        "${sensores[id].currentVal.toString()} ${sensores[id].unit}"),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(Icons.query_stats),
                    const PopupMenu(),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/sensor', arguments: id)
              .then((result) => updateParent());
        },
      ));
    } else {
      return Center(child: GestureDetector());
    }
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

enum SampleItem { delete, moreInfo, settings }

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
          if (selectedMenu == SampleItem.settings) {
            // Open a modal here.

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const SensorSettingsModal();
                });
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.settings,
          child: Text('Settings'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.delete,
          child: Text('Delete'),
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

class CostumActionSwitch extends StatefulWidget {
  final Function action;
  const CostumActionSwitch({super.key, required this.action});

  @override
  State<CostumActionSwitch> createState() => _CostumActionSwitchState();
}

class _CostumActionSwitchState extends State<CostumActionSwitch> {
  bool light0 = false;
  List<String> states = ["OFF", "ON"];

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
    return Row(children: [
      Switch(
        value: light0,
        onChanged: (bool value) {
          setState(() {
            light0 = value;
            widget.action(value);
          });
        },
      ),
      Text(states[light0 ? 1 : 0]),
    ]);
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
        margin: const EdgeInsets.only(bottom: 30.0, top: 10.0),
        child: Column(children: [
          Row(
            children: const [
              Icon(Icons.color_lens_outlined),
              Text(' Color'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ]));
  }
}

class CostumActionExplicitLightConfig extends StatefulWidget {
  final int deviceId;
  final Function colorChangeAction;
  final Function timerChangeAction;
  const CostumActionExplicitLightConfig(
      {super.key,
      required this.deviceId,
      required this.colorChangeAction,
      required this.timerChangeAction});

  @override
  State<CostumActionExplicitLightConfig> createState() =>
      _CostumActionExplicitLightConfigState();
}

class _CostumActionExplicitLightConfigState
    extends State<CostumActionExplicitLightConfig> {
  Color pickerColor = Color(0xffff0000);
  Color currentColor = Color(0xffff0000);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 0.0),
        child: Column(children: [
          Row(
            children: const [
              Icon(Icons.color_lens_outlined),
              Text(' Color'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              changeColor(color);
              widget.colorChangeAction(color);
            },
          ),
          const Divider(color: Colors.black),
          Row(
            children: const [
              Icon(Icons.timer_outlined),
              Text(' Timer'),
            ],
          ),
          TimerPicker(
            externalAction: widget.timerChangeAction,
            deviceId: widget.deviceId,
            initWithDevice: false,
          )
        ]));
  }
}

class TimerPicker extends StatefulWidget {
  final Function externalAction;
  final int deviceId;
  final bool initWithDevice;

  const TimerPicker({
    Key? key,
    required this.externalAction,
    required this.deviceId,
    required this.initWithDevice,
  }) : super(key: key);

  @override
  State<TimerPicker> createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  int currentValueMinutes = 0;
  int currentValueHours = 0;

  @override
  Widget build(BuildContext context) {
    currentValueHours = widget.initWithDevice
        ? lamps[widget.deviceId].timerHours
        : currentValueHours;
    currentValueMinutes = widget.initWithDevice
        ? lamps[widget.deviceId].timerMinutes
        : currentValueMinutes;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NumberPicker(
          value: currentValueHours,
          minValue: 0,
          maxValue: 99,
          onChanged: (value) {
            setState(() => currentValueHours = value);
            widget.externalAction(currentValueHours, currentValueMinutes);
          },
        ),
        const Text('hours'),
        NumberPicker(
          value: widget.initWithDevice
              ? lamps[widget.deviceId].timerMinutes
              : currentValueMinutes,
          minValue: 0,
          maxValue: 60,
          onChanged: (value) {
            setState(() => currentValueMinutes = value);
            widget.externalAction(currentValueHours, currentValueMinutes);
          },
        ),
        const Text('min')
      ],
    );
  }
}

class LightProgramShceduleModal extends StatefulWidget {
  final int deviceId;
  final Function? updateParent;
  const LightProgramShceduleModal(
      {Key? key, required this.deviceId, this.updateParent})
      : super(key: key);

  @override
  State<LightProgramShceduleModal> createState() =>
      _LightProgramShceduleModalState();
}

class _LightProgramShceduleModalState extends State<LightProgramShceduleModal> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String selectedRepeat = '0';
  String selectedRepeatUnit = 'days';
  String selectedTimer = '0:0';
  Color selectedColor = const Color.fromARGB(195, 0, 255, 179);
  bool selectedState = false;
  bool dateCheck = false;
  bool timeCheck = false;

  var selectUnit = ['days', 'weeks', 'months'];

  DateTime gPickedDate = DateTime.now();
  int gSelectedHour = -1;
  int gSelectedMinute = -1;

  @override
  Widget build(BuildContext context) {
    var lightId = widget.deviceId;
    var selectN = ['0'];

    for (int i = 1; i <= 30; i++) {
      selectN.add(i.toString());
    }

    return AlertDialog(
      title: const Text('Scheduler'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: const [Icon(Icons.light), Text('State')]),
                CostumActionSwitch(
                  action: (value) {
                    setState(() => selectedState = value);
                  },
                ),
              ],
            ),
            const Divider(color: Colors.black),
            CostumActionExplicitLightConfig(
              deviceId: lightId,
              colorChangeAction: (color) {
                setState(() => selectedColor = color);
              },
              timerChangeAction: (hours, minutes) {
                setState(() => selectedTimer = '$hours:$minutes');
              },
            ),
            const Divider(color: Colors.black),
            Row(
              children: const [
                Icon(Icons.repeat),
                Text(' Repeat'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Every  "),
                DropdownButton<String>(
                  // Initial Value
                  value: selectedRepeat,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: selectN.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeat = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  // Initial Value
                  value: selectedRepeatUnit,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: selectUnit.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeatUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Row(
              children: const [
                Icon(Icons.calendar_today),
                Text(' Date / Hour'),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(15),
                height: 100,
                child: Center(
                    child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.edit_calendar), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime
                            .now(), //not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      if (gSelectedHour != -1 && gSelectedMinute != -1) {
                        final selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            gSelectedHour,
                            gSelectedMinute);

                        if (selectedDateTime.isAfter(DateTime.now())) {
                          setState(() {
                            gPickedDate = pickedDate;
                            dateController.text = formattedDate;
                            dateCheck = true;
                            debugPrint((dateCheck).toString());
                          });
                        } else {
                          setState(() {
                            dateCheck = false;
                            dateController.text =
                                'Invalid date for selected time';
                          });
                        }
                      } else {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        debugPrint('aqui');
                        debugPrint(gSelectedHour.toString());
                        debugPrint(gSelectedMinute.toString());
                        setState(() {
                          gPickedDate = pickedDate;
                          dateController.text = formattedDate;
                          dateCheck = true;
                        });
                      }
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
                      icon:
                          Icon(Icons.access_time_rounded), //icon of text field
                      labelText: "Enter Hour" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();

                      final selectedDateTime = DateTime(
                          gPickedDate.year,
                          gPickedDate.month,
                          gPickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute);

                      if (selectedDateTime.isAfter(now) || !dateCheck) {
                        setState(() {
                          timeController.text = pickedTime.format(context);
                          timeCheck = true;
                          gSelectedHour = pickedTime.hour;
                          gSelectedMinute = pickedTime.minute;
                        });
                        debugPrint(gSelectedHour.toString());
                      } else {
                        setState(() {
                          timeCheck = false;
                          timeController.text = 'Invalid time';
                        });
                      }
                    }
                  },
                ))),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: timeCheck && dateCheck
              ? () {
                  lamps[widget.deviceId].schedule.add(LampProgram(
                      selectedColor,
                      selectedState,
                      selectedTimer == '0:0' ? 'no' : selectedTimer,
                      dateController.text,
                      timeController.text,
                      selectedRepeat != '0'
                          ? "$selectedRepeat $selectedRepeatUnit"
                          : 'no'));
                  widget.updateParent!();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Program successfully added!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          lamps[widget.deviceId].schedule.removeLast();
                          widget.updateParent!();
                        },
                      ),
                    ),
                  );
                }
              : null,
          child: const Text('Schedule'),
        ),
      ],
    );
  }
}

class BlindConfig extends StatefulWidget {
  final int deviceId;
  final double initialValue;
  const BlindConfig(
      {super.key, required this.deviceId, required this.initialValue});

  @override
  State<BlindConfig> createState() => _BlindConfigState();
}

class _BlindConfigState extends State<BlindConfig> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 10.0),
        child: Column(children: [
          Row(
            children: const [
              Icon(Icons.blinds),
              Text(' State'),
            ],
          ),
          SingleChildScrollView(
            child: Center(
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aberto'),
                    Transform.rotate(
                      angle: 1.5708, // 90 degrees in radians
                      child: Slider(
                        value: _value,
                        min: 0.0,
                        max: 100.0,
                        divisions: 20,
                        label: '${_value.round()}',
                        onChanged: (double value) {
                          setState(() {
                            _value = value;
                            final int deviceId = widget.deviceId;
                            final Blind blind = blinds
                                .firstWhere((blind) => blind.id == deviceId);
                            if (blind != null) {
                              blind.state = value;
                            }
                          });
                        },
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text('Fechado'),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}

class BlindProgramShceduleModal extends StatefulWidget {
  final int deviceId;
  final Function? updateParent;
  const BlindProgramShceduleModal(
      {Key? key, required this.deviceId, this.updateParent})
      : super(key: key);

  @override
  State<BlindProgramShceduleModal> createState() =>
      _BlindProgramShceduleModalState();
}

class _BlindProgramShceduleModalState extends State<BlindProgramShceduleModal> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String selectedRepeat = '0';
  String selectedRepeatUnit = 'days';
  double selectedState = 0;
  bool dateCheck = false;
  bool timeCheck = false;

  var selectUnit = ['days', 'weeks', 'months'];

  DateTime gPickedDate = DateTime.now();
  int gSelectedHour = -1;
  int gSelectedMinute = -1;

  @override
  Widget build(BuildContext context) {
    var blindId = widget.deviceId;
    var selectN = ['0'];

    for (int i = 1; i <= 30; i++) {
      selectN.add(i.toString());
    }

    return AlertDialog(
      title: const Text('Scheduler'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CostumActionExplicitBlindConfig(
              deviceId: blindId,
              onChanged: (double value) {
                // Handle the updated value here
                selectedState = value;
              },
            ),
            const Divider(color: Colors.black),
            Row(
              children: const [
                Icon(Icons.repeat),
                Text(' Repeat'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Every  "),
                DropdownButton<String>(
                  // Initial Value
                  value: selectedRepeat,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: selectN.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeat = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  // Initial Value
                  value: selectedRepeatUnit,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: selectUnit.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRepeatUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Row(
              children: const [
                Icon(Icons.calendar_today),
                Text(' Date / Hour'),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(15),
                height: 100,
                child: Center(
                    child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.edit_calendar), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime
                            .now(), //not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      if (gSelectedHour != -1 && gSelectedMinute != -1) {
                        final selectedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            gSelectedHour,
                            gSelectedMinute);

                        if (selectedDateTime.isAfter(DateTime.now())) {
                          setState(() {
                            gPickedDate = pickedDate;
                            dateController.text = formattedDate;
                            dateCheck = true;
                            debugPrint((dateCheck).toString());
                          });
                        } else {
                          setState(() {
                            dateCheck = false;
                            dateController.text =
                                'Invalid date for selected time';
                          });
                        }
                      } else {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        debugPrint('aqui');
                        debugPrint(gSelectedHour.toString());
                        debugPrint(gSelectedMinute.toString());
                        setState(() {
                          gPickedDate = pickedDate;
                          dateController.text = formattedDate;
                          dateCheck = true;
                        });
                      }
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
                      icon:
                          Icon(Icons.access_time_rounded), //icon of text field
                      labelText: "Enter Hour" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();

                      final selectedDateTime = DateTime(
                          gPickedDate.year,
                          gPickedDate.month,
                          gPickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute);

                      if (selectedDateTime.isAfter(now) || !dateCheck) {
                        setState(() {
                          timeController.text = pickedTime.format(context);
                          timeCheck = true;
                          gSelectedHour = pickedTime.hour;
                          gSelectedMinute = pickedTime.minute;
                        });
                        debugPrint(gSelectedHour.toString());
                      } else {
                        setState(() {
                          timeCheck = false;
                          timeController.text = 'Invalid time';
                        });
                      }
                    }
                  },
                ))),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: timeCheck && dateCheck
              ? () {
                  blinds[widget.deviceId].schedule.add(BlindProgram(
                      selectedState,
                      dateController.text,
                      timeController.text,
                      selectedRepeat != '0'
                          ? "$selectedRepeat $selectedRepeatUnit"
                          : 'no'));
                  widget.updateParent!();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Program successfully added!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          blinds[widget.deviceId].schedule.removeLast();
                          widget.updateParent!();
                        },
                      ),
                    ),
                  );
                }
              : null,
          child: const Text('Schedule'),
        ),
      ],
    );
  }
}

class CostumActionExplicitBlindConfig extends StatefulWidget {
  final int deviceId;
  final ValueChanged<double> onChanged;

  const CostumActionExplicitBlindConfig({
    super.key,
    required this.deviceId,
    required this.onChanged,
  });

  @override
  State<CostumActionExplicitBlindConfig> createState() =>
      _CostumActionExplicitBlindConfigState();
}

class _CostumActionExplicitBlindConfigState
    extends State<CostumActionExplicitBlindConfig> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 0.0),
        child: Column(children: [
          Row(
            children: const [
              Icon(Icons.blinds),
              Text(' State'),
            ],
          ),
          SingleChildScrollView(
            child: Center(
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aberto'),
                    Transform.rotate(
                      angle: 1.5708, // 90 degrees in radians
                      child: Slider(
                          value: _value,
                          min: 0.0,
                          max: 100.0,
                          divisions: 20,
                          label: '${_value.round()}',
                          onChanged: (double value) {
                            setState(() {
                              _value = value;
                            });
                            widget
                                .onChanged(value); // Call the callback function
                          },
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey),
                    ),
                    Text('Fechado'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]));
  }
}

class SensorSettingsModal extends StatefulWidget {
  const SensorSettingsModal({super.key});

  @override
  State<SensorSettingsModal> createState() => _SensorSettingsModalState();
}

class _SensorSettingsModalState extends State<SensorSettingsModal> {
  bool selectedState = false;
  int initValue = sensores[0].dataGatherInterval;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sensor Settings'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(color: Colors.black),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Data harvest: "),
              NumberPicker(
                minValue: 1,
                maxValue: 20,
                value: initValue,
                onChanged: (value) {
                  setState(() => initValue = value);
                },
              ),
              const Text("min")
            ])
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            sensores[0].dataGatherInterval = initValue;
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Settings modified successfully!'),
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class MyDateTimePicker extends StatefulWidget {
  final String label;
  final DateTime defaultValue;
  final Function(DateTime) onDateChanged;
  const MyDateTimePicker(
      {super.key,
      required this.label,
      required this.defaultValue,
      required this.onDateChanged});

  @override
  _MyDateTimePickerState createState() =>
      _MyDateTimePickerState(label, defaultValue);
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController dateController = TextEditingController();

  String label = "Enter Date";

  _MyDateTimePickerState(this.label, this.selectedDate);

  @override
  Widget build(BuildContext context) {
    dateController.text =
        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day} ${selectedDate.hour}:${selectedDate.minute}";

    return Container(
      padding: const EdgeInsets.all(15),
      height: 100,
      width: 200,
      child: Center(
          child: TextField(
              controller: dateController, //editing controller of this TextField
              decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today), //icon of text field
                labelText: label, //label text of field
              ),
              readOnly: true, // when true user cannot edit text
              onTap: () async {
                showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025))
                    .then((date) {
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });

                    showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    ).then((time) {
                      if (time != null) {
                        setState(() {
                          selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              time.hour,
                              time.minute);
                        });
                        widget.onDateChanged(selectedDate);
                        dateController.text =
                            "${selectedDate.year}/${selectedDate.month}/${selectedDate.day} ${selectedDate.hour}:${selectedDate.minute}";
                      }
                    });
                  }
                });
              })

          /*ElevatedButton(
              child: Text("${selectedDate.year}/${selectedDate.month}/${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}"),
              onPressed: () {
                
              },
            ),*/
          ),
    );
  }
}

class DataTableFilter extends StatefulWidget {
  final DateTime initialDate;
  final DateTime finalDate;
  final List<MapEntry<DateTime, double>> data;

  DataTableFilter(
      {required this.initialDate, required this.finalDate, required this.data});

  @override
  _DataTableFilterState createState() => _DataTableFilterState();
}

class _DataTableFilterState extends State<DataTableFilter> {
  List<DataRow> rows = [];
  DateTime InitialDate = DateTime.now();
  DateTime FinalDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _filterData(widget.initialDate, widget.finalDate);
  }

  void _filterData(DateTime initialDate, DateTime endDate,
      [String filter = '']) {
    rows.clear();
    List<DataRow> filteredRows = widget.data.where((data) {
      if (filter != '') {
        return data.key.isAfter(initialDate) &&
            data.key.isBefore(endDate) &&
            data.toString().toLowerCase().contains(filter.toLowerCase());
      } else {
        return data.key.isAfter(initialDate) && data.key.isBefore(endDate);
      }
    }).map((data) {
      return DataRow(
        cells: [
          DataCell(Text(data.key.toString())),
          DataCell(Text(data.value.toStringAsFixed(2))),
        ],
      );
    }).toList();

    filteredRows.forEach((element) {
      rows.add(element);
    });

    FinalDate = endDate;
    InitialDate = initialDate;
  }

  String _filterText = '';

  void _filterRowsText(String filterText) {
    setState(() {
      _filterText = filterText.toLowerCase();
      _filterData(InitialDate, FinalDate, _filterText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Row(children: [
        MyDateTimePicker(
          label: 'From',
          defaultValue: widget.initialDate,
          onDateChanged: _onDateChangedInitial,
        ),
        const SizedBox(
          width: 10,
        ),
        MyDateTimePicker(
          label: "To",
          defaultValue: widget.finalDate,
          onDateChanged: _onDateChangedFinal,
        ),
      ]),
      const SizedBox(
        height: 20,
      ),
      Container(
        margin:
            EdgeInsets.all(10.0), // set the margin to 10 pixels on all sides
        child: SizedBox(
          width: 300.0, // set the width to 300 pixels
          child: TextFormField(
            onChanged: _filterRowsText,
            decoration: InputDecoration(hintText: 'Search'),
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('DateTime')),
            DataColumn(label: Text('Humidity (%)')),
          ],
          rows: rows,
        ),
      ),
    ]));
  }

  void _onDateChangedInitial(DateTime initDate) {
    setState(() {
      _filterData(initDate, FinalDate);
    });
  }

  void _onDateChangedFinal(DateTime endDate) {
    setState(() {
      _filterData(InitialDate, endDate);
    });
  }
}

class MyGraphicWidget extends StatefulWidget {
  final DateTime initialDate;
  final DateTime finalDate;
  final List<MapEntry<DateTime, double>> data;

  MyGraphicWidget(
      {required this.initialDate, required this.finalDate, required this.data});

  @override
  _MyGraphicWidgetState createState() => _MyGraphicWidgetState();
}

class _MyGraphicWidgetState extends State<MyGraphicWidget> {
  List<DataPoint> rows = [];
  DateTime InitialDate = DateTime.now();
  DateTime FinalDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _filterData(widget.initialDate, widget.finalDate);
  }

  void _filterData(DateTime initialDate, DateTime endDate) {
    rows.clear();
    List<DataPoint> filteredRows = widget.data.where((data) {
      return data.key.isAfter(initialDate) && data.key.isBefore(endDate);
    }).map((data) {
      return DataPoint(data.key, data.value);
    }).toList();

    FinalDate = endDate;
    InitialDate = initialDate;

    filteredRows.forEach((element) {
      rows.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Row(children: [
        Expanded(
            // Added Expanded here
            child: MyDateTimePicker(
          label: 'From',
          defaultValue: InitialDate,
          onDateChanged: _onDateChangedInitial,
        )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            // Added Expanded here
            child: MyDateTimePicker(
          label: "To",
          defaultValue: FinalDate,
          onDateChanged: _onDateChangedFinal,
        )),
      ]),
      const SizedBox(
        height: 20,
      ),
      SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<DataPoint, DateTime>>[
          LineSeries<DataPoint, DateTime>(
            dataSource: rows,
            xValueMapper: (DataPoint dataPoint, _) => dataPoint.date,
            yValueMapper: (DataPoint dataPoint, _) => dataPoint.value,
          )
        ],
      ),
    ]));
  }

  void _onDateChangedInitial(DateTime initDate) {
    setState(() {
      _filterData(initDate, FinalDate);
    });
  }

  void _onDateChangedFinal(DateTime endDate) {
    setState(() {
      _filterData(InitialDate, endDate);
    });
  }
}

class DataPoint {
  final DateTime date;
  final double value;

  DataPoint(this.date, this.value);
}
