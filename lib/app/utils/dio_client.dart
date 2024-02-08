import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stuverse/app/utils/logman_dio_interceptor.dart';

bool isDev = true;
bool isEmulator = false;

String getBaseUrl() {
  if (isDev) {
    if (Platform.isAndroid && isEmulator) return 'http://10.0.2.2:8000/api';
    return 'http://localhost:8000/api';
  } else {
    return 'https://stuverse.in/api';
  }
}

const String JWT_REFRESH_API = '/token/refresh/';
final _baseOptions = BaseOptions(
  baseUrl: getBaseUrl(),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
);

final dioClient = Dio(
  _baseOptions,
)
  ..interceptors.add(interceptorWrapper)
  ..interceptors.add(LogmanDioInterceptor());

final interceptorWrapper =
    InterceptorsWrapper(onRequest: (options, handler) async {
  String? tokenAccess;
  try {
    final sharedPrefs = await SharedPreferences.getInstance();
    tokenAccess = sharedPrefs.getString("token_access");
    log("Trying Token Access : " + tokenAccess.toString());
  } catch (e) {
    log(e.toString());
  }

  if (tokenAccess != null && tokenAccess != "") {
    options.headers['Authorization'] = 'Bearer $tokenAccess';
  }

  return handler.next(options);
}, onError: (e, handler) async {
  String? tokenRefresh;
  try {
    final sharedPrefs = await SharedPreferences.getInstance();
    tokenRefresh = sharedPrefs.getString("token_refresh");

    // await sharedPrefs.setString("token_refresh", "");
    // await sharedPrefs.setString("token_access", "");
  } catch (e) {
    log(e.toString());
  }
  if (e.response?.statusCode == 401 &&
      e.response?.requestOptions.path != JWT_REFRESH_API &&
      tokenRefresh != null) {
    log("Trying Refreshinnnng");
    final RequestOptions options = e.response!.requestOptions;
    try {
      final resp = await Dio(
        _baseOptions,
      ).post(JWT_REFRESH_API, data: {"refresh": tokenRefresh});

      final String newAccess = resp.data['access'] as String;
      final String newRefresh = resp.data['refresh'] as String;

      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString("token_refresh", newRefresh);
      await sharedPrefs.setString("token_access", newAccess);
      // Retry request
      options.headers['Authorization'] = 'Bearer $newAccess';
      final Response response = await Dio(
        _baseOptions,
      ).fetch(options);

      return handler.resolve(response);
    } catch (e, s) {
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString("token_refresh", "");
      await sharedPrefs.setString("token_access", "");
      print(e);
      print(s);

      // Refresh token expired
      // Redirect user to login...
    }
  }

  return handler.next(e);
});
