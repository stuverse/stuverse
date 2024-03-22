part of 'all_community_cubit.dart';

@immutable
sealed class AllCommunityState {}

final class AllCommunityInitial extends AllCommunityState {}

final class AllCommunityLoading extends AllCommunityState {}

final class AllCommunityLoaded extends AllCommunityState {
  final List<Community> communities;

  AllCommunityLoaded(this.communities);
}

final class AllCommunityError extends AllCommunityState {
  final String message;

  AllCommunityError(this.message);
}
