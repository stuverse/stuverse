import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'vote_state.dart';
part 'vote_cubit.freezed.dart';

class VoteCubit extends Cubit<VoteState> {
  VoteCubit() : super(VoteState.initial());

  final _voteRepo = VoteRepo();

  void voteThread({
    required int threadId,
    required int vote,
  }) async {
    emit(VoteState.loading());
    final result = await _voteRepo.voteThread(
      threadId: threadId,
      vote: vote,
    );
    result.fold(
      (error) => emit(VoteState.error(message: error, vote: vote)),
      (_) => emit(VoteState.success()),
    );
  }
}
