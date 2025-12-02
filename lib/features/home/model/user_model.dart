class UserModel {
  final String uid;
  final String email;
  final String name;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['avatarUrl'] ?? '',
    );
  }
}
