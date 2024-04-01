import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListInitial());

  void getAllUsers({
    String? query,
    String? type,
  }) async {
    emit(UsersListLoading());
    try {
      final resp = await dioClient.get('/user/list/', queryParameters: {
        if (query != null) 'search': query,
        if (type != null) 'type': type
      });
      final List<User> usersList = [
        for (final user in resp.data) User.fromJson(user)
      ];
      emit(UsersListSuccess(usersList));
    } catch (e) {
      print(e);
      emit(UsersListFailure("Something went wrong. Please try again later"));
    }
  }
}
