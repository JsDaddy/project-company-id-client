import 'dart:io';
import 'package:company_id_new/common/services/local-storage.service.dart';
import 'package:dio/dio.dart';

AppApi api = AppApi(localStorageService);

class AppApi {
  AppApi(this.localStorageService) {
    dio.interceptors.addAll(<Interceptor>[
      // LogInterceptor(),
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
            print('app-api dioerror: $e');
            if (e.response?.data != null) {
              return e.response?.data['error'];
            }
            return e.response;
          },
          onResponse: (Response<dynamic> res) => res.data['data']),
    ]);
  }

  final LocalStorageService localStorageService;
  final Dio dio = Dio(BaseOptions(
    connectTimeout: 10000,
    // baseUrl: 'http://10.0.2.2:8090',
    // baseUrl: 'http://localhost:8090',
    // baseUrl: 'http://192.168.88.70:8090',
    baseUrl: 'https://jsdaddy.io/company-id/api',
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
}
