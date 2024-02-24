part of 'community_manage_cubit.dart';

@immutable
sealed class CommunityManageState {}

final class CommunityManageInitial extends CommunityManageState {}

final class CommunityJoinLoading extends CommunityManageState {}

final class CommunityJoinSuccess extends CommunityManageState {}

final class CommunityJoinError extends CommunityManageState {
  final String message;

  CommunityJoinError({
    required this.message,
  });
}

final class CommunityLeaveLoading extends CommunityManageState {}

final class CommunityLeaveSuccess extends CommunityManageState {}

final class CommunityLeaveError extends CommunityManageState {
  final String message;

  CommunityLeaveError({
    required this.message,
  });
}

final class CommunityCreateLoading extends CommunityManageState {}

final class CommunityCreateSuccess extends CommunityManageState {}

final class CommunityCreateError extends CommunityManageState {
  final String message;

  CommunityCreateError({
    required this.message,
  });
}

final class CommunityDeleteLoading extends CommunityManageState {}

final class CommunityDeleteSuccess extends CommunityManageState {}

final class CommunityDeleteError extends CommunityManageState {
  final String message;

  CommunityDeleteError({
    required this.message,
  });
}

final class CommunityUpdateLoading extends CommunityManageState {}

final class CommunityUpdateSuccess extends CommunityManageState {}

final class CommunityUpdateError extends CommunityManageState {
  final String message;

  CommunityUpdateError({
    required this.message,
  });
}
