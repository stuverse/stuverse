import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/models/mini_user.dart';

part 'users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListInitial());

  void getAllUsers({
    String? query,
  })async{
    emit(UsersListLoading());
    try {
      final resp = await dioClient.get('/core/users/',
        queryParameters: {
          if (query != null) 'search': query
        }
      );
      final List<MiniUser> usersList = [
        for (final user in resp.data) MiniUser.fromJson(user)
      ];
      emit(UsersListSuccess(usersList));
    } catch (e) {
      print(e);
      emit(UsersListFailure(
        "Something went wrong. Please try again later"
      ));
    }
  }
}
