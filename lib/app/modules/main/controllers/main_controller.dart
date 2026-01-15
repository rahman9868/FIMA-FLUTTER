import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:myapp/app/modules/my_report/views/my_report_view.dart';
import 'package:myapp/app/routes/app_pages.dart';

class MainController extends GetxController {
  final CacheManager cacheManager;

  MainController({required this.cacheManager});

  var selectedIndex = 0.obs;

  final List<Widget> pages = [
    const DashboardView(),
    const MyReportView(),
    const Center(child: Text("Settings Page")),
  ];

  final List<String> pageTitles = [
    'Dashboard',
    'My Report',
    'Settings',
  ];

  Widget get currentPage => pages[selectedIndex.value];
  String get currentTitle => pageTitles[selectedIndex.value];

  bool get isDashboard => selectedIndex.value == 0;
  bool get isMyReport => selectedIndex.value == 1;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  Future<void> logout() async {
    await cacheManager.clearAll();
    Get.offAllNamed(Routes.LOGIN);
  }
}
