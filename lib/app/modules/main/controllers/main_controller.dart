import 'package:get/get.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
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
}
