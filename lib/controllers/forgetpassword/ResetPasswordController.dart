import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';

abstract class Resetpasswordcontroller extends GetxController {
  goTosuccessResetpassword();
}

class ResetpasswordcontrollerImp extends Resetpasswordcontroller {
  late TextEditingController password;
  late TextEditingController repassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }

  @override
  goTosuccessResetpassword() {
    if (formstate.currentState!.validate()) {
      if (password.text != repassword.text) {
        Get.snackbar("Error", "Passwords do not match",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // TODO: إرسال البيانات للسيرفر
      print("New password: ${password.text}");

      // الانتقال إلى شاشة النجاح
      Get.toNamed(AppRoutes.successResetPassword);
    }
  }
}
