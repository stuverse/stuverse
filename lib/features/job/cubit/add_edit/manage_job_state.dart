part of 'manage_job_cubit.dart';

@immutable
sealed class ManageJobState {}

final class ManageJobInitial extends ManageJobState {}

final class ManageJobLoading extends ManageJobState {}

final class ManageJobSuccess extends ManageJobState {
  final String message;

  ManageJobSuccess({
    required this.message,
  });
}

final class ManageJobError extends ManageJobState {
  final String message;
  ManageJobError(this.message);
}
