import 'package:flutter/material.dart';

class Lamp {
  String name = "xpto";
  int id = 0;
  bool state = false;
  String model = "Model XPTO";
  Color color = const Color.fromARGB(195, 0, 255, 179);
  String timer = "";
  int timerMinutes = 0;
  int timerHours = 0;
  List<LampProgram> schedule = [];

  Lamp(this.name, this.id, this.color, this.model, this.timer);

  addProgram(LampProgram program) {
    schedule.add(program);
  }
}

class LampProgram {
  Color color = const Color.fromARGB(195, 0, 255, 179);
  bool state = false;
  String timer = "";
  String date = "";
  String time = "";
  String repeat = "";

  LampProgram(
      this.color, this.state, this.timer, this.date, this.time, this.repeat);
}

class Blind {
  String name = "";
  int id = 0;
  double state = 0;
  List <BlindProgram> schedule = [];

  Blind(this.name, this.id, this.state);

  addProgram(BlindProgram program){
    schedule.add(program);
  }

}

class BlindProgram{
  double state = 0;
  String date = "";
  String time = "";
  String repeat = "";

  BlindProgram(this.state, this.date, this.time, this.repeat);
}

class Sensor {
  int id = 0;
  String name = "";
  String category = "";
  int dataGatherInterval = 5; //in minutes
  double currentVal = 53.2;
  String protocol;
  String unit = "";
  Map<DateTime, double> history = {};

  Sensor(this.name, this.category, this.protocol, this.unit);

  createHistory(Map<DateTime, double> hist) {
    history = hist;
  }
}
