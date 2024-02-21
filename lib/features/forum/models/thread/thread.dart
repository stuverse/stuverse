import 'author.dart';
import 'community.dart';
import 'tag.dart';
import 'vote.dart';

class Thread {
  int? id;
  ThreadAuthor? author;
  ThreadCommunity? community;
  List<ThreadTag>? tags;
  ThreadVote? vote;
  int? commentsCount;
  String? title;
  String? content;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? shareCount;

  Thread({
    this.id,
    this.author,
    this.community,
    this.tags,
    this.vote,
    this.commentsCount,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.shareCount,
  });

  @override
  String toString() {
    return 'Thread(id: $id, author: $author, community: $community, tags: $tags, vote: $vote, commentsCount: $commentsCount, title: $title, content: $content, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, shareCount: $shareCount)';
  }

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        id: json['id'] as int?,
        author: json['author'] == null
            ? null
            : ThreadAuthor.fromJson(json['author'] as Map<String, dynamic>),
        community: json['community'] == null
            ? null
            : ThreadCommunity.fromJson(
                json['community'] as Map<String, dynamic>),
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => ThreadTag.fromJson(e as Map<String, dynamic>))
            .toList(),
        vote: json['vote'] == null
            ? null
            : ThreadVote.fromJson(json['vote'] as Map<String, dynamic>),
        commentsCount: json['comments_count'] as int?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        image: json['image'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        shareCount: json['share_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author?.toJson(),
        'community': community?.toJson(),
        'tags': tags?.map((e) => e.toJson()).toList(),
        'vote': vote?.toJson(),
        'comments_count': commentsCount,
        'title': title,
        'content': content,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'share_count': shareCount,
      };
}
