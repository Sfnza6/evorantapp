import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';

abstract class Verifiycodecontroller extends GetxController {
  void goToResetpassword();
}

class VerifiycodecontrollerImp extends Verifiycodecontroller {
  @override
  void goToResetpassword() {
    // ✅ هنا يتم التحقق من الكود، ثم الانتقال
    print("Code verified successfully");
    Get.toNamed(AppRoutes.resetPassword);
  }
}
