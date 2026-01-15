import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(controller.currentTitle),
          backgroundColor: Colors.indigo,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("User Name"),
                accountEmail: Text("user.name@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "U",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Dashboard'),
                onTap: () {
                  controller.changePage(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('My Report'),
                onTap: () {
                  controller.changePage(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  controller.changePage(1);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {
                  controller.logout();
                },
              ),
            ],
          ),
        ),
        body: controller.currentPage,
        floatingActionButton: controller.isDashboard
            ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.indigo,
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
