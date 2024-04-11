import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'thread_manage_state.dart';

class ThreadManageCubit extends Cubit<ThreadManageState> {
  ThreadManageCubit() : super(ThreadManageInitial());
  final _threadRepo = ThreadRepo();

  void editThread({
    required int threadId,
    required String title,
    String? content,
    XFile? image,
  }) async {
    emit(ThreadUpdateLoading());
    final result = await _threadRepo.editThread(
      threadId: threadId,
      title: title,
      content: content,
      image: image,
    );
    result.fold(
      (failure) {
        emit(ThreadUpdateError(message: failure));
      },
      (success) {
        emit(ThreadUpdateSuccess());
      },
    );
  }

  void addThread({
    required String title,
    String? content,
    required int communityId,
    XFile? image,
  }) async {
    emit(ThreadCreateLoading());
    final result = await _threadRepo.createThread(
      title: title,
      content: content,
      communityId: communityId,
      image: image,
    );
    result.fold(
      (error) => emit(ThreadCreateError(message: error)),
      (success) => emit(ThreadCreateSuccess()),
    );
  }

  // @override
  // Future<void> close() {
  //   log("ThreadManageCubit closed");
  //   return super.close();
  // }
}
