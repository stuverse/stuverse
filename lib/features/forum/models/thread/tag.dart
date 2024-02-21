class ThreadTag {
  int? id;
  String? name;
  String? background;
  String? onBackground;

  ThreadTag({this.id, this.name, this.background, this.onBackground});

  @override
  String toString() {
    return 'Tag(id: $id, name: $name, background: $background, onBackground: $onBackground)';
  }

  factory ThreadTag.fromJson(Map<String, dynamic> json) => ThreadTag(
        id: json['id'] as int?,
        name: json['name'] as String?,
        background: json['background'] as String?,
        onBackground: json['on_background'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'background': background,
        'on_background': onBackground,
      };
}
