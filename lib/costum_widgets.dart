import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

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
    if (deviceType == 'light')
    {
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
    }else if (deviceType == "blind"){
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
                  children:  [
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
          Navigator.pushNamed(context, '/blind', arguments: id)
              .then((result) => updateParent());
        },
      ));
    }else if (deviceType == "sensor"){
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
                  children:  [
                    Text("${sensores[id].currentVal.toString()} ${sensores[id].unit}"),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(Icons.query_stats)
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
    }else{
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
          const Divider(color: Colors.black),
          Row(
            children: const [
              Icon(Icons.timer_outlined),
              Text(' Timer'),
            ],
          ),
          TimerPicker(
            externalAction: (hours, minutes) {
              lamps[widget.deviceId].timer = '$hours:$minutes';
              lamps[widget.deviceId].timerMinutes = minutes;
              lamps[widget.deviceId].timerHours = hours;
            },
            deviceId: widget.deviceId,
            initWithDevice: true,
          )
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

  var selectN = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  var selectUnit = ['days', 'weeks', 'months'];
  @override
  Widget build(BuildContext context) {
    var lightId = widget.deviceId;

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

                      setState(() {
                        dateController.text = formattedDate;
                        dateCheck = true;
                        debugPrint((dateCheck).toString());
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

                    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
                      final now = DateTime.now();
                      final selectedDateTime = DateTime(now.year, now.month,
                          now.day, pickedTime.hour, pickedTime.minute);
                      if (selectedDateTime.isAfter(now)) {
                        setState(() {
                          timeController.text = pickedTime.format(context);
                          timeCheck = true;
                        });
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
          child: const Text('Schedule'),
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
                }
              : null,
        ),
      ],
    );
  }
}

class BlindConfig extends StatefulWidget {
  final int deviceId;
  final double initialValue;
  const BlindConfig({super.key, required this.deviceId, required this.initialValue});

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
              Icon(Icons.color_lens_outlined),
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
                            //blinds[BlindId].state = value;
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
  String selectedTimer = '0:0';
  
  double selectedState = 0.0;
  bool dateCheck = false;
  bool timeCheck = false;

  var selectN = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  var selectUnit = ['days', 'weeks', 'months'];
  @override
  Widget build(BuildContext context) {
    var lightId = widget.deviceId;

    return AlertDialog(
      title: const Text('Scheduler'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CostumActionExplicitBlindConfig(
              deviceId: lightId,
              colorChangeAction: (color) {
                setState(() => selectedState = 0);
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

                      setState(() {
                        dateController.text = formattedDate;
                        dateCheck = true;
                        debugPrint((dateCheck).toString());
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

                    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
                      final now = DateTime.now();
                      final selectedDateTime = DateTime(now.year, now.month,
                          now.day, pickedTime.hour, pickedTime.minute);
                      if (selectedDateTime.isAfter(now)) {
                        setState(() {
                          timeController.text = pickedTime.format(context);
                          timeCheck = true;
                        });
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
          child: const Text('Schedule'),
          onPressed: timeCheck && dateCheck
              ? () {
                  blinds[widget.deviceId].schedule.add(BlindProgram(
                      selectedState,
                      selectedTimer == '0:0' ? 'no' : selectedTimer,
                      dateController.text,
                      timeController.text,
                      selectedRepeat != '0'
                          ? "$selectedRepeat $selectedRepeatUnit"
                          : 'no'));
                  widget.updateParent!();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}

class CostumActionExplicitBlindConfig extends StatefulWidget {
  final int deviceId;
  final Function colorChangeAction;
  final Function timerChangeAction;
  const CostumActionExplicitBlindConfig(
      {super.key,
      required this.deviceId,
      required this.colorChangeAction,
      required this.timerChangeAction});

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
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey
                    ),
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