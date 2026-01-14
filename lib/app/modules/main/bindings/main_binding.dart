import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/data/repositories/dashboard_repository.dart';
import 'package:myapp/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());

    // Dependencies for Dashboard
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(Get.find<AppDatabase>()),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(repository: Get.find()),
    );
  }
}
