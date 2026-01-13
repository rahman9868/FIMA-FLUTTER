import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:myapp/app/modules/login/bindings/login_binding.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';
import 'package:myapp/app/modules/splash/controllers/splash_controller.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => Scaffold(
        body: Center(
          // Initialize SplashController, which will handle redirection.
          child: GetBuilder<SplashController>(
            init: SplashController(),
            builder: (_) => const CircularProgressIndicator(),
          ),
        ),
      ),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
