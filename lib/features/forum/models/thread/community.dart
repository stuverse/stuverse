import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@freezed
class ThreadCommunity with _$ThreadCommunity {
  factory ThreadCommunity({
    int? id,
    String? name,
    String? image,
  }) = _Community;

  factory ThreadCommunity.fromJson(Map<String, dynamic> json) =>
      _$ThreadCommunityFromJson(json);
}
