// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Thread _$ThreadFromJson(Map<String, dynamic> json) {
  return _Thread.fromJson(json);
}

/// @nodoc
mixin _$Thread {
  int? get id => throw _privateConstructorUsedError;
  ThreadAuthor? get author => throw _privateConstructorUsedError;
  ThreadCommunity? get community => throw _privateConstructorUsedError;
  ThreadVote? get vote => throw _privateConstructorUsedError;
  List<ThreadTag>? get tags => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'share_count')
  int? get shareCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int? get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadCopyWith<Thread> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadCopyWith<$Res> {
  factory $ThreadCopyWith(Thread value, $Res Function(Thread) then) =
      _$ThreadCopyWithImpl<$Res, Thread>;
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $ThreadAuthorCopyWith<$Res>? get author;
  $ThreadCommunityCopyWith<$Res>? get community;
  $ThreadVoteCopyWith<$Res>? get vote;
}

/// @nodoc
class _$ThreadCopyWithImpl<$Res, $Val extends Thread>
    implements $ThreadCopyWith<$Res> {
  _$ThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = freezed,
    Object? community = freezed,
    Object? vote = freezed,
    Object? tags = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? image = freezed,
    Object? shareCount = freezed,
    Object? commentsCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ThreadAuthor?,
      community: freezed == community
          ? _value.community
          : community // ignore: cast_nullable_to_non_nullable
              as ThreadCommunity?,
      vote: freezed == vote
          ? _value.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as ThreadVote?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<ThreadTag>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      shareCount: freezed == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ThreadAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $ThreadAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ThreadCommunityCopyWith<$Res>? get community {
    if (_value.community == null) {
      return null;
    }

    return $ThreadCommunityCopyWith<$Res>(_value.community!, (value) {
      return _then(_value.copyWith(community: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ThreadVoteCopyWith<$Res>? get vote {
    if (_value.vote == null) {
      return null;
    }

    return $ThreadVoteCopyWith<$Res>(_value.vote!, (value) {
      return _then(_value.copyWith(vote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThreadImplCopyWith<$Res> implements $ThreadCopyWith<$Res> {
  factory _$$ThreadImplCopyWith(
          _$ThreadImpl value, $Res Function(_$ThreadImpl) then) =
      __$$ThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $ThreadAuthorCopyWith<$Res>? get author;
  @override
  $ThreadCommunityCopyWith<$Res>? get community;
  @override
  $ThreadVoteCopyWith<$Res>? get vote;
}

/// @nodoc
class __$$ThreadImplCopyWithImpl<$Res>
    extends _$ThreadCopyWithImpl<$Res, _$ThreadImpl>
    implements _$$ThreadImplCopyWith<$Res> {
  __$$ThreadImplCopyWithImpl(
      _$ThreadImpl _value, $Res Function(_$ThreadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = freezed,
    Object? community = freezed,
    Object? vote = freezed,
    Object? tags = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? image = freezed,
    Object? shareCount = freezed,
    Object? commentsCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ThreadImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ThreadAuthor?,
      community: freezed == community
          ? _value.community
          : community // ignore: cast_nullable_to_non_nullable
              as ThreadCommunity?,
      vote: freezed == vote
          ? _value.vote
          : vote // ignore: cast_nullable_to_non_nullable
              as ThreadVote?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<ThreadTag>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      shareCount: freezed == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadImpl implements _Thread {
  _$ThreadImpl(
      {this.id,
      this.author,
      this.community,
      this.vote,
      final List<ThreadTag>? tags,
      this.title,
      this.content,
      this.image,
      @JsonKey(name: 'share_count') this.shareCount,
      @JsonKey(name: 'comments_count') this.commentsCount,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _tags = tags;

  factory _$ThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadImplFromJson(json);

  @override
  final int? id;
  @override
  final ThreadAuthor? author;
  @override
  final ThreadCommunity? community;
  @override
  final ThreadVote? vote;
  final List<ThreadTag>? _tags;
  @override
  List<ThreadTag>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? image;
  @override
  @JsonKey(name: 'share_count')
  final int? shareCount;
  @override
  @JsonKey(name: 'comments_count')
  final int? commentsCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Thread(id: $id, author: $author, community: $community, vote: $vote, tags: $tags, title: $title, content: $content, image: $image, shareCount: $shareCount, commentsCount: $commentsCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.community, community) ||
                other.community == community) &&
            (identical(other.vote, vote) || other.vote == vote) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      author,
      community,
      vote,
      const DeepCollectionEquality().hash(_tags),
      title,
      content,
      image,
      shareCount,
      commentsCount,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadImplCopyWith<_$ThreadImpl> get copyWith =>
      __$$ThreadImplCopyWithImpl<_$ThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadImplToJson(
      this,
    );
  }
}

abstract class _Thread implements Thread {
  factory _Thread(
      {final int? id,
      final ThreadAuthor? author,
      final ThreadCommunity? community,
      final ThreadVote? vote,
      final List<ThreadTag>? tags,
      final String? title,
      final String? content,
      final String? image,
      @JsonKey(name: 'share_count') final int? shareCount,
      @JsonKey(name: 'comments_count') final int? commentsCount,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$ThreadImpl;

  factory _Thread.fromJson(Map<String, dynamic> json) = _$ThreadImpl.fromJson;

  @override
  int? get id;
  @override
  ThreadAuthor? get author;
  @override
  ThreadCommunity? get community;
  @override
  ThreadVote? get vote;
  @override
  List<ThreadTag>? get tags;
  @override
  String? get title;
  @override
  String? get content;
  @override
  String? get image;
  @override
  @JsonKey(name: 'share_count')
  int? get shareCount;
  @override
  @JsonKey(name: 'comments_count')
  int? get commentsCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ThreadImplCopyWith<_$ThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
