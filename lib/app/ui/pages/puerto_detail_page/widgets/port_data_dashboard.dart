import 'package:flutter/material.dart';

class PortDataDashboard extends StatelessWidget {
  const PortDataDashboard({
    super.key,
    required this.totalKm,
    required this.maxEle, 
    required this.elevationGain, 
    required this.avgGradient, 
    required this.maxGradient, 
    required this.coefficient,
  });

  final double totalKm;
  final double maxEle;
  final double elevationGain;
  final double avgGradient;
  final double maxGradient;
  final double coefficient;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Distancia',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${totalKm.toStringAsFixed(2)} km',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Altitud',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${maxEle.toStringAsFixed(0)} m',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Desnivel',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${elevationGain.toStringAsFixed(0)} m',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Pendiente Media',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${avgGradient.toStringAsFixed(1)} %',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Pendiente Max.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${maxGradient.toStringAsFixed(1)} %',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Coeficiente',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${coefficient.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],  
    );
  }
}
