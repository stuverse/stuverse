part of 'community_detail_cubit.dart';

@immutable
sealed class CommunityDetailState {}

final class CommunityDetailInitial extends CommunityDetailState {}

final class CommunityDetailLoading extends CommunityDetailState {}

final class CommunityDetailLoaded extends CommunityDetailState {
  final List<Thread> threads;

  CommunityDetailLoaded({
    required this.threads,
  });
}

final class CommunityDetailError extends CommunityDetailState {
  final String message;

  CommunityDetailError({
    required this.message,
  });
}
