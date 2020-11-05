import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class ProjectModel {
  ProjectModel(
      {this.id,
      this.customer,
      this.endDate,
      this.industry,
      this.isInternal,
      this.isActivity,
      this.name,
      this.stack,
      this.startDate,
      this.status,
      this.history,
      this.onboard});
  String id;
  String name;
  String status;
  bool isInternal;
  String customer;
  String industry;
  List<StackModel> stack;
  List<UserModel> onboard;
  List<UserModel> history;
  DateTime startDate;
  DateTime endDate;
  bool isActivity;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'isInternal': isInternal,
      'startDate': startDate.toString(),
      'customer': customer,
      'industry': industry,
      'isActivity': isActivity,
      'stack': stack.map<dynamic>((StackModel item) => item.id).toList(),
      'users': onboard.map<dynamic>((UserModel item) => item.id).toList(),
    };
  }

  static ProjectModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return ProjectModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      isInternal:
          json['isInternal'] == null ? null : json['isInternal'] as bool,
      isActivity:
          json['isActivity'] == null ? null : json['isActivity'] as bool,
      customer: json['customer'] as String,
      industry: json['industry'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      stack: json['stack'] != null
          ? json['stack']
              .map<StackModel>((dynamic stack) =>
                  StackModel.fromJson(stack as Map<String, dynamic>))
              .toList() as List<StackModel>
          : null,
      history: json['history'] != null
          ? json['history']
              .map<UserModel>((dynamic user) =>
                  UserModel.fromJson(user as Map<String, dynamic>))
              .toList() as List<UserModel>
          : null,
      onboard: json['onboard'] != null
          ? json['onboard']
              .map<UserModel>((dynamic user) =>
                  UserModel.fromJson(user as Map<String, dynamic>))
              .toList() as List<UserModel>
          : null,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );
  }
}
