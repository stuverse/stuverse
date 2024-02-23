class JobPost {
  JobPost({
    required this.id,
    required this.title,
    required this.place,
    required this.companyName,
    required this.image,
    required this.description,
    required this.jobType,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String place;
  late final String companyName;
  late final String image;
  late final String description;
  late final String jobType;
  late final String jobLocationType;
  late final String url;
  late final String createdAt;
  late final String updatedAt;

  JobPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    place = json['place'];
    companyName = json['companyName'];
    image = json['image'];
    description = json['description'];
    jobType = json['jobType'];
    jobLocationType = json['jobLocationType'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['place'] = place;
    _data['companyName'] = companyName;
    _data['image'] = image;
    _data['description'] = description;
    _data['jobType'] = jobType;
    _data['jobLocationType'] = jobLocationType;
    _data['url'] = url;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
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
