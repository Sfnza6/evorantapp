// lib/views/widgets/food_item_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/food_item.dart';
import '../../routes/app_routes.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem item;
  final bool isFeatured;

  const FoodItemCard({
    super.key,
    required this.item,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    // جلب الكنترولرز مرة واحدة
    final favCtrl = Get.find<FavoriteController>();
    final cartCtrl = Get.find<CartController>();

    final imageSize = isFeatured ? 80.0 : 80.0;

    return Card(
      color: Colors.white,
      margin: isFeatured
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.toNamed(AppRoutes.productDetail, arguments: item);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // صورة الصنف
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: const Center(
                      child: Icon(Icons.error_outline),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // نص الاسم والسعر
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم الصنف
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // السعر
                    Text(
                      '${item.price.toStringAsFixed(2)} د.ل',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 4),

              // زر المفضلة
              Obx(() {
                final isFav = favCtrl.favorites.any((f) => f.id == item.id);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    favCtrl.toggleFavorite(item);
                    if (!isFav) {
                      _showFavoriteSheet(context, item, cartCtrl);
                    } else {
                      Get.snackbar(
                        'حُذف من المفضلة',
                        item.name,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                );
              }),

              // سهم التنقل
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showFavoriteSheet(
      BuildContext context, FoodItem item, CartController cartCtrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SingleChildScrollView(
        child: Padding(
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
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Text(
                'السعر: ${item.price.toStringAsFixed(2)} د.ل',
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    cartCtrl.addToCart(item.id);
                    Navigator.pop(context);
                    Get.snackbar(
                      'أُضيف إلى السلة',
                      item.name,
                      snackPosition: SnackPosition.TOP,
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
        ),
      ),
    );
  }
}
