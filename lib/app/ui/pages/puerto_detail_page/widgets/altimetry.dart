import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AltimetryChart extends StatelessWidget {
  final List<double> distances; // en km
  final List<double> elevations; // en m

  const AltimetryChart({
    super.key,
    required this.distances,
    required this.elevations,
  });

  // Calcula segmentos de 1km y gradientes
  List<_Segment> _calculateSegments() {
    final List<_Segment> segments = [];
    if (distances.isEmpty || elevations.isEmpty) return segments;
    final totalKm = distances.last;
    final nSegments = max(1, totalKm.ceil());
    for (int i = 0; i < nSegments; i++) {
      final startKm = i.toDouble();
      final endKm = min(i + 1.0, totalKm);
      // Busca puntos dentro del segmento
      final startIdx = distances.indexWhere((d) => d >= startKm);
      final endIdx = distances.lastIndexWhere((d) => d <= endKm);
      final startEle = startIdx >= 0 ? elevations[startIdx] : elevations.first;
      final endEle = endIdx >= 0 ? elevations[endIdx] : elevations.last;
      final gain = endEle - startEle;
      final gradient = (endKm - startKm) > 0 ? (gain / ((endKm - startKm) * 1000)) * 100 : 0;
      segments.add(_Segment(
        midKm: (startKm + endKm) / 2,
        gradient: gradient.toDouble(),
        startKm: startKm,
        endKm: endKm,
      ));
    }
    return segments;
  }

  Color _colorForGradient(double g) {
    if (g >= 10) return const Color(0xFFE7004C);
    if (g >= 8) return const Color(0xFFF54A40);
    if (g >= 5) return const Color(0xFFFD7D38);
    if (g >= 3) return const Color(0xFFFFC100);
    return const Color(0xFFCBFF3F);
  }

  @override
  Widget build(BuildContext context) {
    if (distances.isEmpty || elevations.isEmpty) {
      return const Center(child: Text('No hay datos de altimetría'));
    }

    final minEle = elevations.reduce(min);
    final maxEle = elevations.reduce(max);
    final totalKm = distances.last;
    final segments = _calculateSegments();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Altimetría',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
              )
            ],  
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 260,
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: totalKm,
                    minY: minEle,
                    maxY: maxEle,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.white24,
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: Colors.white24,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          //interval: ((maxEle - minEle) / 2).ceilToDouble(),
                          getTitlesWidget: (value, meta) => Text(
                            '${value.toInt()} m',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 1,
                          getTitlesWidget: (value, meta) => Text(
                            '${value.toStringAsFixed(1).replaceFirst(".0", "")} km',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.white24),
                    ),
                    lineBarsData: [
                      // Área coloreada por gradiente
                      LineChartBarData(
                        spots: List.generate(
                          distances.length,
                          (i) => FlSpot(distances[i], elevations[i]),
                        ),
                        isCurved: true,
                        barWidth: 2,
                        color: Colors.white,
                        belowBarData: BarAreaData(
                          show: true,

                          gradient: LinearGradient(
                            colors: segments.map((s) => _colorForGradient(s.gradient).withAlpha(175)).toList(),
                            stops: segments.map((s) => s.midKm / totalKm).toList(),
                          ),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
                // Etiquetas de gradiente por tramo
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: segments.map((seg) {
                          final left = constraints.maxWidth * (seg.midKm / totalKm);
                          return Positioned(
                            left: left - 18,
                            bottom: 0,
                            child: Column(
                              children: [
                                Text(
                                  '${seg.gradient.toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    color: _colorForGradient(seg.gradient),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _Segment {
  final double midKm;
  final double gradient;
  final double startKm;
  final double endKm;
  _Segment({
    required this.midKm,
    required this.gradient,
    required this.startKm,
    required this.endKm,
  });
}