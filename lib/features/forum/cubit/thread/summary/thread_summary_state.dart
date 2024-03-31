part of 'thread_summary_cubit.dart';

@immutable
sealed class ThreadSummaryState {}

final class ThreadSummaryInitial extends ThreadSummaryState {}

final class ThreadSummaryLoading extends ThreadSummaryState {}

final class ThreadSummarySuccess extends ThreadSummaryState {
  final String summary;

  ThreadSummarySuccess(this.summary);
}

final class ThreadSummaryError extends ThreadSummaryState {
  final String message;

  ThreadSummaryError(this.message);
}
