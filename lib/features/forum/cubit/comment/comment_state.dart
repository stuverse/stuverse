part of 'comment_cubit.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState.initial() = _Initial;
  const factory CommentState.loading() = _Loading;
  const factory CommentState.success({
    required List<ThreadComment> comments,
  }) = _Success;

  const factory CommentState.error({
    required String message,
  }) = _Error;
}
