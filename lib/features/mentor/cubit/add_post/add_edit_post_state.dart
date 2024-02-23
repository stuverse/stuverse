sealed class AddEditPostState {}

final class AddEditPostInitial extends AddEditPostState {}

final class AddEditPostLoading extends AddEditPostState {}

final class AddEditPostLoaded extends AddEditPostState {}

final class AddEditPostFailure extends AddEditPostState {
  final String message;
  AddEditPostFailure(this.message);
}
