
import 'package:challege_2026/app/bindings/puerto_binding.dart';
import 'package:challege_2026/app/ui/pages/puerto_detail_page/puerto_detail_page.dart';
import 'package:challege_2026/app/ui/pages/splash_page/splash_page.dart';
import 'package:get/get.dart';


import '../bindings/home_binding.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/unknown_route_page/unknown_route_page.dart';
import 'app_routes.dart';

const _defaultTransition = Transition.native;

class AppPages {
  static final unknownRoutePage = GetPage(
    name: AppRoutes.UNKNOWN,
    page: () => const UnknownRoutePage(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PUERTO_DETAIL,
      page: () => PuertoDetailPage(),
      binding: PuertoBinding(),
      transition: _defaultTransition,
    ),
  ];
}
