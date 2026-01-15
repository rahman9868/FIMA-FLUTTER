import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(
        cacheManager: Get.find(),
      ),
    );
    Get.lazyPut<CacheManager>(
      () => CacheManager(),
    );
  }
}
