import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class ThreadCommentRepo {
  Future<Either<String, List<ThreadComment>>> getThreadComment({
    required int threadId,
  }) async {
    try {
      final response = await dioClient.get(
        GET_THREAD_COMMENT_API.replaceFirst("<id>", threadId.toString()),
      );
      final data = response.data as List;
      final comments = data.map((e) => ThreadComment.fromJson(e)).toList();
      return right(comments);
    } on DioException catch (_) {
      return left("Unable to get thread comments");
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, ThreadComment>> addThreadComment({
    required int threadId,
    required String content,
    int? parentId,
  }) async {
    try {
      final resp = await dioClient.post(
        ADD_THREAD_COMMENT_API,
        data: {
          'thread_id': threadId,
          'content': content,
          if (parentId != null) 'parent_id': parentId,
        },
      );
      return right(ThreadComment.fromJson(resp.data));
    } on DioException catch (_) {
      return left("Unable to add thread comment");
    } catch (e) {
      return left("Something went wrong");
    }
  }

}
