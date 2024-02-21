part of 'job_home_cubit.dart';

@immutable
sealed class JobHomeState {}

final class JobHomeInitial extends JobHomeState {}

final class JobHomeLoading extends JobHomeState {}

final class JobHomeSuccess extends JobHomeState {
  final List<JobPost> postList;
  JobHomeSuccess(this.postList);
}

final class JobHomeError extends JobHomeState {
  final String message;
  JobHomeError(this.message);
}
