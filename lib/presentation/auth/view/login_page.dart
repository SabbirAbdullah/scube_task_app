import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task_app/core/routes/app_pages.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/login_controller.dart';


class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const SizedBox(height: 80),
              _TopSection(size),
              _BottomSection(isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _TopSection(Size size) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            child: Image.asset('assets/logo.png'),
          ),
          const SizedBox(height: 24),
          const Text('SCUBE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 8),
          const Text('Control & Monitoring System', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
          SizedBox(height: size.height * 0.06),
        ],
      ),
    );
  }

  Widget _BottomSection(bool isSmallScreen) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              _Title(isSmallScreen),
              const SizedBox(height: 32),
              _UsernameField(),
              const SizedBox(height: 16),
              _PasswordField(),

              _ForgotPassword(),
              const SizedBox(height: 24),
              _LoginButton(),
              const SizedBox(height: 6),
              _RegisterLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Title(bool isSmallScreen) {
    return Text(
      'Login',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: isSmallScreen ? 28 : 32, fontWeight: FontWeight.bold, color: AppColors.textDark),
    );
  }

  Widget _UsernameField() {
    return TextField(
      controller: controller.usernameController,
      decoration: _inputDecoration('Username'),
    );
  }

  Widget _PasswordField() {
    return Obx(() => TextField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible.value,
      decoration: _inputDecoration('Password', isPassword: true),
    ));
  }

  InputDecoration _inputDecoration(String hint, {bool isPassword = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey, width: 1.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.borderGrey, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryColor, width: 2)),
      suffixIcon: isPassword ? IconButton(
        icon: Obx(() => Icon(controller.isPasswordVisible.value ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.textGrey)),
        onPressed: controller.togglePasswordVisibility,
      ) : null,
    );
  }

  Widget _ForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: controller.forgotPassword,
        child: const Text('Forget password?', style: TextStyle(color: AppColors.textGrey, fontSize: 15, decoration: TextDecoration.underline)),
      ),
    );
  }

  Widget _LoginButton() {
    return Obx(() => ElevatedButton(
      onPressed: () => Get.toNamed(AppPages.DASHBOARD),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: controller.isLoading.value ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    ));
  }

  Widget _RegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have any account? ", style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w500)),
        TextButton(
          onPressed: controller.register,
          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: const Text('Register Now', style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
