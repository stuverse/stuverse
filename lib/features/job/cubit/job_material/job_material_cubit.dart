import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';
import 'package:stuverse/features/job/models/job_material.dart';

part 'job_material_state.dart';

class JobMaterialCubit extends Cubit<JobMaterialState> {
  JobMaterialCubit() : super(JobMaterialInitial());

  void getJobMaterial() async {
    emit(JobMaterialLoading());
    try {
      final response = await dioClient.get(
        "/job/material/",
      );
      final List<JobMaterial> jobMaterials = [];
      for (final material in response.data) {
        jobMaterials.add(JobMaterial.fromJson(material));
      }
      emit(JobMaterialSuccess(jobMaterials));
    } catch (e) {
      print(e);
      emit(JobMaterialError(e.toString()));
    }
  }
}
