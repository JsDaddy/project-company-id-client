import 'package:company_id_new/screens/projects/filter/filter.widget.dart';
import 'package:company_id_new/store/models/project-spec.model.dart';
import 'package:company_id_new/store/models/project-status.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class ProjectsFilterModel {
  ProjectsFilterModel({this.user, this.stack, this.spec, this.status});
  UserModel user;
  StackModel stack;
  ProjectSpecModel spec;
  ProjectStatusModel status;
  ProjectsFilterModel copyWith({
    ProjectStatusModel status,
    ProjectSpecModel spec,
    UserModel user,
    StackModel stack,
  }) =>
      ProjectsFilterModel(
        status: status ?? this.status,
        spec: spec ?? this.spec,
        stack: stack ?? this.stack,
        user: user ?? this.user,
      );
}
