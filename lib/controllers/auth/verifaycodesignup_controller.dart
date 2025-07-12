import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';
import 'package:iforenta_app/services/statusrequest.dart';

abstract class Verifiycodesignupcontroller extends GetxController {
  checkcode();
  goTosuccesssignup();
}

class VerifiycodesignupcontrollerImp extends Verifiycodesignupcontroller {
  late String verifycode;
  late StatusRequest statusRequest;

  late String email;

  @override
  checkcode() {}

  @override
  goTosuccesssignup() async {
    Get.offNamed(AppRoutes.successSignup);
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['email'] != null) {
      email = Get.arguments['email'];
    } else {
      email = ''; // أو قيمة افتراضية حسب استخدامك
      print("Warning: Get.arguments is null or missing 'email' key");
    }
    super.onInit();
  }
}
