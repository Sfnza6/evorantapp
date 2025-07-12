// lib/controllers/login_controller_imp.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iforenta_app/services/crud_service.dart';
import 'package:iforenta_app/services/linkapi.dart';
import 'package:iforenta_app/routes/app_routes.dart';
import 'package:iforenta_app/controllers/user_session_controller.dart';

class LoginControllerImp extends GetxController {
  final formState = GlobalKey<FormState>();

  late TextEditingController phone;
  late TextEditingController password;

  final Crud _crud = Crud();

  /// متحكّم الجلسة
  final _session = Get.find<UserSessionController>();

  /// لإظهار/إخفاء كلمة المرور
  final hidePassword = true.obs;

  /// حالة التحميل
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phone.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (!(formState.currentState?.validate() ?? false)) {
      return;
    }
    isLoading(true);
    try {
      final response = await _crud.postData(AppLink.login, {
        'phone': phone.text.trim(),
        'password': password.text.trim(),
      });

      if (response['status'] == 'success') {
        // استخراج الـ userId من الاستجابة
        final raw = response['data']?['id'] ?? response['id'] ?? 0;
        final userId = raw is int ? raw : int.tryParse(raw.toString()) ?? 0;

        // حفظ المعرف في جلسة المستخدم
        _session.setUserId(userId);

        // الانتقال إلى الصفحة الرئيسية
        Get.offAllNamed(AppRoutes.homepage);
      } else {
        Get.defaultDialog(
          title: 'فشل الدخول',
          middleText: 'رقم الهاتف أو كلمة المرور غير صحيحة',
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء المحاولة، يرجى المحاولة لاحقًا.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void goToSignUp() {
    Get.offNamed(AppRoutes.register);
  }
}
