import 'package:freezed_annotation/freezed_annotation.dart';

import 'author.dart';
import 'community.dart';
import 'tag.dart';
import 'thread_vote.dart';

part 'thread.freezed.dart';
part 'thread.g.dart';

@freezed
class Thread with _$Thread {
  factory Thread({
    int? id,
    ThreadAuthor? author,
    ThreadCommunity? community,
    ThreadVote? vote,
    List<ThreadTag>? tags,
    String? title,
    String? content,
    String? image,
    @JsonKey(name: 'share_count') int? shareCount,
    @JsonKey(name: 'comments_count') int? commentsCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Thread;

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
}
