import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'community_detail_state.dart';

class CommunityDetailCubit extends Cubit<CommunityDetailState> {
  CommunityDetailCubit()
      : super(CommunityDetailState(
          community: Community(),
          threads: [],
          communityStatus: APIStatus.initial,
          threadsStatus: APIStatus.initial,
          message: "",
        ));

  final _threadRepo = ThreadRepo();
  final _communityRepo = CommunityRepo();

  void getCommunity({required int communityId}) async {
    emit(
      state.copyWith(
        communityStatus: APIStatus.loading,
      ),
    );
    final result = await _communityRepo.getCommunity(communityId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            communityStatus: APIStatus.error,
            message: failure,
          ),
        );
      },
      (community) {
        emit(
          state.copyWith(
            community: community,
            communityStatus: APIStatus.success,
          ),
        );
        getCommunityThreads(communityId: communityId);
      },
    );
  }

  void getCommunityThreads(
      {required int communityId, String? search, int? tagId}) async {
    emit(
      state.copyWith(
        threadsStatus: APIStatus.loading,
      ),
    );
    final result = await _threadRepo.getThreads(
      communityId: communityId,
      search: search,
      tagId: tagId,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            threadsStatus: APIStatus.error,
            message: failure,
          ),
        );
      },
      (threads) {
        emit(
          state.copyWith(
            threads: threads,
            threadsStatus: APIStatus.success,
          ),
        );
      },
    );
  }
}
