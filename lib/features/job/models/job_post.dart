import '../../../app/models/user/skill.dart';

class JobPost {
  int? id;
  String? title;
  String? place;
  String? companyName;
  String? image;
  String? description;
  String? jobType;
  String? jobLocationType;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Skill>? skills;

  JobPost({
    this.id,
    this.title,
    this.place,
    this.companyName,
    this.image,
    this.description,
    this.jobType,
    this.jobLocationType,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.skills,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) => JobPost(
        id: json['id'] as int?,
        title: json['title'] as String?,
        place: json['place'] as String?,
        companyName: json['companyName'] as String?,
        image: json['image'] as String?,
        description: json['description'] as String?,
        jobType: json['jobType'] as String?,
        jobLocationType: json['jobLocationType'] as String?,
        url: json['url'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        skills: (json['skills'] as List<dynamic>?)
            ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'place': place,
        'companyName': companyName,
        'image': image,
        'description': description,
        'jobType': jobType,
        'jobLocationType': jobLocationType,
        'url': url,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'skills': skills?.map((e) => e.toJson()).toList(),
      };
}

class JOB_TYPE {
  static const FULL_TIME = 'fulltime';
  static const PART_TIME = 'parttime';
  static const CONTRACT = 'contract';
  static const INTERNSHIP = 'internship';
  static const TEMPORARY = 'temporary';
}

class JOB_LOCATION_TYPE {
  static const ONSITE = 'onsite';
  static const REMOTE = 'remote';
  static const HYBRID = 'hybrid';
}
