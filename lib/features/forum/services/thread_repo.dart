import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse/app/app.dart';

import '../models/thread/thread.dart';
import 'api_endpoints.dart';

class ThreadRepo {
  Future<Either<String, List<Thread>>> getThreads({
    int? communityId,
    String? search,
    int? tagId,
  }) async {
    try {
      final response = await dioClient.get(GET_THREADS_API, queryParameters: {
        if (communityId != null) 'community__id': communityId,
        if (search != null) 'search': search,
        if (tagId != null) 'tag__id': tagId,
      });
      final threads =
          (response.data as List).map((e) => Thread.fromJson(e)).toList();

      return right(threads);
    } catch (e) {
      return left('Failed to get threads');
    }
  }

  Future<Either<String, Thread>> getThread(int threadId) async {
    try {
      final response =
          await dioClient.get(MANAGE_THREAD_API, data: {'id': threadId});
      final thread = Thread.fromJson(response.data);

      return right(thread);
    } catch (e) {
      return left('Failed to get thread');
    }
  }

  Future<Either<String, Unit>> createThread({
    required String title,
    String? content,
    required int communityId,
    XFile? image,
    List<int>? tags,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        if (content != null) 'content': content,
        'community': communityId,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        if (tags != null) 'tags': tags,
      });
      await dioClient.post(
        MANAGE_THREAD_API,
        data: formData,
      );

      return right(unit);
    } catch (e) {
      return left('Failed to create thread');
    }
  }

  Future<Either<String, Unit>> editThread({
    required int threadId,
    required String title,
    String? content,
    XFile? image,
    List<int>? tags,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': threadId,
        'title': title,
        if (content != null) 'content': content,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        if (tags != null) 'tags': tags,
      });
      await dioClient.patch(
        MANAGE_THREAD_API,
        data: formData,
      );

      return right(unit);
    } catch (e) {
      return left('Failed to edit thread');
    }
  }

  Future<Either<String, String>> threadSummarize(int id) async {
    try {
      final response = await dioClient
          .get(THREAD_SUMMARIZE.replaceFirst('<id>', id.toString()));
      return right(response.data['result']);
    } catch (e) {
      return left('Failed to summarize thread');
    }
  }
}
