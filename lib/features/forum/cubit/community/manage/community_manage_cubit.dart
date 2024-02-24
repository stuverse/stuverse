import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/forum/forum.dart';

part 'community_manage_state.dart';

class CommunityManageCubit extends Cubit<CommunityManageState> {
  CommunityManageCubit() : super(CommunityManageInitial());
  final _communityRepo = CommunityRepo();

  void toggleJoinCommunity({
    required int communityId,
  }) async {
    emit(CommunityJoinLoading());
    final result = await _communityRepo.toggleJoinCommunity(communityId);
    result.fold(
      (failure) {
        emit(CommunityJoinError(message: failure));
      },
      (success) {
        emit(CommunityJoinSuccess());
      },
    );
  }

  void editCommunity({
    required int communityId,
    required String name,
    required String description,
    required bool isPrivate,
    XFile? image,
  }) async {
    emit(CommunityUpdateLoading());
    final result = await _communityRepo.editCommunity(
      communityId: communityId,
      name: name,
      description: description,
      isPrivate: isPrivate,
      image: image,
    );
    result.fold(
      (failure) {
        emit(CommunityUpdateError(message: failure));
      },
      (success) {
        emit(CommunityUpdateSuccess());
      },
    );
  }

  void addCommunity({
    required String name,
    required String description,
    required bool isPrivate,
    XFile? image,
  }) async {
    emit(CommunityCreateLoading());
    final result = await _communityRepo.addCommunity(
      name: name,
      description: description,
      isPrivate: isPrivate,
      image: image,
    );
    result.fold(
      (error) => emit(CommunityCreateError(message: error)),
      (success) => emit(CommunityCreateSuccess()),
    );
  }

  // @override
  // Future<void> close() {
  //   log("CommunityManageCubit closed");
  //   return super.close();
  // }
}
