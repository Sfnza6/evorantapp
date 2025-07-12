// lib/models/food_item.dart
class FoodItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int categoryId;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    // id
    final idVal = json['id'];
    final idInt = idVal is int ? idVal : int.tryParse(idVal.toString()) ?? 0;

    // price
    final prVal = json['price'];
    final prDouble = prVal is num
        ? prVal.toDouble()
        : double.tryParse(prVal.toString()) ?? 0.0;

    // category_id
    final catVal = json['category_id'];
    final catInt =
        catVal is int ? catVal : int.tryParse(catVal.toString()) ?? 0;

    return FoodItem(
      id: idInt,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: prDouble,
      imageUrl: json['image_url']?.toString() ?? '',
      categoryId: catInt,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'image_url': imageUrl,
        'category_id': categoryId,
      };
}
