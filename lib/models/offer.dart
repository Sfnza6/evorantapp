// lib/models/offer.dart
class Offer {
  final int id;
  final String title;
  final String imageUrl;

  Offer({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    final idVal = json['id'];
    final idInt = idVal is int ? idVal : int.tryParse(idVal.toString()) ?? 0;

    return Offer(
      id: idInt,
      title: json['title']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'image_url': imageUrl,
      };
}
