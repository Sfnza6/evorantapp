// lib/views/product/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../models/food_item.dart';

class ProductDetailScreen extends StatelessWidget {
  final FoodItem item;
  const ProductDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ◀️ صار هنا شبكة لا أصول
          CachedNetworkImage(
            imageUrl: item.imageUrl,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (_, __, ___) =>
                const Icon(Icons.error_outline, size: 80),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(item.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("السعر: ${item.price.toStringAsFixed(2)} د.ل",
                style: const TextStyle(color: Colors.redAccent, fontSize: 18)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartCtrl.addToCart(item.id);
                  Get.snackbar('أضيف إلى السلة', item.name,
                      snackPosition: SnackPosition.TOP);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child:
                    const Text("أضف إلى السلة", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
