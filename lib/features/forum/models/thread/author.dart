import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@freezed
class ThreadAuthor with _$ThreadAuthor {
  factory ThreadAuthor({
    int? id,
    String? image,
    String? name,
    String? username,
    String? email,
    String? type,
  }) = _Author;

  factory ThreadAuthor.fromJson(Map<String, dynamic> json) =>
      _$ThreadAuthorFromJson(json);
}
