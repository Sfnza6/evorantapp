// lib/views/widgets/category_item.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iforenta_app/routes/app_routes.dart';

import '../../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // عند الضغط ننتقل إلى شاشة الأصناف الخاصة بهذه الفئة
        Get.toNamed(AppRoutes.categoryitems, arguments: category);
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: category.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
