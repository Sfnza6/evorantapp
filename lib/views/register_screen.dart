import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/RegisterController.dart';
import 'package:iforenta_app/views/widgets/customtextformauth.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controller = Get.put(SignUpControllerImp());

  static const Color primaryColor = Color(0xFFFFD700); // لون إيفورنتا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formState,
          child: Column(
            children: [
              // ✅ صورة الترحيب
              Image.asset(
                'assets/images/welcome.png',
                height: 180,
              ),
              const SizedBox(height: 30),

              // Full Name
              CustomAuthTextFormField(
                mycontroller: controller.username,
                hinttext: "Enter your full name",
                iconData: Icons.person_outline,
                labelttext: "Full Name",
                valid: (val) => val!.isEmpty ? "Name is required" : null,
              ),

              // Phone
              CustomAuthTextFormField(
                mycontroller: controller.phone,
                hinttext: "Enter your phone number",
                iconData: Icons.phone_android_outlined,
                labelttext: "Phone",
                isNumber: true,
                valid: (val) => val!.length < 9 ? "Invalid phone" : null,
              ),

              // Password
              CustomAuthTextFormField(
                mycontroller: controller.password,
                hinttext: "Enter your password",
                labelttext: "Password",
                obscuretext: true, // يمكن تعديله بإضافة toggle لاحقًا
                iconData: Icons.lock_outline,
                valid: (val) =>
                    val!.length < 6 ? "At least 6 characters" : null,
              ),

              const SizedBox(height: 20),

              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Create Account"),
                ),
              ),

              const SizedBox(height: 20),

              // Link to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: controller.goToSignIn,
                    child: const Text(
                      "Login",
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
