import 'package:flutter/material.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class LightState extends StatefulWidget {
  const LightState({super.key});

  @override
  State<LightState> createState() => _LightState();
}

class _LightState extends State<LightState>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void _onItemTapped(index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final lightId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 30.0, top: 30.0),
            child: ListTile(
              leading: const Icon(Icons.lightbulb, size: 50),
              title: Text(lamps[lightId].name,
                  style: const TextStyle(fontSize: 22)),
              subtitle: Text(lamps[lightId].model),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchExample(deviceId: lightId),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: 'Command', icon: Icon(Icons.settings_remote_outlined)),
              Tab(text: 'Schedulle', icon: Icon(Icons.schedule)),
            ],
            onTap: _onItemTapped,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: ExplicitLightConfig(deviceId: lightId),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (lamps[lightId].schedule.isEmpty)
                        Container(
                          padding: const EdgeInsets.only(top: 200),
                          alignment: Alignment.center,
                          child: const Text('No events scheduled'),
                        ),
                      for (var i = 0; i < lamps[lightId].schedule.length; i++)
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Row(children: [
                                  const Icon(Icons.calendar_today),
                                  Text(
                                    lamps[lightId].schedule[i].date,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  )
                                ]),
                                subtitle: Row(children: [
                                  const Icon(Icons.repeat),
                                  Text(lamps[lightId].schedule[i].repeat),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.timer),
                                  Text(lamps[lightId]
                                      .schedule[i]
                                      .timer
                                      .toString())
                                ]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(lamps[lightId].schedule[i].time,
                                        style: TextStyle(fontSize: 25)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 35,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: lamps[lightId]
                                                .schedule[i]
                                                .color,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (!lamps[lightId].schedule[i].state)
                                      const Icon(Icons.dark_mode_sharp)
                                    else
                                      const Icon(Icons.light_mode_sharp),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LightProgramShceduleModal(
                          deviceId: lightId,
                          updateParent: () {
                            setState(() {});
                          });
                    });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
