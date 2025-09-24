import 'package:challege_2026/app/controllers/puerto_controller.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/altimetry.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/gpx_map.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/widgets/port_data_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:challege_2026/app/data/models/puerto.dart';

class PuertoDetailPage extends StatefulWidget {
  const PuertoDetailPage({super.key});

  @override
  State<PuertoDetailPage> createState() => _PuertoDetailPageState();
}

class _PuertoDetailPageState extends State<PuertoDetailPage> {
  int? _expandedIndex;
  final Map<int, GpxStats?> _gpxStatsCache = {};
  final Map<int, bool> _loadingCache = {};

  Future<void> _loadGpxIfNeeded(int idx, String gpxPath) async {
    if (_gpxStatsCache[idx] != null || _loadingCache[idx] == true) return;
    setState(() {
      _loadingCache[idx] = true;
    });
    final controller = Get.find<PuertoController>();
    final stats = await controller.loadGpxStats('assets/gpx/$gpxPath');
    setState(() {
      _gpxStatsCache[idx] = stats;
      _loadingCache[idx] = false;
    });
  }

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
            expansionCallback: (panelIndex, isExpanded) async {
              if (!isExpanded) {
                final sp = puerto.startingPoints[panelIndex];
                await _loadGpxIfNeeded(panelIndex, sp.gpx);
              }
              setState(() {
                _expandedIndex = isExpanded ? null : panelIndex;
              });
            },
            children: puerto.startingPoints.asMap().entries.map((entry) {
              final idx = entry.key;
              final sp = entry.value;
              final stats = _gpxStatsCache[idx];
              final isLoading = _loadingCache[idx] == true;
              final isExpanded = _expandedIndex == idx;

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
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : stats != null
                          ? Column(
                              children: [
                                GpxMap(points: stats.points),
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
                            )
                          : const Center(child: Text('No hay datos de altimetría para este GPX.')),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}