import 'author.dart';

class ThreadComment {
  int? id;
  CommentAuthor? author;
  int? thread;
  int? parent;
  String? content;
  DateTime? createdAt;
  List<ThreadComment>? children;
  int? replyCount;
  bool? isReported;
  bool? isUserBlocked;

  ThreadComment({
    this.id,
    this.author,
    this.thread,
    this.parent,
    this.content,
    this.createdAt,
    this.children,
    this.replyCount,
    this.isReported,
    this.isUserBlocked,
  });

  @override
  String toString() {
    return 'ThreadComment(id: $id, author: $author, thread: $thread, parent: $parent, content: $content, createdAt: $createdAt, children: $children), replyCount: $replyCount';
  }

  factory ThreadComment.fromJson(Map<String, dynamic> json) => ThreadComment(
      id: json['id'] as int?,
      author: json['author'] == null
          ? null
          : CommentAuthor.fromJson(json['author'] as Map<String, dynamic>),
      thread: json['thread'] as int?,
      parent: json['parent'] as int?,
      content: json['content'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      children: [
        if (json['children'] != null)
          for (var item in json['children']) ThreadComment.fromJson(item)
      ],
      replyCount: json['reply_count'] as int?,
      isReported: json['is_reported'] as bool?,
      isUserBlocked: json['is_user_blocked'] as bool?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author?.toJson(),
        'thread': thread,
        'parent': parent,
        'content': content,
        'created_at': createdAt?.toIso8601String(),
        'children': children,
        'reply_count': replyCount,
        'is_reported': isReported,
        'is_user_blocked': isUserBlocked
      };
}
