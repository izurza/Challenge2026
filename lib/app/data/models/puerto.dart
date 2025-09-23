import 'dart:ui';

import 'package:flutter/material.dart';

class Puerto{
  final String name;
  final List<StartingPoint> startingPoints;

  Puerto({required this.name, required this.startingPoints});
}

class StartingPoint {
  final String name;
  final String gpx;
  bool completed;

  StartingPoint({required this.name, required this.gpx, this.completed = false});
}

Color getPuertoColor(Puerto puerto) {
  final total = puerto.startingPoints.length;
  final completados = puerto.startingPoints.where((sp) => sp.completed).length;

  if (completados == 0) return Colors.grey;
  if (completados == total) return Colors.green;
  return Colors.orange;
}