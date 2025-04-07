class UserImage {
  final String name;
  final String imageUrl;

  UserImage({required this.name, required this.imageUrl});

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}