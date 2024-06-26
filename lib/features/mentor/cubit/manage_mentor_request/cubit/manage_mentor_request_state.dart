part of 'manage_mentor_request_cubit.dart';

@immutable
sealed class ManageMentorRequestState {}

final class ManageMentorRequestInitial extends ManageMentorRequestState {}

final class ManageMentorRequestLoading extends ManageMentorRequestState {}

final class ManageMentorRequestLoaded extends ManageMentorRequestState {
  final String message;
  ManageMentorRequestLoaded(this.message);
}

final class ManageMentorRequestFailure extends ManageMentorRequestState {
  final String message;
  ManageMentorRequestFailure(this.message);
}
