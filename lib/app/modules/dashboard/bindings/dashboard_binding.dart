import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';

import '../controllers/dashboard_controller.dart';
import '../../../data/repositories/dashboard_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(Get.find<AppDatabase>()),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(repository: Get.find()),
    );
  }
}
