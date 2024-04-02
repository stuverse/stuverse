part of 'job_material_cubit.dart';

@immutable
sealed class JobMaterialState {}

final class JobMaterialInitial extends JobMaterialState {}

final class JobMaterialLoading extends JobMaterialState {}

final class JobMaterialSuccess extends JobMaterialState {
  final List<JobMaterial> materialsList;
  JobMaterialSuccess(this.materialsList);
}

final class JobMaterialError extends JobMaterialState {
  final String message;
  JobMaterialError(this.message);
}
