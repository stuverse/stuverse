import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDev = false;

final APIBASEURL = isDev
    ? Platform.isAndroid
        ? 'http://10.0.2.2:8000/api'
        : 'http://127.0.0.1:8000/api'
    : 'https://stuverse.in/api';

final dioClient = Dio(
  BaseOptions(
    baseUrl: APIBASEURL,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get the token from Hive box auth
        String? token;
        try {
          final sharedPrefs = await SharedPreferences.getInstance();
          token = sharedPrefs.getString('token');
        } catch (e) {
          log(e.toString());
        }

        // Add the Authorization header with the token
        if (token != null) options.headers['Authorization'] = 'Bearer $token';

        return handler.next(options);
      },
    ),
  );
