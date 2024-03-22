part of 'thread_detail_cubit.dart';

@immutable
sealed class ThreadDetailState {}

final class ThreadDetailInitial extends ThreadDetailState {}

final class ThreadDetailLoading extends ThreadDetailState {}

final class ThreadDetailSuccess extends ThreadDetailState {
  final Thread thread;

  ThreadDetailSuccess({required this.thread});
}

final class ThreadDetailError extends ThreadDetailState {
  final String message;

  ThreadDetailError({required this.message});
}
