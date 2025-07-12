import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';

abstract class ForgetPasswordController extends GetxController {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  void goToVerifyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController phone;

  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  void goToVerifyCode() {
    // طباعة رقم الهاتف للتأكد
    print("Phone submitted: ${phone.text}");

    // التحقق من أن الحقل ليس فارغًا
    if (phone.text.isNotEmpty) {
      // الانتقال مع إرسال البيانات إلى صفحة التحقق
      Get.toNamed(
        AppRoutes.verification,
        arguments: {
          "phone": phone.text
        }, // إذا كنت تريد استخدام "email" بدلاً من "phone" عدل هنا وهناك
      );
    } else {
      // يمكن عرض تنبيه للمستخدم في حال الحقل فارغ
      Get.snackbar("تنبيه", "يرجى إدخال رقم الهاتف أولاً");
    }
  }
}
