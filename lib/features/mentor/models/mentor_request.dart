class MentorRequest {
  MentorRequest({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.mentor,
    required this.isReported,
  });
  late final int id;
  late final String description;
  late final String createdAt;
  late final Mentor mentor;
  late final bool isReported;
  late final bool isUserBlocked;

  MentorRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['created_at'];
    mentor = Mentor.fromJson(json['mentor']);
    isReported = json['is_reported'];
    isUserBlocked = json['is_user_blocked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['mentor'] = mentor.toJson();
    _data['is_reported'] = isReported;
    _data['is_user_blocked'] = isUserBlocked;
    return _data;
  }
}

class Mentor {
  Mentor({
    required this.id,
    required this.name,
    required this.type,
    required this.mobile,
    required this.createdAt,
    required this.image,
    required this.about,
    this.linkedin,
    this.github,
    required this.skills,
    required this.experienceYears,
  });
  late final int id;
  late final String name;
  late final String type;
  late final String mobile;
  late final String createdAt;
  late final String image;
  late final String about;
  late final Null linkedin;
  late final Null github;
  late final List<dynamic> skills;
  late final int experienceYears;

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    image = json['image'];
    about = json['about'];
    linkedin = null;
    github = null;
    skills = List.castFrom<dynamic, dynamic>(json['skills']);
    experienceYears = json['experience_years'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['mobile'] = mobile;
    _data['created_at'] = createdAt;
    _data['image'] = image;
    _data['about'] = about;
    _data['linkedin'] = linkedin;
    _data['github'] = github;
    _data['skills'] = skills;
    _data['experience_years'] = experienceYears;
    return _data;
  }
}
