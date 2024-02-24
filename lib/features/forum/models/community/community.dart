class Community {
  int? id;

  String? name;
  String? image;
  String? description;
  bool? isPrivate;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? moderators;
  List<int>? members;

  Community({
    this.id,
    this.name,
    this.image,
    this.description,
    this.isPrivate,
    this.createdAt,
    this.updatedAt,
    this.moderators,
    this.members,
  });

  @override
  String toString() {
    return 'Community(id: $id, name: $name, image: $image, description: $description, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt, moderators: $moderators, members: $members)';
  }

  factory Community.fromJson(Map<String, dynamic> json) => Community(
          id: json['id'] as int?,
          name: json['name'] as String?,
          image: json['image'] as String?,
          description: json['description'] as String?,
          isPrivate: json['is_private'] as bool?,
          createdAt: json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
          updatedAt: json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
          moderators: [
            for (final moderator in json['moderators']) moderator as int
          ],
          members: [
            for (final member in json['members']) member as int
          ]);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'is_private': isPrivate,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'moderators': moderators,
        'members': members,
      };
}
