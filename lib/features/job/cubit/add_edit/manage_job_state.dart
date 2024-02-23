part of 'manage_job_cubit.dart';

enum JobPostAction { add, edit, delete }

@immutable
sealed class ManageJobState {}

final class ManageJobInitial extends ManageJobState {}

final class ManageJobLoading extends ManageJobState {}

final class ManageJobSuccess extends ManageJobState {
  final String message;
  final JobPostAction action;
  ManageJobSuccess({
    required this.message,
    required this.action,
  });
}

final class ManageJobError extends ManageJobState {
  final String message;
  ManageJobError(this.message);
}
