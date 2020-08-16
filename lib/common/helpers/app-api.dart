import 'dart:io';
import 'package:company_id_new/common/services/local-storage.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

AppApi api = AppApi(localStorageService);

class AppApi {
  AppApi(this.localStorageService) {
    if (!kReleaseMode) {
      dio.interceptors.addAll(<Interceptor>[
        LogInterceptor(),
        InterceptorsWrapper(
            onRequest: (RequestOptions requestOptions) async {
              dio.interceptors.requestLock.lock();
              final String token = await localStorageService.getTokenKey();
              if (token != null) {
                requestOptions.headers[HttpHeaders.authorizationHeader] =
                    'Bearer $token';
              }
              dio.interceptors.requestLock.unlock();
              return requestOptions;
            },
            onError: (DioError e) {
              print(e);
              return e.response.data['error'];
            },
            onResponse: (Response<dynamic> res) => res.data['data']),
      ]);
    }
  }

  final LocalStorageService localStorageService;
  final Dio dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: 'http://10.0.2.2:8090',
    // baseUrl: 'http://localhost:8090',
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
}
