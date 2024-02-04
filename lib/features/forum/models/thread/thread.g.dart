// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThreadImpl _$$ThreadImplFromJson(Map<String, dynamic> json) => _$ThreadImpl(
      id: json['id'] as int?,
      author: json['author'] == null
          ? null
          : ThreadAuthor.fromJson(json['author'] as Map<String, dynamic>),
      community: json['community'] == null
          ? null
          : ThreadCommunity.fromJson(json['community'] as Map<String, dynamic>),
      vote: json['vote'] == null
          ? null
          : ThreadVote.fromJson(json['vote'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => ThreadTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      shareCount: json['share_count'] as int?,
      commentsCount: json['comments_count'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ThreadImplToJson(_$ThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'community': instance.community,
      'vote': instance.vote,
      'tags': instance.tags,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'share_count': instance.shareCount,
      'comments_count': instance.commentsCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
