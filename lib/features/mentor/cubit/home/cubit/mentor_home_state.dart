part of 'mentor_home_cubit.dart';

@immutable
sealed class MentorHomeState {}

final class MentorHomeInitial extends MentorHomeState {}

final class MentorHomeLoading extends MentorHomeState {}

final class MentorHomeLoaded extends MentorHomeState {
  final List<MentorPost> latestPosts;
  MentorHomeLoaded(this.latestPosts);
}

final class MentorHomeFailure extends MentorHomeState {
  final String message;
  MentorHomeFailure(this.message);
}
