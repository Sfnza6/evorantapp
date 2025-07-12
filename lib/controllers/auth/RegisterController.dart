import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/services/crud_service.dart';
import 'package:iforenta_app/services/linkapi.dart';

class SignUpControllerImp extends GetxController {
  /// مفتاح النموذج
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  /// حقول الإدخال
  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController password;

  /// للتحكم في إظهار/إخفاء كلمة المرور
  RxBool hidePassword = true.obs;

  /// كائن CRUD لإجراء طلبات الـ API
  Crud crud = Crud();

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  /// دالة لتبديل إظهار/إخفاء كلمة المرور
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// دالة تسجيل المستخدم
  Future<void> signUp() async {
    if (formState.currentState!.validate()) {
      // إرسال الطلب إلى الـ API
      var response = await crud.postData(AppLink.signUp, {
        "username": username.text.trim(),
        "phone": phone.text.trim(),
        "password": password.text.trim(),
      });

      if (response['status'] == "success") {
        /// في حال نجاح التسجيل، نحول المستخدم للشاشة التالية (مثلاً تحقق الكود)
        Get.offNamed("/verifaycodesignup");
      } else {
        /// عرض خطأ في حالة فشل التسجيل
        Get.defaultDialog(
          title: "خطأ في التسجيل",
          middleText: response['message'] ?? "حصل خطأ، أعد المحاولة",
        );
      }
    }
  }

  /// الانتقال لصفحة تسجيل الدخول
  void goToSignIn() {
    Get.offNamed("/login");
  }
}
