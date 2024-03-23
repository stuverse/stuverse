import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'thread_detail_state.dart';

class ThreadDetailCubit extends Cubit<ThreadDetailState> {
  ThreadDetailCubit() : super(ThreadDetailInitial());

  final _threadRepo = ThreadRepo();

  void getThread({required int threadId}) async {
    emit(
      ThreadDetailLoading(),
    );
    final result = await _threadRepo.getThread(threadId);
    result.fold(
      (failure) {
        emit(
          ThreadDetailError(message: failure),
        );
      },
      (thread) {
        emit(
          ThreadDetailSuccess(thread: thread),
        );
      },
    );
  }
}
