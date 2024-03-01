import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stuverse/app/app.dart';

part 'core_state.dart';
part 'core_cubit.freezed.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit()
      : super(CoreState(
          isDarkMode: true,
          isFirstTime: true,
          user: null,
          isUserLoading: true,
        ));

  void getInitialData() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    final _isDarkMode = await _sharedPreferences.getBool("isDarkMode") ?? true;
    final _isFirstTime =
        await _sharedPreferences.getBool("isFirstTime") ?? true;
    User? user;
    try {
      final resp = await dioClient.get(USER_PROFILE_API);
      user = User.fromJson(resp.data);
    } catch (e) {
      log(e.toString());
    }
    emit(CoreState(
      isDarkMode: _isDarkMode,
      isFirstTime: _isFirstTime,
      user: user,
      isUserLoading: false,
    ));
  }

  void setIsFirstTime(bool isFirstTime) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setBool("isFirstTime", isFirstTime);
  }

  void setUser(User user) async {
    emit(state.copyWith(user: user));
  }

  void signOut() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove("token_refresh");
    await _sharedPreferences.remove("token_access");

    emit(state.copyWith(user: null));
  }

  void toggleTheme() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    final _isDarkMode = !state.isDarkMode;
    await _sharedPreferences.setBool("isDarkMode", _isDarkMode);
    emit(state.copyWith(isDarkMode: _isDarkMode));
  }
}
