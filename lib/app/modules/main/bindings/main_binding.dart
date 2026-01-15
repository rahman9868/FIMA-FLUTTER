import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/data/repositories/dashboard_repository.dart';
import 'package:myapp/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Using fenix: true to ensure the CacheManager is not disposed of
    // when a route that uses it is closed. This makes it a singleton.
    Get.lazyPut<CacheManager>(() => CacheManager(), fenix: true);
    
    Get.lazyPut<DashboardRepository>(() => DashboardRepository());

    Get.lazyPut<DashboardController>(
      () => DashboardController(
        repository: Get.find(),
        cacheManager: Get.find(),
      ),
    );
    
    Get.lazyPut<MainController>(
      () => MainController(
        cacheManager: Get.find(),
      ),
    );
  }
}
