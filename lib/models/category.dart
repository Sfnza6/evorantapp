// lib/models/category.dart
class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    // id قد يأتي كنص أو رقم
    final idVal = json['id'];
    final idInt = idVal is int ? idVal : int.tryParse(idVal.toString()) ?? 0;

    return Category(
      id: idInt,
      name: json['name']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'image_url': imageUrl,
      };
}
