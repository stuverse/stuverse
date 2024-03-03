import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'user_request_state.dart';

class UserRequestCubit extends Cubit<UserRequestState> {
  UserRequestCubit() : super(UserRequestInitial());

  void getAllUserRequest({String? search}) async {
    emit(UserRequestLoading());
    try {
      final resp = await dioClient.get(
        '/user/requests/',
        queryParameters: search != null ? {'search': search} : {},
      );
      final List<User> usersList = [
        for (final user in resp.data) User.fromJson(user)
      ];
      emit(UserRequestSuccess(usersList));
    } catch (e) {
      print(e);
      emit(UserRequestFailure());
    }
  }
}
