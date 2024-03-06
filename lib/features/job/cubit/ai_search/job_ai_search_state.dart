part of 'job_ai_search_cubit.dart';

@immutable
sealed class JobAiSearchState {}

final class JobAiSearchInitial extends JobAiSearchState {}

final class JobAiSearchLoading extends JobAiSearchState {}

final class JobAiSearchSuccess extends JobAiSearchState {
  final JobAiBest result;

  JobAiSearchSuccess({required this.result});
}

final class JobAiSearchError extends JobAiSearchState {
  final String message;

  JobAiSearchError({required this.message});
}
