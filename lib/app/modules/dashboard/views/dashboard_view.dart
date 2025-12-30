import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'FIMA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              selected: controller.selectedIndex.value == 0,
              onTap: () {
                controller.onItemTapped(0);
                Get.back(); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              selected: controller.selectedIndex.value == 1,
              onTap: () {
                controller.onItemTapped(1);
                Get.back(); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        return Center(
          child: Text(
            'Selected Page: ${controller.selectedIndex.value == 0 ? "Home" : "Settings"}',
            style: TextStyle(fontSize: 24),
          ),
        );
      }),
    );
  }
}
