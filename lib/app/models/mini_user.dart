class MiniUser {
	int? id;
	String? email;
	String? name;
	String? image;

	MiniUser({this.id, this.email, this.name, this.image});

	factory MiniUser.fromJson(Map<String, dynamic> json) {
		return MiniUser(
			id: json['id'] as int?,
			email: json['email'] as String?,
			name: json['name'] as String?,
			image: json['image'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'email': email,
				'name': name,
				'image': image,
			};
}
