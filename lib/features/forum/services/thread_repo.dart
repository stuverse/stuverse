import 'package:fpdart/fpdart.dart';
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
}
