import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'thread_summary_state.dart';

class ThreadSummaryCubit extends Cubit<ThreadSummaryState> {
  ThreadSummaryCubit() : super(ThreadSummaryInitial());
  final _threadRepo = ThreadRepo();

  void summarizeThread({
    required int threadId,
  }) async {
    emit(ThreadSummaryLoading());

    final resp = await _threadRepo.threadSummarize(threadId);
    resp.fold(
      (failure) {
        emit(ThreadSummaryError(failure));
      },
      (success) {
        emit(ThreadSummarySuccess(success));
      },
    );
  }
}
