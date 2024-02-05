import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class CommentRepo {
  Future<Either<String, List<ThreadComment>>> getThreadComment({
    required int threadId,
  }) async {
    try {
      final response = await dioClient.get(
        GET_THREAD_COMMENT.replaceFirst("<id>", threadId.toString()),
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
}
