// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread_vote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThreadVote _$ThreadVoteFromJson(Map<String, dynamic> json) {
  return _ThreadVote.fromJson(json);
}

/// @nodoc
mixin _$ThreadVote {
  @JsonKey(name: 'is_voted')
  bool? get isVoted => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_votes')
  int? get totalVotes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadVoteCopyWith<ThreadVote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadVoteCopyWith<$Res> {
  factory $ThreadVoteCopyWith(
          ThreadVote value, $Res Function(ThreadVote) then) =
      _$ThreadVoteCopyWithImpl<$Res, ThreadVote>;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_voted') bool? isVoted,
      int? value,
      @JsonKey(name: 'total_votes') int? totalVotes});
}

/// @nodoc
class _$ThreadVoteCopyWithImpl<$Res, $Val extends ThreadVote>
    implements $ThreadVoteCopyWith<$Res> {
  _$ThreadVoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVoted = freezed,
    Object? value = freezed,
    Object? totalVotes = freezed,
  }) {
    return _then(_value.copyWith(
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVotes: freezed == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreadVoteImplCopyWith<$Res>
    implements $ThreadVoteCopyWith<$Res> {
  factory _$$ThreadVoteImplCopyWith(
          _$ThreadVoteImpl value, $Res Function(_$ThreadVoteImpl) then) =
      __$$ThreadVoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_voted') bool? isVoted,
      int? value,
      @JsonKey(name: 'total_votes') int? totalVotes});
}

/// @nodoc
class __$$ThreadVoteImplCopyWithImpl<$Res>
    extends _$ThreadVoteCopyWithImpl<$Res, _$ThreadVoteImpl>
    implements _$$ThreadVoteImplCopyWith<$Res> {
  __$$ThreadVoteImplCopyWithImpl(
      _$ThreadVoteImpl _value, $Res Function(_$ThreadVoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVoted = freezed,
    Object? value = freezed,
    Object? totalVotes = freezed,
  }) {
    return _then(_$ThreadVoteImpl(
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVotes: freezed == totalVotes
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadVoteImpl implements _ThreadVote {
  _$ThreadVoteImpl(
      {@JsonKey(name: 'is_voted') this.isVoted,
      this.value,
      @JsonKey(name: 'total_votes') this.totalVotes});

  factory _$ThreadVoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadVoteImplFromJson(json);

  @override
  @JsonKey(name: 'is_voted')
  final bool? isVoted;
  @override
  final int? value;
  @override
  @JsonKey(name: 'total_votes')
  final int? totalVotes;

  @override
  String toString() {
    return 'ThreadVote(isVoted: $isVoted, value: $value, totalVotes: $totalVotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadVoteImpl &&
            (identical(other.isVoted, isVoted) || other.isVoted == isVoted) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.totalVotes, totalVotes) ||
                other.totalVotes == totalVotes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isVoted, value, totalVotes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadVoteImplCopyWith<_$ThreadVoteImpl> get copyWith =>
      __$$ThreadVoteImplCopyWithImpl<_$ThreadVoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadVoteImplToJson(
      this,
    );
  }
}

abstract class _ThreadVote implements ThreadVote {
  factory _ThreadVote(
      {@JsonKey(name: 'is_voted') final bool? isVoted,
      final int? value,
      @JsonKey(name: 'total_votes') final int? totalVotes}) = _$ThreadVoteImpl;

  factory _ThreadVote.fromJson(Map<String, dynamic> json) =
      _$ThreadVoteImpl.fromJson;

  @override
  @JsonKey(name: 'is_voted')
  bool? get isVoted;
  @override
  int? get value;
  @override
  @JsonKey(name: 'total_votes')
  int? get totalVotes;
  @override
  @JsonKey(ignore: true)
  _$$ThreadVoteImplCopyWith<_$ThreadVoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
