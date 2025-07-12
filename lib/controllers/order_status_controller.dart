// lib/controllers/order_status_controller.dart

import 'dart:async';
import 'package:get/get.dart';
import '../services/api_service.dart';

class OrderStatusController extends GetxController {
  final int orderId = Get.arguments as int;
  final api = ApiService();

  var status = 'pending'.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // استهلال الـ polling كل 3 ثواني
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final s = await api.fetchOrderStatus(orderId);
      status.value = s;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
