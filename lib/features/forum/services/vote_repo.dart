import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';

import 'api_endpoints.dart';

class VoteRepo {
  Future<Either<String, Unit>> voteThread({
    required int threadId,
    required int vote,
  }) async {
    try {
      await dioClient.post(
        VOTE_THREAD,
        data: {
          'value': vote,
          'thread_id': threadId,
        },
      );
      return right(unit);
    } on DioException catch (_) {
      return left("Unable to vote thread");
    } catch (e) {
      return left("Something went wrong");
    }
  }
}
