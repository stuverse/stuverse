import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'community_detail_state.dart';

class CommunityDetailCubit extends Cubit<CommunityDetailState> {
  CommunityDetailCubit() : super(CommunityDetailInitial());

  final _threadRepo = ThreadRepo();
  void getCommunityThreads(
      {required int communityId, String? search, int? tagId}) async {
    emit(CommunityDetailLoading());
    final result = await _threadRepo.getThreads(
      communityId: communityId,
      search: search,
      tagId: tagId,
    );
    result.fold(
      (failure) {
        emit(CommunityDetailError(message: failure));
      },
      (threads) {
        emit(CommunityDetailLoaded(threads: threads));
      },
    );
  }
}
