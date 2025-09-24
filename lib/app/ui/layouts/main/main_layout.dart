import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/main_controller.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends GetView<MainController> {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center (child:child);
  }
}
