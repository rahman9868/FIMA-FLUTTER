import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:developer' as developer;
import 'dart:io';

void main() async {
  // Ensure all Flutter bindings are ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Conditionally initialize sqflite for desktop platforms.
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  try {
    // Now, we can safely build the database.
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();
    Get.put<AppDatabase>(database); // Register the database instance with GetX.
  } catch (e, s) {
    // Log the error for better debugging.
    developer.log(
      'Failed to build the database.',
      name: 'main',
      error: e,
      stackTrace: s,
    );
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
