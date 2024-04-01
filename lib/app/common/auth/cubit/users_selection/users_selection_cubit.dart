import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'users_selection_state.dart';

class UsersSelectionCubit extends Cubit<UsersSelectionState> {
  UsersSelectionCubit() : super(UsersSelectionInitial());

  void getAllUsers({
    String? query,
  }) async {
    emit(UsersSelectionLoading());
    try {
      final resp = await dioClient.get('/core/users/',
          queryParameters: {if (query != null) 'search': query});
      final List<MiniUser> usersList = [
        for (final user in resp.data) MiniUser.fromJson(user)
      ];
      emit(UsersSelectionSuccess(usersList));
    } catch (e) {
      print(e);
      emit(UsersSelectionFailure(
          "Something went wrong. Please try again later"));
    }
  }
}
