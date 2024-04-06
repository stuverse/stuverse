class MentorPost {
  MentorPost({
    required this.id,
    required this.name,
    required this.isFree,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.mentor,
    required this.isReported,
  });
  late final int id;
  late final String name;
  late final bool isFree;
  late final String description;
  late final String createdAt;
  late final String updatedAt;
  late final String price;
  late final Mentor mentor;
  late final bool isReported;

  MentorPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isFree = json['isFree'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    mentor = Mentor.fromJson(json['mentor']);
    isReported = json['is_reported'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isFree'] = isFree;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['price'] = price;
    _data['mentor'] = mentor.toJson();
    _data['is_reported'] = isReported;
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
    required this.linkedin,
    required this.github,
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
  late final String linkedin;
  late final String github;
  late final List<Skills> skills;
  late final int experienceYears;

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    image = json['image'];
    about = json['about'];
    linkedin = json['linkedin'];
    github = json['github'];
    skills = List.from(json['skills']).map((e) => Skills.fromJson(e)).toList();
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
    _data['skills'] = skills.map((e) => e.toJson()).toList();
    _data['experience_years'] = experienceYears;
    return _data;
  }
}

class Skills {
  Skills({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
