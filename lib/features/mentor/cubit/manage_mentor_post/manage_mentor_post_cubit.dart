import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_state.dart';

import '../../../../app/app.dart';

class ManageMentorPostCubit extends Cubit<ManageMentorPostState> {
  ManageMentorPostCubit() : super(ManageMentorPostInitial());
  void addPost({
    required String postName,
    required String description,
    required double fee,
    required bool isFree,
    required int mentorId,
  }) async {
    emit(ManageMentorPostLoading());
    try {
      final resp = await dioClient.post('/mentor/posts/', data: {
        "name": postName,
        "isFree": isFree,
        "description": description,
        "price": fee,
        "mentor": mentorId,
      });
      emit(ManageMentorPostLoaded(
        'Posted successfully',
      ));
    } catch (e) {
      print(e);
      emit(ManageMentorPostFailure('Something went wrong'));
    }
  }

  void editPost({
    required String postName,
    required String description,
    required double fee,
    required bool isFree,
    required int mentorId,
    required int id,
  }) async {
    emit(ManageMentorPostLoading());
    try {
      final resp = await dioClient.put('/mentor/posts/$id/', data: {
        "name": postName,
        "isFree": isFree,
        "description": description,
        "price": fee,
        "mentor": mentorId,
      });
      emit(ManageMentorPostLoaded('Edited successfully'));
    } catch (e) {
      print(e);
      emit(ManageMentorPostFailure('Something went wrong'));
    }
  }

  void deletePost({required int id}) async {
    emit(ManageMentorPostLoading());
    try {
      final resp = await dioClient.delete('/mentor/posts/$id/');
      emit(ManageMentorPostLoaded('Deleted successfully'));
    } catch (e) {
      print(e);
      emit(ManageMentorPostFailure('Something went wrong'));
    }
  }
}
