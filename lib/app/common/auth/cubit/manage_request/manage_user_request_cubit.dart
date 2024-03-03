import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'manage_user_request_state.dart';

class ManageUserRequestCubit extends Cubit<ManageUserRequestState> {
  ManageUserRequestCubit() : super(ManageUserRequestInitial());

  void acceptRequest({required int userId}) async {
    emit(ManageUserRequestLoading());
    try {
      await dioClient.post('/user/requests/accept/', data: {
        'id': userId,
      });
      emit(ManageUserRequestSuccess());
    } catch (e) {
      print(e);
      emit(ManageUserRequestFailure());
    }
  }
}
