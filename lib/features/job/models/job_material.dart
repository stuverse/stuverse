class JobMaterial {
  int? id;
  String? title;
  String? description;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  JobMaterial({
    this.id,
    this.title,
    this.description,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory JobMaterial.fromJson(Map<String, dynamic> json) => JobMaterial(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'url': url,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
