import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoginController extends GetxController {


  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {

        // logic

  }

  void forgotPassword() {
    Get.snackbar(
      'Forgot Password',
      'Password recovery feature coming soon',
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade900,
    );
  }

  void register() {
    Get.snackbar(
      'Register',
      'Registration feature coming soon',
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade900,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
