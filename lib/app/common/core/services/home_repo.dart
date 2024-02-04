import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

import 'api_endpoints.dart';

class HomeRepo {
  Future<Either<String, List<Thread>>> getHomeData() async {
    try {
      final response = await dioClient.get(HOMEDATA_API);
      final List<Thread> threads =
          (response.data as List).map((e) => Thread.fromJson(e)).toList();
      return right(threads);
    } on DioException catch (e) {
      return left("Server Error");
    } catch (e) {
      return left("Client Error");
    }
  }
}
