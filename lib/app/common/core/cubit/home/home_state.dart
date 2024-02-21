part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required List<Thread> threads,
  }) = _Loaded;
  const factory HomeState.failure({
    required String message,
  }) = _Failure;
}
