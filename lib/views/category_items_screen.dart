// lib/views/category_items_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/category.dart';
import '../models/food_item.dart';
import 'widgets/food_item_card.dart';

class CategoryItemsScreen extends StatelessWidget {
  final Category category;
  const CategoryItemsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // نستخدم HomeController لأنه يحمل قائمة foodItems الكاملة
    final homeCtrl = Get.find<HomeController>();

    // نصفي الأصناف بناءً على category.id
    final List<FoodItem> items =
        homeCtrl.foodItems.where((f) => f.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.redAccent,
      ),
      body: items.isEmpty
          ? const Center(child: Text('لا توجد أصناف في هذه الفئة'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) => FoodItemCard(item: items[i]),
            ),
    );
  }
}
