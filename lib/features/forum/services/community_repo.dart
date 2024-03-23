import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import '../../../app/models/mini_user.dart';

class CommunityRepo {
  Future<Either<String, Unit>> toggleJoinCommunity(
    int communityId,
  ) async {
    try {
      await dioClient.post(
        TOGGLE_JOIN_COMMUNITY_API,
        data: {
          'community_id': communityId,
        },
      );
      return right(unit);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, List<Community>>> getAllCommunities({
    String? search,
    bool? isPrivate,
    int? userId,
  }) async {
    try {
      final response =
          await dioClient.get(COMMUNITY_LIST_CREATE_API, queryParameters: {
        if (search != null) 'search': search,
        if (isPrivate != null) 'is_private': isPrivate,
        if (userId != null) 'members': userId,
      });
      final List<Community> communities =
          (response.data as List).map((e) => Community.fromJson(e)).toList();
      return right(communities);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, Community>> getCommunity(int communityId) async {
    try {
      final response = await dioClient.get(
        COMMUNITY_MANAGE_API.replaceFirst("<id>", communityId.toString()),
      );
      final Community community = Community.fromJson(response.data);
      return right(community);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, Unit>> editCommunity({
    required int communityId,
    required String name,
    required String description,
    required bool isPrivate,
    XFile? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "description": description,
        "is_private": isPrivate,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });
      await dioClient.patch(
        COMMUNITY_MANAGE_API.replaceFirst("<id>", communityId.toString()),
        data: formData,
      );
      return right(unit);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, Unit>> addCommunity({
    required String name,
    required String description,
    required bool isPrivate,
    XFile? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "description": description,
        "is_private": isPrivate,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });
      await dioClient.post(
        COMMUNITY_LIST_CREATE_API,
        data: formData,
      );
      return right(unit);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, List<MiniUser>>> getCommunityMembers(
      int communityId) async {
    try {
      final response = await dioClient.get(
        GET_COMMUNITY_MEMBERS_API.replaceFirst("<id>", communityId.toString()),
      );
      final List<MiniUser> members =
          (response.data as List).map((e) => MiniUser.fromJson(e)).toList();
      return right(members);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, Unit>> addMembersToCommunity({
    required int communityId,
    required List<int> users,
  }) async {
    try {
      await dioClient.post(
        COMMUNITY_MEMBERS_MANAGE_API,
        data: {'community_id': communityId, 'users': users},
      );
      return right(unit);
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, Unit>> removeMemberFromCommunity({
    required int communityId,
    required String userId,
  }) async {
    try {
      await dioClient.delete(
        COMMUNITY_MEMBERS_MANAGE_API,
        data: {
          'community_id': communityId,
          'user_id': userId,
        },
      );
      return right(unit);
    } catch (e) {
      return left("Something went wrong");
    }
  }
}
