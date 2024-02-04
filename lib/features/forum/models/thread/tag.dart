import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class ThreadTag with _$ThreadTag {
  factory ThreadTag({
    int? id,
    String? name,
    String? background,
    @JsonKey(name: 'on_background') String? onBackground,
  }) = _Tag;

  factory ThreadTag.fromJson(Map<String, dynamic> json) =>
      _$ThreadTagFromJson(json);
}
