// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  int id;
  User user;
  String title;
  String description;
  double targetAmount;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  String accountNumber;
  String upiId;
  String images;
  String category;

  Projects({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.accountNumber,
    required this.upiId,
    required this.images,
    required this.category,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        id: json["id"],
        user: User.fromJson(json["user"]),
        title: json["title"],
        description: json["description"],
        targetAmount: json["target_amount"]?.toDouble(),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        accountNumber: json["account_number"],
        upiId: json["upi_id"],
        images: json["images"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "title": title,
        "description": description,
        "target_amount": targetAmount,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "account_number": accountNumber,
        "upi_id": upiId,
        "images": images,
        "category": category,
      };
}

class User {
  String email;
  String name;

  User({
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
