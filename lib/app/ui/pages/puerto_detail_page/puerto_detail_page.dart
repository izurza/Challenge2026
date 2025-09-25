import 'package:challege_2026/app/controllers/puerto_controller.dart';
import 'package:challege_2026/app/data/models/puerto.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/altimetry.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/gpx_map.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/port_data_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuertoDetailPage extends GetView<PuertoController> {
  const PuertoDetailPage({super.key});


  @override
  Widget build(BuildContext context) {
    final puerto = Get.arguments as Puerto;
    //var stats = GpxStats(points: <LatLng>[], distances: <double>[], elevations: <double>[], totalDistance: 0, totalElevationGain: 0, maxGradient: 0, averageGradient: 0, coefficient: 0, gradients: [], startElevation: 0, endElevation: 0);
    GpxStats? stats;
    
    return Scaffold(
    appBar: AppBar(title: Text(puerto.name)),

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExpansionPanelList.radio(
          expansionCallback: (panelIndex, isExpanded) async {
            if (isExpanded) {
              await controller.loadGpxStats('assets/gpx/${puerto.startingPoints[panelIndex].gpx}'); 
            }
          },
          children: puerto.startingPoints.asMap().entries.map((entry) {
            final idx = entry.key;
            final sp = entry.value;
            return ExpansionPanelRadio(
              value: idx,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(sp.name),
                );
              },
              body: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                stats = controller.gpxStats.value;
                if (stats == null) {
                  return const Center(child: Text("No hay datos GPX"));
                }
                return Column(
                  children: [
                    GpxMap(points: stats!.points),
                    PortDataDashboard(totalKm: stats!.totalDistance, maxEle: stats!.endElevation, elevationGain: stats!.totalElevationGain, avgGradient: stats!.averageGradient, maxGradient: stats!.maxGradient, coefficient: stats!.coefficient),
                    AltimetryChart(distances: stats!.distances, elevations: stats!.elevations)
                  ],
                );
              }),
            );
          }).toList(),
        ),
      )
      )
    );
  }
}