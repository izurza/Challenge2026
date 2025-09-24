import 'package:challege_2026/app/constants/puertos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/models/puerto.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  int getCompletedStartingPointsCount() {
    return puertos
        .expand((puerto) => puerto.startingPoints)
        .where((sp) => sp.completed)
        .length;
  }

  int getTotalStartingPointsCount() {
    return puertos
        .expand((puerto) => puerto.startingPoints)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final totalStartingPoints = getTotalStartingPointsCount();
    final completedStartingPoints = getCompletedStartingPointsCount();
    final progress = totalStartingPoints == 0 ? 0.0 : completedStartingPoints / totalStartingPoints;

    return Scaffold(
      appBar: AppBar(title: const Text('Puertos de Bizkaia')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedStartingPoints de $totalStartingPoints subidas completadas',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: puertos.length,
              itemBuilder: (context, index) {
                final puerto = puertos[index];
                final color = getPuertoColor(puerto);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: color.withOpacity(0.2),
                  child: ListTile(
                    title: Text(
                      puerto.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/puerto_detail', arguments: puerto);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}