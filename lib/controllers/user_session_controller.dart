// lib/controllers/user_session_controller.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserSessionController extends GetxController {
  static const _keyUserId = 'userId';
  final _storage = GetStorage();

  /// معرّف المستخدم الحالي (null إذا غير مسجّل دخول)
  final userId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    // استرجاع المعرّف لو موجود
    final stored = _storage.read<int>(_keyUserId);
    if (stored != null && stored > 0) {
      userId.value = stored;
    }
  }

  /// حفظ معرّف المستخدم في التخزين والجلسة
  void setUserId(int id) {
    userId.value = id;
    _storage.write(_keyUserId, id);
  }

  /// مسح الجلسة (تسجيل الخروج)
  void clearSession() {
    userId.value = null;
    _storage.remove(_keyUserId);
  }

  bool get isLoggedIn => userId.value != null;
}
