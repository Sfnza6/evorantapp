import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/login_controller.dart';
import 'package:iforenta_app/views/widgets/customtextformauth.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginControllerImp());

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFD700); // لون إيفورنتا

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Login", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/welcome.png',
                  height: 180,
                ),
              ),
              const SizedBox(height: 30),

              // Phone
              CustomAuthTextFormField(
                mycontroller: controller.phone,
                hinttext: "Enter your phone number",
                iconData: Icons.phone_android_outlined,
                labelttext: "Phone",
                isNumber: true,
                valid: (val) => val == null || val.trim().length < 9
                    ? "Invalid phone"
                    : null,
              ),
              const SizedBox(height: 16),

              // Password
              Obx(() => CustomAuthTextFormField(
                    mycontroller: controller.password,
                    hinttext: "Enter your password",
                    labelttext: "Password",
                    obscuretext: controller.hidePassword.value,
                    iconData: controller.hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onTapicon: controller.togglePasswordVisibility,
                    valid: (val) => val == null || val.length < 6
                        ? "At least 6 characters"
                        : null,
                  )),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.forgotPassword);
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button / Loading Indicator
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2));
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                );
              }),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap: controller.goToSignUp,
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
