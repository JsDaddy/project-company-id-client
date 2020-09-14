import 'package:company_id_new/store/models/project.model.dart';

class GetProjectsPending {}

class GetProjectsSuccess {
  GetProjectsSuccess(this.projects);
  List<ProjectModel> projects;
}
