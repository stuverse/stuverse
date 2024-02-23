class Skill {
  int? id;
  String? name;

  Skill({this.id, this.name});

  @override
  String toString() => 'Skill(id: $id, name: $name)';

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
