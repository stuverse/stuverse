import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/add_post/add_edit_post_state.dart';

import '../../../../app/app.dart';



class AddEditPostCubit extends Cubit<AddEditPostState> {
  AddEditPostCubit() : super(AddEditPostInitial());
  void addPost({
    required String postName,
    required String description,
    required double fee,
    required bool isFree,
    required int mentorId,
  }) async {
    emit(AddEditPostLoading());
    try {
      final resp = await dioClient.post('/mentor/posts/', data: {
        "name": postName,
        "isFree": isFree,
        "description": description,
        "price": fee,
        "mentor": mentorId,
      });
      emit(AddEditPostLoaded());
    } catch (e) {
      print(e);
      emit(AddEditPostFailure(e.toString()));
    }
  }
  void editPost({
    required String postName,
    required String description,
    required double fee,
    required bool isFree,
    required int mentorId,
    required int userId,
  })async{
  emit(AddEditPostLoading());
  try {
    final resp = await dioClient.put('/mentor/posts/$userId/', data: {
      "name": postName,
      "isFree": isFree,
      "description": description,
      "price": fee,
      "mentor": mentorId,

    });
    emit(AddEditPostLoaded());
  } catch (e) {
    print(e);
    emit(AddEditPostFailure(e.toString()));
  }
  }
}
