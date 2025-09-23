import 'package:flutter/material.dart';

class GPXStudioPage extends StatelessWidget {
  final String gpxName;
  const GPXStudioPage({Key? key, required this.gpxName}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      appBar: AppBar(title: const Text('GPXStudio')),
    );
  }
}