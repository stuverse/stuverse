part of 'mentor_search_cubit.dart';

sealed class MentorSearchState {}

final class MentorSearchInitial extends MentorSearchState {}

final class MentorSearchLoading extends MentorSearchState {}

final class MentorSearchLoaded extends MentorSearchState {
  final List<MentorPost> posts;
  MentorSearchLoaded(this.posts);
}

final class MentorSearchFailure extends MentorSearchState {
  final String message;
  MentorSearchFailure(this.message);
}
