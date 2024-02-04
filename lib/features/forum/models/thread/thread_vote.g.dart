// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThreadVoteImpl _$$ThreadVoteImplFromJson(Map<String, dynamic> json) =>
    _$ThreadVoteImpl(
      isVoted: json['is_voted'] as bool?,
      value: json['value'] as int?,
      totalVotes: json['total_votes'] as int?,
    );

Map<String, dynamic> _$$ThreadVoteImplToJson(_$ThreadVoteImpl instance) =>
    <String, dynamic>{
      'is_voted': instance.isVoted,
      'value': instance.value,
      'total_votes': instance.totalVotes,
    };
