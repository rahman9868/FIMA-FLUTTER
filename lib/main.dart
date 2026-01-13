import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for non-web platforms
  if (!kIsWeb) {
    sqfliteFfiInit();
  }

  // Set the database factory based on the platform
  databaseFactory = databaseFactoryFfi;
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  Get.put(database);

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
