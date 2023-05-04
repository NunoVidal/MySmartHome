import 'package:flutter/material.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

class SensorState extends StatefulWidget {
  const SensorState({super.key});

  @override
  State<SensorState> createState() => _SensorState();
}

class _SensorState extends State<SensorState>
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
    final sensorId = ModalRoute.of(context)!.settings.arguments as int;
    final List<MapEntry<DateTime, double>> myData =
        sensores[sensorId].history.entries.toList();
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
              leading: const Icon(Icons.sensors, size: 50),
              title: Text(sensores[sensorId].name,
                  style: const TextStyle(fontSize: 22)),
              subtitle: Text(
                  "${sensores[sensorId].category} \nProtocol: ${sensores[sensorId].protocol} \nData Harvest: ${sensores[sensorId].dataGatherInterval} min"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchExample(deviceId: sensorId),
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
              Tab(text: 'History', icon: Icon(Icons.table_chart)),
              Tab(text: 'Graphical', icon: Icon(Icons.query_stats)),
            ],
            onTap: _onItemTapped,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: List.generate(
                      myData.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(myData[index].key.toString())),
                          DataCell(Text(myData[index].value.toString())),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: Center(
                    child: Text('Graphical'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
