import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
	factory Skill({
		int? id,
		String? name,
	}) = _Skill;

	factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}