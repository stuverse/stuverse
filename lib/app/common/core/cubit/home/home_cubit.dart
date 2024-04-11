import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:stuverse/features/forum/forum.dart';

import '../../services/home_repo.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  final homeRepo = HomeRepo();

  void getHomeData() async {
    emit(HomeState.loading());
    final result = await homeRepo.getHomeData();
    result.fold(
      (failure) {
        emit(HomeState.failure(message: failure));
      },
      (threads) {
        emit(HomeState.loaded(threads: threads));
      },
    );
  }

  void updateThread({
    required Thread thread,
  }) {
    state.mapOrNull(
      loaded: (state) {
        final threads = state.threads;
        final index = threads.indexWhere((element) => element.id == thread.id);
        if (index == -1) return;
        threads[index] = thread;
        emit(HomeState.loaded(threads: threads));
      },
    );
  }
}
