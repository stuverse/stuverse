part of 'core_cubit.dart';

@freezed
class CoreState with _$CoreState {
  const factory CoreState({
    required bool isDarkMode,
    required bool isFirstTime,
    User? user,
    required bool isUserLoading,
  }) = _CoreState;
}
