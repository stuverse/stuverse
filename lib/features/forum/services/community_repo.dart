import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

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
  }) async {
    try {
      final response =
          await dioClient.get(COMMUNITY_LIST_CREATE_API, queryParameters: {
        if (search != null) 'search': search,
        if (isPrivate != null) 'is_private': isPrivate,
      });
      final List<Community> communities =
          (response.data as List).map((e) => Community.fromJson(e)).toList();
      return right(communities);
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
        COMMUNITY_EDIT_API.replaceFirst("<id>", communityId.toString()),
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
}
