import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.blue.shade400],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'FIFGROUP',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 88.0),
                            const SizedBox(height: 8.0),
                            const Text(
                              'member of ASTRA',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Mobile Attendance',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              '1.45.3-dev',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            TextField(
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Obx(
                              () => TextField(
                                controller: controller.passwordController,
                                obscureText: controller.isObscure.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isObscure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: controller.toggleObscure,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Obx(() {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.login,
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        )
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '@2019 PT Federal International Finance',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4.0),
                  Text('1.45.3-dev', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
