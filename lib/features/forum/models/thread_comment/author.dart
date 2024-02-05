class CommentAuthor {
  int? id;
  String? image;
  String? name;
  String? username;
  String? email;
  String? type;

  CommentAuthor({
    this.id,
    this.image,
    this.name,
    this.username,
    this.email,
    this.type,
  });

  @override
  String toString() {
    return 'Author(id: $id, image: $image, name: $name, username: $username, email: $email, type: $type)';
  }

  factory CommentAuthor.fromJson(Map<String, dynamic> json) => CommentAuthor(
        id: json['id'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'username': username,
        'email': email,
        'type': type,
      };
}
