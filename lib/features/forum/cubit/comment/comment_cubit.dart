import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stuverse/features/forum/forum.dart';

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
}
