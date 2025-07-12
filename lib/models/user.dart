class User {
  final int id;
  final String username;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // id قد يأتي كنص أو رقم
    final rawId = json['id'];
    final idVal = rawId is int ? rawId : int.tryParse(rawId.toString()) ?? 0;

    return User(
      id: idVal,
      username: json['username']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }
}
