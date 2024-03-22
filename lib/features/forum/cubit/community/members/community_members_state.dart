part of 'community_members_cubit.dart';

@immutable
sealed class CommunityMembersState {}

final class CommunityMembersInitial extends CommunityMembersState {}

final class CommunityMembersLoading extends CommunityMembersState {}

final class CommunityMembersError extends CommunityMembersState {
  final String message;

  CommunityMembersError({required this.message});
}

final class CommunityMembersLoaded extends CommunityMembersState {
  final List<MiniUser> members;

  CommunityMembersLoaded({required this.members});
}



final class CommunityMemberAddError extends CommunityMembersState {
  final String message;

  CommunityMemberAddError({required this.message});
}

final class CommunityMemberAdded extends CommunityMembersState {
}



final class CommunityMemberRemoveError extends CommunityMembersState {
  final String message;

  CommunityMemberRemoveError({required this.message});
}

final class CommunityMemberRemoved extends CommunityMembersState {
}
