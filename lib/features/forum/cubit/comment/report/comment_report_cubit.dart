import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/services/thread_comment_repo.dart';

part 'comment_report_state.dart';

class CommentReportCubit extends Cubit<CommentReportState> {
  CommentReportCubit() : super(CommentReportInitial());

  final _commentRepo = ThreadCommentRepo();
  void reportComment({required int commentId, required String reason}) async {
    emit(CommentReportLoading());

    final resp =
        await _commentRepo.reportComment(commentId: commentId, reason: reason);
    resp.fold((l) => emit(CommentReportError(message: l)),
        (r) => emit(CommentReportSuccess()));
  }
}
