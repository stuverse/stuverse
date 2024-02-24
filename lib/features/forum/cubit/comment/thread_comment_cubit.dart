import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/utils/forum_utils.dart';

part 'thread_comment_state.dart';
part 'thread_comment_cubit.freezed.dart';

class ThreadCommentCubit extends Cubit<ThreadCommentState> {
  ThreadCommentCubit() : super(ThreadCommentState.initial());

  final _commentRepo = ThreadCommentRepo();

  void getComments({
    required int threadId,
  }) async {
    emit(ThreadCommentState.loading());
    final result = await _commentRepo.getThreadComment(threadId: threadId);
    result.fold(
      (error) => emit(ThreadCommentState.error(message: error)),
      (comments) => emit(ThreadCommentState.success(comments: comments)),
    );
  }

  void getCommentSilently({
    required int threadId,
  }) async {
    final result = await _commentRepo.getThreadComment(threadId: threadId);
    result.fold(
      (error) => emit(ThreadCommentState.error(message: error)),
      (comments) => emit(ThreadCommentState.success(comments: comments)),
    );
  }

  void addComment({
    required int threadId,
    required String content,
    int? parentId,
  }) async {
    await state.mapOrNull(success: (suc) async {
      emit(ThreadCommentState.commentAdding());
      final result = await _commentRepo.addThreadComment(
        threadId: threadId,
        content: content,
        parentId: parentId,
      );
      List<ThreadComment> newComments = [];

      result.fold(
        (error) => emit(ThreadCommentState.commentAddFailed(message: error)),
        (comment) {
          emit(ThreadCommentState.commentAdded(comment: comment));
          ForumUtils.getNewCommentsState(suc.comments, comment.parent, comment);
          if (comment.parent == null) {
            newComments = [comment, ...suc.comments];
          } else {
            newComments = suc.comments;
          }
        },
      );

      emit(ThreadCommentState.success(comments: newComments));
    });
  }
}
