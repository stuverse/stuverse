import 'mentor.dart';

class MentorPost {
  int? id;
  Mentor? mentor;
  String? name;
  bool? isFree;
  String? description;
  String? price;

  MentorPost({
    this.id,
    this.mentor,
    this.name,
    this.isFree,
    this.description,
    this.price,
  });

  @override
  String toString() {
    return 'MentorPost(id: $id, mentor: $mentor, name: $name, isFree: $isFree, description: $description, price: $price)';
  }

  factory MentorPost.fromJson(Map<String, dynamic> json) => MentorPost(
        id: json['id'] as int?,
        mentor: json['mentor'] == null
            ? null
            : Mentor.fromJson(json['mentor'] as Map<String, dynamic>),
        name: json['name'] as String?,
        isFree: json['isFree'] as bool?,
        description: json['description'] as String?,
        price: json['price'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'mentor': mentor?.toJson(),
        'name': name,
        'isFree': isFree,
        'description': description,
        'price': price,
      };
}
