import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'community_admin_state.dart';

class CommunityAdminCubit extends Cubit<CommunityAdminState> {
  CommunityAdminCubit() : super(CommunityAdminInitial());

  final _communityRepo = CommunityRepo();

  void getAllCommunities({
    String? search,
    bool? isPrivate,
  }) async {
    emit(CommunityAdminLoading());
    final result = await _communityRepo.getAllCommunities(
      search: search,
      isPrivate: isPrivate,
    );
    result.fold(
      (error) => emit(CommunityAdminError(message: error)),
      (communities) => emit(CommunityAdminLoaded(communities: communities)),
    );
  }
}
