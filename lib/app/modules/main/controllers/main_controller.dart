import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/routes/app_pages.dart';

class MainController extends GetxController {
  final CacheManager cacheManager;

  MainController({required this.cacheManager});

  var selectedIndex = 0.obs;

  final List<Widget> pages = [
    const DashboardView(),
    // Placeholder for settings page
    const Center(child: Text("Settings Page")), 
  ];

  final List<String> pageTitles = [
    'Dashboard',
    'Settings',
  ];

  Widget get currentPage => pages[selectedIndex.value];
  String get currentTitle => pageTitles[selectedIndex.value];

  bool get isDashboard => selectedIndex.value == 0;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  Future<void> logout() async {
    await cacheManager.clearAll();
    Get.offAllNamed(Routes.LOGIN);
  }
}
