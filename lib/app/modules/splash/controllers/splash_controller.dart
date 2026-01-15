import 'package:get/get.dart';
import 'package:myapp/app/data/providers/cache_manager.dart';
import 'package:myapp/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final CacheManager _cacheManager = CacheManager();

  @override
  void onReady() {
    super.onReady();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // A short delay to allow the native splash screen to be visible.
    await Future.delayed(const Duration(seconds: 2));

    final user = await _cacheManager.getUserProfile();

    if (user != null) {
      // If user is found, go to the main page.
      Get.offAllNamed(Routes.MAIN);
    } else {
      // Otherwise, go to the login page.
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
