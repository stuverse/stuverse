import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/forum/utils/forum_utils.dart';

import '../../services/comment_repo.dart';

part 'comment_state.dart';
part 'comment_cubit.freezed.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentState.initial());

  final _commentRepo = CommentRepo();

  void getComments({
    required int threadId,
  }) async {
    emit(CommentState.loading());
    final result = await _commentRepo.getThreadComment(threadId: threadId);
    result.fold(
      (error) => emit(CommentState.error(message: error)),
      (comments) => emit(CommentState.success(comments: comments)),
    );
  }

  void getCommentSilently({
    required int threadId,
  }) async {
    final result = await _commentRepo.getThreadComment(threadId: threadId);
    result.fold(
      (error) => emit(CommentState.error(message: error)),
      (comments) => emit(CommentState.success(comments: comments)),
    );
  }

  void addComment({
    required int threadId,
    required String content,
    int? parentId,
  }) async {
    await state.mapOrNull(success: (suc) async {
      emit(CommentState.commentAdding());
      final result = await _commentRepo.addThreadComment(
        threadId: threadId,
        content: content,
        parentId: parentId,
      );
      List<ThreadComment> newComments = [];

      result.fold(
        (error) => emit(CommentState.commentAddFailed(message: error)),
        (comment) {
          emit(CommentState.commentAdded(comment: comment));
          ForumUtils.getNewCommentsState(suc.comments, comment.parent, comment);
          if (comment.parent == null) {
            newComments = [comment, ...suc.comments];
          } else {
            newComments = suc.comments;
          }
        },
      );

      emit(CommentState.success(comments: newComments));
    });
  }
}
