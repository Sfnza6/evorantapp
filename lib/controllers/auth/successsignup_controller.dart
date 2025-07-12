import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';

abstract class Successsignupcontroller extends GetxController {
  gotopagelogin();
}

class Successsignupcontrollerimp extends Successsignupcontroller {
  @override
  gotopagelogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
