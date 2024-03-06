import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'manage_profile_state.dart';

class ManageProfileCubit extends Cubit<ManageProfileState> {
  ManageProfileCubit() : super(ManageProfileInitial());
  void editProfile({
    required String name,
    required String mobile,
    required String about,
    required String id,
    required String linkedin,
    required String github,
    required int experience_years,
    required List<int> skillsIDList,
    File? resumeFile,
    File? imageFile,
  }) async {
    emit(ManageProfileLoading());
    try {
      final formData = FormData.fromMap({
        "name": name,
        "mobile": mobile,
        "about": about,
        "experience_years": experience_years,
        "linkedin": linkedin,
        "github": github,
        "skills": skillsIDList,
        if (resumeFile != null)
          "resume": await MultipartFile.fromFile(
            resumeFile.path,
            filename: resumeFile.path.split("/").last,
          ),
        if (imageFile != null)
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split("/").last,
          )
      });
      final response = await dioClient.patch(
        "/user/profile/",
        data: formData,
      );
      emit(ManageProfileSuccess(
        user: User.fromJson(response.data),
      ));
    } catch (e) {
      print(e);
      emit(ManageProfileError(
        message: e.toString(),
      ));
    }
  }
}
