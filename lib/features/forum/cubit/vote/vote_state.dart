part of 'vote_cubit.dart';

@freezed
class VoteState with _$VoteState {
  const factory VoteState.initial() = _Initial;
  const factory VoteState.loading() = _Loading;
  const factory VoteState.success() = _Success;
  const factory VoteState.error({
    required String message,
    required int vote,
  }) = _Error;
}
