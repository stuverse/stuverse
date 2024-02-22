part of 'job_search_cubit.dart';

@immutable
sealed class JobSearchState {}

final class JobSearchInitial extends JobSearchState {}

final class JobSearchLoading extends JobSearchState {}

final class JobSearchSuccess extends JobSearchState {
  final List<JobPost> postList;
  JobSearchSuccess(this.postList);
}

final class JobSearchError extends JobSearchState {
  final String error;
  JobSearchError(this.error);
}
