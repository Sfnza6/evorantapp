// في lib/controllers/payment_controller.dart
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedMethod = 0.obs;

  // عدّلت هنا ليأخذ int?
  void selectMethod(int? idx) {
    if (idx != null) selectedMethod.value = idx;
  }
}
