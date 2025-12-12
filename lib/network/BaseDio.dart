// lib/network/base_dio.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseDio {
  static Dio create({
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
    bool enableLog = kDebugMode,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        if (defaultHeaders != null) ...defaultHeaders,
      },
    ));

    if (enableLog) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ));
    }

    // 自定义拦截器（token 注入、统一错误处理等）
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // options.headers['Authorization'] = 'Bearer xxx';
        handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (e, handler) => handler.next(e),
    ));

    return dio;
  }
}
