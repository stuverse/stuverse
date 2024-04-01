import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../../../../../app/models/mini_user.dart';

part 'community_members_state.dart';

class CommunityMembersCubit extends Cubit<CommunityMembersState> {
  CommunityMembersCubit() : super(CommunityMembersInitial());

  final _communityRepo = CommunityRepo();
  void getCommunityMembers(int communityId) async {
    emit(CommunityMembersLoading());
    final result = await _communityRepo.getCommunityMembers(communityId);
    result.fold(
      (failure) {
        emit(CommunityMembersError(message: failure));
      },
      (members) {
        emit(CommunityMembersLoaded(members: members));
      },
    );
  }

  void removeMember({
    required int memberId,
    required int communityId,
  }) async {
    emit(CommunityMembersLoading());
    final result = await _communityRepo.removeMemberFromCommunity(
      communityId: communityId,
      userId: memberId.toString(),
    );
    result.fold(
      (failure) {
        emit(CommunityMemberRemoveError(message: failure));
        getCommunityMembers(communityId);
      },
      (success) {
        emit(CommunityMemberRemoved());
        getCommunityMembers(communityId);
      },
    );
  }

  void addMembers({
    required List<MiniUser> users,
    required int communityId,
  }) async {
    emit(CommunityMembersLoading());
    final result = await _communityRepo.addMembersToCommunity(
      communityId: communityId,
      users: users.map((e) => e.id!).toList(),
    );
    result.fold(
      (failure) {
        emit(CommunityMemberAddError(message: failure));
        getCommunityMembers(communityId);
      },
      (success) {
        emit(CommunityMemberAdded());
        getCommunityMembers(communityId);
      },
    );
  }
}
