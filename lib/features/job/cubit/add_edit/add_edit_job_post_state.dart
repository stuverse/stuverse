part of 'add_edit_job_post_cubit.dart';

@immutable
sealed class AddEditJobPostState {}

final class AddEditJobPostInitial extends AddEditJobPostState {}

final class AddEditJobPostLoading extends AddEditJobPostState {}

final class AddEditJobPostSuccess extends AddEditJobPostState {}

final class AddEditJobPostError extends AddEditJobPostState {
  final String error;
  AddEditJobPostError(this.error);
}
