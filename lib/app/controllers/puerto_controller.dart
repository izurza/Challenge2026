import 'package:challege_2026/app/data/models/puerto.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';
import 'package:latlong2/latlong.dart';

class PuertoController extends GetxController {

PuertoController();

var gpxStats = Rxn<GpxStats>();
var isLoading = false.obs;

Future<void> loadGpxStats(String assetPath) async {
    isLoading.value = true;
    gpxStats.value = null;

    final gpxString = await rootBundle.loadString(assetPath);

    final xmlDoc = XmlDocument.parse(gpxString);
    final points = <LatLng>[];
    final elevations = <double>[];


    for (final pt in xmlDoc.findAllElements('trkpt')) {
      final lat = double.parse(pt.getAttribute('lat')!);
      final lon = double.parse(pt.getAttribute('lon')!);
      final ele = double.parse(pt.findElements('ele').first.text);
      points.add(LatLng(lat, lon));
      elevations.add(ele);
    }

    final distanceCalc = Distance();
    double totalDistance = 0;
    double totalElevationGain = 0;
    double maxGradient = 0;

    final distances = <double>[0.0];
    final gradients = <double>[0.0];

    for (int i = 1; i < points.length; i++) {
      final d = distanceCalc(points[i - 1], points[i]);
      final deltaH = elevations[i] - elevations[i - 1];
      if (deltaH > 0) totalElevationGain += deltaH;
      totalDistance += d;
      distances.add(totalDistance / 1000); // en km

      // Gradient in %
      double gradient = 0;
      if (d > 0) {
        gradient = (deltaH / d) * 100;
        if (gradient > maxGradient) maxGradient = gradient;
      }
      gradients.add(gradient);
    }

    final totalDistanceKm = totalDistance / 1000;
    final avgGradient = totalElevationGain / totalDistance * 100;

    // Coeficiente de APM (simplificado)
    final coef = (totalElevationGain * totalElevationGain) / (totalDistanceKm * 100);

    gpxStats.value = GpxStats(
      points: points,
      distances: distances,
      elevations: elevations,
      gradients: gradients,
      totalDistance: totalDistanceKm,
      totalElevationGain: totalElevationGain,
      averageGradient: avgGradient,
      maxGradient: maxGradient,
      startElevation: elevations.first,
      endElevation: elevations.last,
      coefficient: coef,
    );
    isLoading.value = false;
  }
}