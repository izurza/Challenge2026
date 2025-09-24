import 'package:flutter/material.dart';

class GPXStudioPage extends StatelessWidget {
  final String gpxName;
  const GPXStudioPage({super.key, required this.gpxName});

  

  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      appBar: AppBar(title: const Text('GPXStudio')),
    );
  }
}