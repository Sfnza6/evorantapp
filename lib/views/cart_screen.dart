// lib/views/home/cart/cart_screen.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/cart_controller.dart';
import '../../../routes/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Obx(() {
      final hasItems = cartCtrl.items.isNotEmpty;

      return Scaffold(
        appBar: AppBar(
          title: const Text('🛒 السلة'),
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: Colors.white,
        body: hasItems
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
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
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                              errorWidget: (_, __, ___) =>
                                  const Icon(Icons.error_outline),
                            ),
                          ),
                          title: Text(ci.item.name),
                          subtitle: Text(
                            '${ci.quantity} × ${ci.item.price} د.ل = ${ci.totalPrice.toStringAsFixed(2)} د.ل',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () =>
                                    cartCtrl.changeQuantity(ci, -1),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cartCtrl.changeQuantity(ci, 1),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'المجموع:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '${cartCtrl.totalAmount.toStringAsFixed(2)} د.ل',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // أنيميشن لوتي للسلة الفارغة
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Lottie.asset(
                        'assets/lottie/CartScreen.json',
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'السلة فارغة',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
        floatingActionButton: hasItems
            ? FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                onPressed: () => Get.toNamed(AppRoutes.checkout),
                icon: const Icon(Icons.payment),
                label: const Text('الذهاب لتأكيد الطلب'),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
