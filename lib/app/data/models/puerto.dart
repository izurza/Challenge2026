import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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


class GpxStats {
  final List<LatLng> points;
  final List<double> distances; // acumuladas en km
  final List<double> elevations; // en m
  final List<double> gradients; // en %
  final double totalDistance;
  final double totalElevationGain;
  final double averageGradient;
  final double maxGradient;
  final double startElevation;
  final double endElevation;
  final double coefficient;

  GpxStats({
    required this.points,
    required this.distances,
    required this.elevations,
    required this.gradients,
    required this.totalDistance,
    required this.totalElevationGain,
    required this.averageGradient,
    required this.maxGradient,
    required this.startElevation,
    required this.endElevation,
    required this.coefficient,
  });
}

Color getPuertoColor(Puerto puerto) {
  final total = puerto.startingPoints.length;
  final completados = puerto.startingPoints.where((sp) => sp.completed).length;

  if (completados == 0) return Colors.grey;
  if (completados == total) return Colors.green;
  return Colors.orange;
}