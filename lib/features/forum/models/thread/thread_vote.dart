import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_vote.freezed.dart';
part 'thread_vote.g.dart';

@freezed
class ThreadVote with _$ThreadVote {
  factory ThreadVote({
    @JsonKey(name: 'is_voted') bool? isVoted,
    int? value,
    @JsonKey(name: 'total_votes') int? totalVotes,
  }) = _ThreadVote;

  factory ThreadVote.fromJson(Map<String, dynamic> json) =>
      _$ThreadVoteFromJson(json);
}
