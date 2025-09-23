import 'package:challege_2026/app/ui/pages/gpx_studio_page/gpx_studio_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:challege_2026/app/data/models/puerto.dart';

class PuertoDetailPage extends StatelessWidget {
  const PuertoDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Puerto puerto = Get.arguments as Puerto;

    return Scaffold(
      appBar: AppBar(
        title: Text(puerto.name),
      ),
      body: ListView.builder(
        itemCount: puerto.startingPoints.length,
        itemBuilder: (context, index) {
          final sp = puerto.startingPoints[index];
          return ListTile(
            title: Text(sp.name),
            subtitle: Text(sp.gpx),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () async {
                // Abre GPXStudio con el archivo GPX si tienes la URL
                // Si solo tienes el nombre, puedes mostrar un mensaje o buscar la URL
                Get.to(() => GPXStudioPage(gpxName: sp.gpx));
              },
            ),
          );
        },
      ),
    );
  }
}