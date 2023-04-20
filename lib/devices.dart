import 'package:flutter/material.dart';

class Lamp {
  String name = "xpto";
  int id = 0;
  bool state = false;
  String model = "Model XPTO";
  Color color = const Color.fromARGB(195, 0, 255, 179);
  String timer = "";
  double timerDouble = 0.0;
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

// todo:

class Blind {}

class Sensor {}
