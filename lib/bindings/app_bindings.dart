// lib/bindings/app_bindings.dart
import 'package:get/get.dart';
import 'package:iforenta_app/controllers/auth/RegisterController.dart';
import 'package:iforenta_app/controllers/cart_controller.dart';
import 'package:iforenta_app/controllers/favorite_controller.dart';
import 'package:iforenta_app/controllers/user_session_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserSessionController(), permanent: true);
    // ربط الكنترولر مرة واحدة فقط
    Get.lazyPut<SignUpControllerImp>(() => SignUpControllerImp());
    Get.put(CartController());

    Get.put(CartController());
    Get.put(FavoriteController());
  }
}
