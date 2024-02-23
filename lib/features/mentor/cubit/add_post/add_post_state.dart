

sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}
final class AddPostLoading extends AddPostState {}
final class AddPostLoaded extends AddPostState {}
final class AddPostFailure extends AddPostState {
  final String message;
  AddPostFailure(this.message);
}