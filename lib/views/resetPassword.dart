import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/forgetpassword/ResetPasswordController.dart';
import 'package:iforenta_app/funcions/validatorinput.dart';
import 'package:iforenta_app/views/widgets/custombuttonauth.dart';
import 'package:iforenta_app/views/widgets/customtextbodyauth.dart';
import 'package:iforenta_app/views/widgets/customtextformauth.dart';
import 'package:iforenta_app/views/widgets/customtexttitleauth.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ResetpasswordcontrollerImp controller =
        Get.put(ResetpasswordcontrollerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                const SizedBox(height: 50),
                const Customtexttitle(text: "New Password"),
                const SizedBox(height: 10),
                const Customtextbodyayth(text: "Enter your new password"),
                const SizedBox(height: 20),

                // كلمة المرور الجديدة
                CustomAuthTextFormField(
                  isNumber: false,
                  mycontroller: controller.password,
                  hinttext: "Enter new password",
                  iconData: Icons.lock_outline,
                  labelttext: "Password",
                  valid: (val) => validinput(val!, 5, 30, "password"),
                ),

                // إعادة كلمة المرور
                CustomAuthTextFormField(
                  isNumber: false,
                  mycontroller: controller.repassword,
                  hinttext: "Re-enter new password",
                  iconData: Icons.lock_reset_outlined,
                  labelttext: "Re-enter Password",
                  valid: (val) => validinput(val!, 5, 30, "repassword"),
                ),

                const SizedBox(height: 25),

                // زر تأكيد
                CustomButtomAuth(
                  text: "Confirm",
                  onPressed: () {
                    controller.goTosuccessResetpassword();
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
