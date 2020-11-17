import 'dart:io';
import 'package:dio/dio.dart';

Future<bool> sendMessage(String channel, String message) async {
  final Response<dynamic> res = await Dio(BaseOptions(
      connectTimeout: 10000,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      headers: <String, dynamic>{
        HttpHeaders.authorizationHeader:
            'Bearer xoxb-200421297187-1530498242480-vuDnwVj6ovX4XoUcn4NndEQx',
      })).post<dynamic>(
    'https://slack.com/api/chat.postMessage',
    data: <String, dynamic>{'channel': channel, 'text': message},
  );
  final Map<String, dynamic> response = res.data as Map<String, dynamic>;
  return response['ok'].toString() == 'true';
}
