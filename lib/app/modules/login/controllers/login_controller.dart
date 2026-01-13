import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/exceptions/api_exception.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void login() async {
    isLoading.value = true;
    try {
      await repository.login(
        usernameController.text,
        passwordController.text,
      );
      Get.offAllNamed(Routes.DASHBOARD);
    } on ApiException catch (e) {
      Get.snackbar('Login Failed', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
