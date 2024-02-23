sealed class ManageMentorPostState {}

final class ManageMentorPostInitial extends ManageMentorPostState {}

final class ManageMentorPostLoading extends ManageMentorPostState {}

final class ManageMentorPostLoaded extends ManageMentorPostState {
  final String message;
  ManageMentorPostLoaded(this.message);
}

final class ManageMentorPostFailure extends ManageMentorPostState {
  final String message;
  ManageMentorPostFailure(this.message);
}
