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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcula el ancho disponible para cada card (3 cards por fila)
        final double cardWidth = (constraints.maxWidth - 32) / 3; // 16px padding a cada lado
        final double cardHeight = 85;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: Card(
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Coeficiente',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            Text(
                              coefficient.toStringAsFixed(0),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
