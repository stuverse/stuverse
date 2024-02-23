part of 'mentor_home_cubit.dart';

sealed class MentorHomeState {}

final class MentorHomeInitial extends MentorHomeState {}

final class MentorHomeLoading extends MentorHomeState {}

final class MentorHomeLoaded extends MentorHomeState {
  final List<MentorPost> posts;
  MentorHomeLoaded(this.posts);
}

final class MentorHomeFailure extends MentorHomeState {
  final String message;
  MentorHomeFailure(this.message);
}
