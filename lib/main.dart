import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/routes/app_pages.dart';

void main() async {
  // This is the crucial line that ensures all Flutter bindings are ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Now, we can safely build the database.
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  Get.put(database); // Register the database instance with GetX.

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
