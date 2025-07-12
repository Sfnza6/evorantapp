import 'package:get/get.dart';
import 'package:iforenta_app/routes/app_routes.dart';

abstract class Successresetpasswordcontroller extends GetxController {
  gotopagelogin();
}

class Successresetpasswordcontrollerimp extends Successresetpasswordcontroller {
  @override
  gotopagelogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
