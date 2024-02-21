

import 'mentor.dart';

class MentorPost {
  MentorPost({
    required this.id,
    required this.name,
    required this.isFree,
    required this.description,
    required this.mentor,
    required this.price,
  });
  late final int id;
  late final String name;
  late final bool isFree;
  late final String description;
  late final Mentor mentor;
  late final String price;
  
  MentorPost.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isFree = json['isFree'];
    description = json['description'];
    mentor = Mentor.fromJson(json['mentor']); 
    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isFree'] = isFree;
    _data['description'] = description;
    _data['mentor'] = mentor;
    return _data;
  }
}