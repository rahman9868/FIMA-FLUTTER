import 'package:get/get.dart';
import 'package:myapp/app/data/local/app_database.dart';
import 'package:myapp/app/data/providers/api_provider.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/data/repositories/dashboard_repository.dart';
import 'package:myapp/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CacheManager>(() => CacheManager(), fenix: true);
    Get.lazyPut<ApiProvider>(() => ApiProvider(), fenix: true);

    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(Get.find<AppDatabase>()),
    );

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
