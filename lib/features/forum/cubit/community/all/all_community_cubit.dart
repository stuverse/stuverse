import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'all_community_state.dart';

class AllCommunityCubit extends Cubit<AllCommunityState> {
  AllCommunityCubit() : super(AllCommunityInitial());
  final _communityRepo = CommunityRepo();
  void getCommunities({String? query, int? userId}) async {
    emit(AllCommunityLoading());

    final response = await _communityRepo.getAllCommunities(
      search: query,
      userId: userId,
    );
    response.fold(
      (l) => emit(AllCommunityError(l)),
      (r) => emit(AllCommunityLoaded(r)),
    );
  }
}
