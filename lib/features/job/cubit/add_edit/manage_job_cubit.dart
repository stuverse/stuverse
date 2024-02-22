import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_post.dart';

part 'manage_job_state.dart';

class ManageJobCubit extends Cubit<ManageJobState> {
  ManageJobCubit() : super(ManageJobInitial());

  void addJob(
      {required String title,
      required String description,
      required String place,
      required String jobType,
      required String url,
      XFile? image,
      required String companyName}) async {
    emit(ManageJobLoading());
    try {
      final formData = FormData.fromMap({
        "title": title,
        "description": description,
        "place": place,
        "companyName": companyName,
        "jobType": jobType,
        "url": url,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });

      final response = await dioClient.post("/job/posts/", data: formData);

      print(response.data);

      emit(ManageJobSuccess(
        message: "Successfully added job post",
        action: JobPostAction.add,
      ));
    } on DioException catch (e) {
      print(e);
      print(e.response?.data?.toString());
      emit(ManageJobError(e.toString()));
    } catch (e) {
      print(e);
      emit(ManageJobError(e.toString()));
    }
  }

  void editJob(
      {required String title,
      required String description,
      required String place,
      required int id,
      required String jobType,
      required String url,
      XFile? image,
      required String companyName}) async {
    emit(ManageJobLoading());
    try {
      final formData = FormData.fromMap({
        "title": title,
        "description": description,
        "place": place,
        "companyName": companyName,
        "jobType": jobType,
        "url": url,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });
      print("before");
      final response =
          await dioClient.patch("/job/posts/${id}/", data: formData);
      print(response.data);
      emit(ManageJobSuccess(
        message: "Successfully edited job post",
        action: JobPostAction.edit,
      ));
    } on DioException catch (e) {
      print(e);
      print(e.response?.data?.toString());

      emit(ManageJobError(
        e.toString(),
      ));
    } catch (e) {
      print(e);
      emit(ManageJobError(e.toString()));
    }
  }

  void deleteJob({required int id}) async {
    emit(ManageJobLoading());
    try {
      await dioClient.delete(
        "/job/posts/$id/",
      );
      emit(ManageJobSuccess(
        message: "Successfully deleted job post",
        action: JobPostAction.delete,
      ));
    } catch (e) {
      print(e);
      emit(ManageJobError(
        "Failed to delete job post",
      ));
    }
  }
}
