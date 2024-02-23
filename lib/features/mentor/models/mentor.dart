import 'skill.dart';

class Mentor {
  int? id;
  String? name;
  String? type;
  String? mobile;
  DateTime? createdAt;
  String? image;
  String? about;
  String? linkedin;
  String? github;
  List<Skill>? skills;
  int? experienceYears;

  Mentor({
    this.id,
    this.name,
    this.type,
    this.mobile,
    this.createdAt,
    this.image,
    this.about,
    this.linkedin,
    this.github,
    this.skills,
    this.experienceYears,
  });

  @override
  String toString() {
    return 'Mentor(id: $id, name: $name, type: $type, mobile: $mobile, createdAt: $createdAt, image: $image, about: $about, linkedin: $linkedin, github: $github, skills: $skills, experienceYears: $experienceYears)';
  }

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        id: json['id'] as int?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        mobile: json['mobile'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        image: json['image'] as String?,
        about: json['about'] as String?,
        linkedin: json['linkedin'] as dynamic,
        github: json['github'] as dynamic,
        skills: (json['skills'] as List<dynamic>?)
            ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
            .toList(),
        experienceYears: json['experience_years'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'mobile': mobile,
        'created_at': createdAt?.toIso8601String(),
        'image': image,
        'about': about,
        'linkedin': linkedin,
        'github': github,
        'skills': skills?.map((e) => e.toJson()).toList(),
        'experience_years': experienceYears,
      };
}
