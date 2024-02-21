class Mentor {
  Mentor({
    required this.id,
    required this.fullName,
    required this.bio,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.image,
    required this.isStudent,
    required this.experience,
  });
  late final int id;
  late final String fullName;
  late final String bio;
  late final String username;
  late final String email;
  late final String password;
  late final String phoneNumber;
  late final String image;
  late final bool isStudent;
  late final int experience;
  
  Mentor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullName = json['full_name'];
    bio = json['bio'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    isStudent = json['isStudent'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    _data['bio'] = bio;
    _data['username'] = username;
    _data['email'] = email;
    _data['password'] = password;
    _data['phone_number'] = phoneNumber;
    _data['image'] = image;
    _data['isStudent'] = isStudent;
    _data['experience'] = experience;
    return _data;
  }
}