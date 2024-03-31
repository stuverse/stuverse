part of 'mentorship_request_cubit.dart';

@immutable
sealed class MentorshipRequestState {}

final class MentorshipRequestInitial extends MentorshipRequestState {}
final class MentorshipRequestLoading extends MentorshipRequestState {}
final class MentorshipRequestLoaded extends MentorshipRequestState {
final List<MentorRequest> requests;
  MentorshipRequestLoaded(this.requests);
}
final class MentorshipRequestFailure extends MentorshipRequestState {
  final String message;
  MentorshipRequestFailure(this.message);
}
