import 'package:challege_2026/app/controllers/puerto_controller.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/altimetry.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/gpx_map.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/port_data_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:challege_2026/app/data/models/puerto.dart';

class PuertoDetailPage extends GetView<PuertoController> {
  final int? _expandedIndex;

  PuertoDetailPage({super.key, int? expandedIndex}) : _expandedIndex = expandedIndex;

  @override
  Widget build(BuildContext context) {
    final Puerto puerto = Get.arguments as Puerto;

    return Scaffold(
      appBar: AppBar(
        title: Text(puerto.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ExpansionPanelList.radio(
            initialOpenPanelValue: _expandedIndex,
            children: puerto.startingPoints.asMap().entries.map((entry) {
              final idx = entry.key;
              final sp = entry.value;
              return ExpansionPanelRadio(
                value: idx,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      sp.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: sp.completed ? Colors.green : Colors.grey.shade700,
                      ),
                    ),
                    trailing: Icon(
                      sp.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: sp.completed ? Colors.green : Colors.grey,
                    ),
                  );
                },
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.loadGpxStats('assets/gpx/${sp.gpx}');
                        },
                        child: const Text('Cargar altimetría'),
                      ),
                      Obx(() {
                        final stats = controller.gpxStats.value;
                        if (stats == null) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Pulsa "Cargar altimetría" para ver los datos'),
                          );
                        }
                        return Column(
                          children: [
                            //GpxMap(points: stats.points),
                            PortDataDashboard(
                              totalKm: stats.totalDistance,
                              maxEle: stats.endElevation,
                              elevationGain: stats.totalElevationGain,
                              avgGradient: stats.averageGradient,
                              maxGradient: stats.maxGradient,
                              coefficient: stats.coefficient,
                            ),
                            AltimetryChart(
                              distances: stats.distances,
                              elevations: stats.elevations,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}