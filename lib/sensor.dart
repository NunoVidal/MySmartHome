import 'package:flutter/material.dart';

import 'costum_widgets.dart';
import 'my_devices.dart';

import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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

    DateTime endDate = DateTime.now(); // Example end date and time
    DateTime startDate = endDate.subtract(Duration(hours: 3));

    List<DataRow> filteredRows = myData.where((data) {
      return data.key.isAfter(startDate) && data.key.isBefore(endDate);
    }).map((data) {
      return DataRow(
        cells: [
          DataCell(Text(data.key.toString())),
          DataCell(Text(data.value.toString())),
        ],
      );
    }).toList();

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
                    child: Column(
                      children: [
                            Row(
                              children:  [
                            MyDateTimePicker(label: 'From',defaultValue: startDate),
                              const SizedBox(
                                width: 10,
                              ),
                            MyDateTimePicker(label: "To",defaultValue: endDate),
                          ]),
                        SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Value')),
                            ],
                            rows: filteredRows,
                          ),
                        )
                      ])
                ),
                
                //OTHER TAB
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //Initialize the spark charts widget
                      child: SfSparkLineChart.custom(
                        //Enable the trackball
                        trackball: const SparkChartTrackball(
                            activationMode: SparkChartActivationMode.tap),
                        //Enable marker
                        marker: const SparkChartMarker(
                            displayMode: SparkChartMarkerDisplayMode.all),
                        //Enable data label
                        labelDisplayMode: SparkChartLabelDisplayMode.all,
                        xValueMapper: (int index) => myData[index].key,
                        yValueMapper: (int index) => myData[index].value,
                        dataCount: 5,
                      ),
                    ),
                  )
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
