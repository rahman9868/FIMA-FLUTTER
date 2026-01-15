import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/data/repositories/my_report_repository.dart';
import 'package:myapp/app/modules/my_report/controllers/my_report_controller.dart';

class MyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CacheManager>(
      () => CacheManager(),
    );
    Get.lazyPut<MyReportRepository>(
      () => MyReportRepository(),
    );
    Get.lazyPut<MyReportController>(
      () => MyReportController(
        repository: Get.find(),
        cacheManager: Get.find(),
      ),
    );
  }
}
