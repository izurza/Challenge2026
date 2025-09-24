import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GpxMap extends StatelessWidget {
  final List<LatLng> points;

  const GpxMap({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const Center(child: Text("No hay puntos en el GPX"));
    }

    final bounds = LatLngBounds.fromPoints(points);

    return SizedBox(
      height: 250, // altura dentro del ExpansionPanel
      child: FlutterMap(
        options: MapOptions(
          initialCenter: bounds.center,
          initialZoom: 13,
          cameraConstraint: CameraConstraint.contain(bounds: bounds),
        ),
        children: [
          TileLayer(
            urlTemplate:    "https://api.mapbox.com/styles/v1/mapbox/outdoors-v12/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
            additionalOptions: {
              'accessToken': dotenv.env['MAPBOX_TOKEN']!,
            },
            userAgentPackageName: 'com.tuapp.nombre',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: points,
                strokeWidth: 4,
                color: Colors.blueAccent,
              ),
            ],
          ),
          MarkerLayer(markers: [
            Marker(point: points.first, child: const Icon(Icons.location_on, color: Colors.green, size: 20)),
            Marker(point: points.last, child: const Icon(Icons.flag, color: Colors.red, size: 20)),
          ])
        ],
      ),
    );
  }
}
