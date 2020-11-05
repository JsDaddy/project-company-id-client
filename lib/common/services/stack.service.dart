import 'package:company_id_new/common/helpers/app-api.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:dio/dio.dart';

Future<List<StackModel>> getStack() async {
  final Response<dynamic> res = await api.dio.get<dynamic>('/stack');

  final List<dynamic> stack = res.data as List<dynamic>;
  return stack.isEmpty
      ? <StackModel>[]
      : stack
          .map<StackModel>(
              (dynamic st) => StackModel.fromJson(st as Map<String, dynamic>))
          .toList();
}
