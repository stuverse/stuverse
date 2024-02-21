class ThreadVote {
  bool? isVoted;
  int? value;
  int? totalVotes;

  ThreadVote({this.isVoted, this.value, this.totalVotes});

  @override
  String toString() {
    return 'Vote(isVoted: $isVoted, value: $value, totalVotes: $totalVotes)';
  }

  factory ThreadVote.fromJson(Map<String, dynamic> json) => ThreadVote(
        isVoted: json['is_voted'] as bool?,
        value: json['value'] as int?,
        totalVotes: json['total_votes'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'is_voted': isVoted,
        'value': value,
        'total_votes': totalVotes,
      };
}
