import 'package:company_id_new/store/models/stack.model.dart';

class ProjectModel {
  ProjectModel(
      {this.id,
      this.customer,
      this.endDate,
      this.industry,
      this.isActivity,
      this.isInternal,
      this.isRejected,
      this.name,
      this.stack,
      this.startDate});
  String id;
  String name;
  bool isInternal;
  bool isRejected;
  bool isActivity;
  String customer;
  String industry;
  List<StackModel> stack;
  DateTime startDate;
  DateTime endDate;
  static ProjectModel fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return ProjectModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      isInternal: json['isInternal'] as bool,
      isRejected: json['isRejected'] as bool,
      isActivity: json['isActivity'] as bool,
      customer: json['customer'] as String,
      industry: json['industry'] as String,
      // stack: json['stack'] != null
      //     ? json['stack'].map((dynamic stack) =>
      //             StackModel.fromJson(stack as Map<String, dynamic>))
      //         as List<StackModel>
      // : null,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );
  }
}
