part of 'forum_home_cubit.dart';

@immutable
sealed class ForumHomeState {}

final class ForumHomeInitial extends ForumHomeState {}

final class ForumHomeLoading extends ForumHomeState {}

final class ForumHomeLoaded extends ForumHomeState {
  final List<Community> popularCommunities;
  final List<Community> yourCommunities;
  final List<Thread> threads;

  ForumHomeLoaded({
    required this.popularCommunities,
    required this.yourCommunities,
    required this.threads,
  });
}

final class ForumHomeError extends ForumHomeState {
  final String message;

  ForumHomeError({
    required this.message,
  });
}
