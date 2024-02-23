import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/add_post/add_post_state.dart';

import '../../../../app/app.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  void addPost({
    required String postName,
    required String description,
    required double fee,
    required bool isFree,
    required int mentorId,
  }) async {
    emit(AddPostLoading());
    try {
      final resp = await dioClient.post('/mentor/posts/', data: {
        "name": postName,
        "isFree": isFree,
        "description": description,
        "price": fee,
        "mentor": mentorId
      });
      emit(AddPostLoaded());
    } catch (e) {
      print(e);
      emit(AddPostFailure(e.toString()));
    }
  }
}
