import 'package:flutter/material.dart';
import 'package:smart_home_app/devices.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class BlindState extends StatefulWidget {
  const BlindState({super.key});

  @override
  State<BlindState> createState() => _BlindState();
}

class _BlindState extends State<BlindState>
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
    final BlindId = ModalRoute.of(context)!.settings.arguments as int;

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
              leading: const Icon(Icons.blinds, size: 50),
              title: Text(blinds[BlindId].name,
                  style: const TextStyle(fontSize: 22)),
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
                  child: BlindConfig(deviceId: BlindId, initialValue: blinds[BlindId].state),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if (blinds[BlindId].schedule.isEmpty)
                        Container(
                          padding: const EdgeInsets.only(top: 200),
                          alignment: Alignment.center,
                          child: const Text('No events scheduled'),
                        ),
                      for (var i = 0; i < blinds[BlindId].schedule.length; i++)
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Row(children: [
                                  const Icon(Icons.calendar_today),
                                  Text(
                                    blinds[BlindId].schedule[i].date,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  )
                                ]),
                                subtitle: Row(children: [
                                  const Icon(Icons.repeat),
                                  Text(blinds[BlindId].schedule[i].repeat),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(blinds[BlindId].schedule[i].time,
                                        style: TextStyle(fontSize: 25)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('${blinds[BlindId].schedule[i].state.toInt()}%',
                                        style: TextStyle(fontSize: 25)),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                      return BlindProgramShceduleModal(
                          deviceId: BlindId,
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
