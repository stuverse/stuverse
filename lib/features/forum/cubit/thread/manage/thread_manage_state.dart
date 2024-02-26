part of 'thread_manage_cubit.dart';

@immutable
sealed class ThreadManageState {}

final class ThreadManageInitial extends ThreadManageState {}

final class ThreadCreateLoading extends ThreadManageState {}

final class ThreadCreateSuccess extends ThreadManageState {}

final class ThreadCreateError extends ThreadManageState {
  final String message;

  ThreadCreateError({
    required this.message,
  });
}

final class ThreadDeleteLoading extends ThreadManageState {}

final class ThreadDeleteSuccess extends ThreadManageState {}

final class ThreadDeleteError extends ThreadManageState {
  final String message;

  ThreadDeleteError({
    required this.message,
  });
}

final class ThreadUpdateLoading extends ThreadManageState {}

final class ThreadUpdateSuccess extends ThreadManageState {}

final class ThreadUpdateError extends ThreadManageState {
  final String message;

  ThreadUpdateError({
    required this.message,
  });
}
