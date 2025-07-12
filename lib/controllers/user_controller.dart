// lib/controllers/profile_controller.dart

import 'package:get/get.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import 'user_session_controller.dart';
import '../routes/app_routes.dart';

class ProfileController extends GetxController {
  final session = Get.find<UserSessionController>();
  final isLoading = false.obs;
  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    final uid = session.userId.value;
    if (uid == null) {
      // جدولة التنقل بعد انتهاء البناء الحالي
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(AppRoutes.login);
      });
      return;
    }

    try {
      isLoading(true);
      final u = await ApiService().fetchUser(uid);
      if (u == null) {
        Future.delayed(Duration.zero, () {
          Get.snackbar('خطأ', 'المستخدم غير موجود',
              snackPosition: SnackPosition.BOTTOM);
          Get.offAllNamed(AppRoutes.login);
        });
      } else {
        user.value = u;
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Get.snackbar('خطأ', 'فشل جلب بيانات الحساب:\n$e',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed(AppRoutes.login);
      });
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    session.clearSession();
    Future.delayed(Duration.zero, () {
      Get.offAllNamed(AppRoutes.login);
    });
  }
}
