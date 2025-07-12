// lib/views/sections/favorites_screen.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/favorite_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../models/food_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.find<FavoriteController>();
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('❤️ المفضلة'),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (favCtrl.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset(
                    'assets/lottie/FavoritesScreen.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'المفضلة فارغة',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favCtrl.favorites.length,
          itemBuilder: (_, index) {
            final FoodItem item = favCtrl.favorites[index];
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showItemSheet(context, item, cartCtrl),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.error_outline),
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text('${item.price.toStringAsFixed(2)} د.ل'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => favCtrl.toggleFavorite(item),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showItemSheet(
      BuildContext context, FoodItem item, CartController cartCtrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // اسم الصنف
              Text(
                item.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // وصف الصنف

              const SizedBox(height: 12),

              // السعر
              Text(
                'السعر: ${item.price.toStringAsFixed(2)} د.ل',
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              const SizedBox(height: 16),

              // زر إضافة إلى السلة
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    cartCtrl.addToCart(item.id);
                    Get.back(); // تغلق الـ bottom sheet
                    Get.snackbar(
                      'أُضيف إلى السلة',
                      item.name,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('أضف إلى السلة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
