import 'dart:io';
import 'package:company_id_new/common/helpers/app-constants.dart';
import 'package:company_id_new/common/services/local-storage.service.dart';
import 'package:dio/dio.dart';

AppApi api = AppApi(localStorageService);

class AppApi {
  AppApi(this.localStorageService) {
    dio.interceptors.addAll(<Interceptor>[
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
    baseUrl: AppConstants.baseUrl,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
}
