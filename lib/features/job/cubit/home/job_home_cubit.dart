import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_post.dart';

part 'job_home_state.dart';

class JobHomeCubit extends Cubit<JobHomeState> {
  JobHomeCubit() : super(JobHomeInitial());
  void getJobHomeData() async {
    emit(JobHomeLoading());
    try {
      final response = await dioClient.get(
        "/job/home/",
      );
      final List<JobPost> latestJobs = [
        for (final post in response.data['latest_jobs']) JobPost.fromJson(post),
      ];
      final List<JobPost> bestInternships = [
        for (final post in response.data['best_internships'])
          JobPost.fromJson(post),
      ];

      emit(JobHomeSuccess(
          latestJobs: latestJobs, bestInternships: bestInternships));
    } catch (e) {
      print(e);
      emit(JobHomeError(e.toString()));
    }
  }
  // void deletePost({required int id}) async {
  //   emit(DeletePostLoading());
  //   try {
  //     await dioClient.delete(
  //       "/job/posts/$id/",
  //     );
  //     emit(DeletePostSuccess());
  //   } on DioException catch (e) {
  //     emit(DeletePostError(e.toString()));
  //   } catch (e) {
  //     emit(DeletePostError(e.toString()));
  //   }
  // }
}
