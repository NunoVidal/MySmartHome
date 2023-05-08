import 'package:flutter/material.dart';

import 'devices.dart';

List<Lamp> lamps = [
  Lamp("Jon's Bedroom", 0, const Color.fromARGB(195, 0, 255, 179),
      "Xiaomi led +", "0"),
  Lamp("Office", 1, const Color.fromARGB(255, 200, 0, 0), "Samsung bulb 2.0",
      "0")
];

List<Blind> blinds = [
  Blind("Living Room", 0, 0,"0"),
  Blind("Jon's Bedroom", 1, 25,"0"),
  Blind("Office",2,50,"0")
];

//to do for blinds

List<Sensor> sensores = [
  Sensor("Greenhouse Humidity sensor", "Humidity sensor", "Zigbee", "%")
];
