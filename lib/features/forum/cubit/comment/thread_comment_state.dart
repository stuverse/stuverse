part of 'thread_comment_cubit.dart';

@freezed
class ThreadCommentState with _$ThreadCommentState {
  const factory ThreadCommentState.initial() = _Initial;
  const factory ThreadCommentState.loading() = _Loading;
  const factory ThreadCommentState.success({
    required List<ThreadComment> comments,
  }) = _Success;

  const factory ThreadCommentState.error({
    required String message,
  }) = _Error;

  const factory ThreadCommentState.commentAdding() = _CommentAdding;
  const factory ThreadCommentState.commentAdded({
    required ThreadComment comment,
  }) = _CommentAdded;

  const factory ThreadCommentState.commentAddFailed({
    required String message,
  }) = _CommentAddFailed;
}
