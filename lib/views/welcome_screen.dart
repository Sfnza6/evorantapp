import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    // 🎨 ألوان الشعار
    const primaryColor = Color.fromARGB(255, 255, 187, 0); // الذهبي
    const secondaryColor = Color(0xFF2E2E2E); // رمادي غامق
    const lightGray = Color(0xFFF3F3F3); // خلفية ناعمة

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📷 صورة الترحيب
            Image.asset(
              'assets/images/welcome.png',
              width: 280,
            ),

            const SizedBox(height: 50),

            // 🟨 عنوان رئيسي
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Before Enjoying Iforenta Services\nPlease Register First',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF707070),
              ),
            ),

            const SizedBox(height: 40),

            // ✅ زر إنشاء حساب
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.goToRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ✅ زر تسجيل الدخول
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: controller.goToLogin,
                style: TextButton.styleFrom(
                  backgroundColor: lightGray,
                  foregroundColor: secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔏 شروط الاستخدام
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'By Logging In Or Registering, You Have Agreed To ',
                style: TextStyle(color: Color(0xFF555555), fontSize: 12),
                children: [
                  TextSpan(
                    text: 'The Terms And Conditions',
                    style: TextStyle(color: primaryColor),
                  ),
                  TextSpan(text: ' And '),
                  TextSpan(
                    text: 'Privacy Policy.',
                    style: TextStyle(color: primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
