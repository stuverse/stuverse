part of 'community_admin_cubit.dart';

@immutable
sealed class CommunityAdminState {}

final class CommunityAdminInitial extends CommunityAdminState {}

final class CommunityAdminLoading extends CommunityAdminState {}

final class CommunityAdminLoaded extends CommunityAdminState {
  final List<Community> communities;

  CommunityAdminLoaded({
    required this.communities,
  });
}

final class CommunityAdminError extends CommunityAdminState {
  final String message;

  CommunityAdminError({
    required this.message,
  });
}
