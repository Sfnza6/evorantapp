// lib/models/cart_item.dart

import 'food_item.dart';

class CartItem {
  /// هذا هو الـ ID الخاص بجدول cart_items
  final int id;

  /// الصنف نفسه
  final FoodItem item;

  /// الكمية المختارة
  final int quantity;

  CartItem({
    required this.id,
    required this.item,
    required this.quantity,
  });

  /// احسب السعر الإجمالي تلقائياً
  double get totalPrice => item.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // حوّل id
    final rawId = json['cart_item_id'];
    final parsedId = rawId is int ? rawId : int.tryParse(rawId.toString()) ?? 0;

    // حوّل quantity
    final rawQty = json['quantity'];
    final parsedQty =
        rawQty is int ? rawQty : int.tryParse(rawQty.toString()) ?? 1;

    // بنية الـ item نفسها تأتي في صف واحد من JOIN
    final food = FoodItem(
      id: json['item_id'] is int
          ? json['item_id']
          : int.tryParse(json['item_id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price'] is num
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl: json['image_url']?.toString() ?? '',
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.tryParse(json['category_id'].toString()) ?? 0,
    );

    return CartItem(
      id: parsedId,
      item: food,
      quantity: parsedQty,
    );
  }
}
