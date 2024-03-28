part of 'add_edit_fund_project_cubit.dart';

@immutable
sealed class AddEditFundProjectState {}

final class AddEditFundProjectInitial extends AddEditFundProjectState {}

final class AddEditFundProjectLoading extends AddEditFundProjectState {}

final class AddEditFundProjectSuccess extends AddEditFundProjectState {
  final String message;

  AddEditFundProjectSuccess({required this.message});
}

final class AddEditFundProjectError extends AddEditFundProjectState {
  final String errorMessage;
  AddEditFundProjectError({required this.errorMessage});
}
