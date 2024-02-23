class MentorPost {
  MentorPost({
    required this.id,
    required this.name,
    required this.isFree,
    required this.description,
    required this.price,
    required this.mentor,
  });
  late final int id;
  late final String name;
  late final bool isFree;
  late final String description;
  late final String price;
  late final int mentor;
  
  MentorPost.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isFree = json['isFree'];
    description = json['description'];
    price = json['price'];
    mentor = json['mentor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isFree'] = isFree;
    _data['description'] = description;
    _data['price'] = price;
    _data['mentor'] = mentor;
    return _data;
  }
}