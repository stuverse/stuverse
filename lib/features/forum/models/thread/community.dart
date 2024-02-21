class ThreadCommunity {
  int? id;
  String? name;
  String? image;

  ThreadCommunity({this.id, this.name, this.image});

  @override
  String toString() => 'Community(id: $id, name: $name, image: $image)';

  factory ThreadCommunity.fromJson(Map<String, dynamic> json) =>
      ThreadCommunity(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
