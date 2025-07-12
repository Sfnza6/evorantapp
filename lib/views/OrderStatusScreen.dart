// lib/views/order_status_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_status_controller.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(OrderStatusController());

    // ترتيب الحالات في قائمة
    final steps = [
      'pending', // تم تأكيد الطلب
      'assigned', // تم قبول السائق
      'preparing', // قيد التحضير
      'picked_up', // تم الاستلام
      'delivered', // تم التوصيل
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('حالة طلبك')),
      body: Obx(() {
        final current = ctrl.status.value;
        final idx = steps.indexOf(current).clamp(0, steps.length - 1);

        return Stepper(
          currentStep: idx,
          controlsBuilder: (_, __) => const SizedBox.shrink(),
          steps: [
            Step(
              title: const Text('تم التأكيد'),
              content: const Text('طلبك قيد الانتظار لتعيين سائق'),
              isActive: idx >= 0,
            ),
            Step(
              title: const Text('تم قبول السائق'),
              content: const Text('السائق قبل طلبك'),
              isActive: idx >= 1,
            ),
            Step(
              title: const Text('قيد التحضير'),
              content: const Text('يتم تجهيز طلبك'),
              isActive: idx >= 2,
            ),
            Step(
              title: const Text('تم الاستلام'),
              content: const Text('السائق مع الطلب'),
              isActive: idx >= 3,
            ),
            Step(
              title: const Text('تم التوصيل'),
              content: const Text('لقد تم توصيل طلبك'),
              isActive: idx >= 4,
            ),
          ],
        );
      }),
    );
  }
}
