import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_post.dart';

part 'job_home_state.dart';

class JobHomeCubit extends Cubit<JobHomeState> {
  JobHomeCubit() : super(JobHomeInitial());
  void getJobHomeData({String? search}) async {
    emit(JobHomeLoading());
    try {
      final response = await dioClient.get("/job/posts",
          queryParameters: {if (search != null) "search": search});
      final List<JobPost> postList = [];
      for (final post in response.data) {
        postList.add(JobPost.fromJson(post));
      }
      emit(JobHomeSuccess(postList.reversed.toList()));
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
