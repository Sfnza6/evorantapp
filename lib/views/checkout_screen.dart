import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../controllers/user_session_controller.dart';
import '../../services/api_service.dart';
import '../../routes/app_routes.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  // متحكّم لحقل العنوان
  final _addressC = TextEditingController();

  // instance لخدمة الـ API
  final _api = ApiService();

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();
    final paymentCtrl = Get.put(PaymentController());
    final sessCtrl = Get.find<UserSessionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الدفع'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) العنوان
            const Text('العنوان',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _addressC,
              decoration: InputDecoration(
                hintText: 'أدخل عنوان التوصيل',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),

            const SizedBox(height: 16),

            // 2) طريقة الدفع
            const Text('طريقة الدفع',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => Column(
                  children: [
                    RadioListTile<int>(
                      value: 0,
                      groupValue: paymentCtrl.selectedMethod.value,
                      title: const Text('نقدًا عند التسليم'),
                      onChanged: paymentCtrl.selectMethod,
                    ),
                    RadioListTile<int>(
                      value: 1,
                      groupValue: paymentCtrl.selectedMethod.value,
                      title: const Text('بطاقة ائتمانية'),
                      onChanged: paymentCtrl.selectMethod,
                    ),
                  ],
                )),

            const SizedBox(height: 16),

            // 3) ملخص الطلب
            const Text('ملخص الطلب',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (cartCtrl.items.isEmpty) {
                  return const Center(child: Text('السلة فارغة'));
                }
                return ListView.builder(
                  itemCount: cartCtrl.items.length,
                  itemBuilder: (_, i) {
                    final ci = cartCtrl.items[i];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: ci.item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const Center(
                              child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )),
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.error_outline),
                        ),
                      ),
                      title: Text(ci.item.name),
                      subtitle: Text('${ci.quantity} × ${ci.item.price} د.ل'),
                      trailing: Text(
                        '${ci.totalPrice.toStringAsFixed(2)} د.ل',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 16),

            // 4) المجموع + زر الدفع
            Obx(() {
              final hasItems = cartCtrl.items.isNotEmpty;
              return Row(
                children: [
                  const Text('المجموع: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    '${cartCtrl.totalAmount.toStringAsFixed(2)} د.ل',
                    style:
                        const TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                  const Spacer(),
                  if (hasItems)
                    ElevatedButton(
                      onPressed: () async {
                        final address = _addressC.text.trim();
                        if (address.isEmpty) {
                          Get.snackbar(
                            'خطأ',
                            'يرجى إدخال عنوان التوصيل.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        try {
                          // إنشاء الطلب واسترجاع orderId
                          final orderId = await _api.createOrder(
                            sessCtrl.userId.value!,
                            cartCtrl.items.toList(),
                            address,
                          );
                          // الانتقال لشاشة تتبع الحالة
                          Get.toNamed(AppRoutes.orderStatus,
                              arguments: orderId);
                        } catch (e) {
                          Get.snackbar(
                            'خطأ',
                            'فشل إنشاء الطلب:\n$e',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('دفع', style: TextStyle(fontSize: 18)),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
