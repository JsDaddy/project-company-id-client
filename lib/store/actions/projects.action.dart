import 'package:company_id_new/store/models/project.model.dart';

class GetProjectsPending {}

class GetProjectsSuccess {
  GetProjectsSuccess(this.projects);
  List<ProjectModel> projects;
}

class GetDetailProjectPending {
  GetDetailProjectPending(this.projectId);
  String projectId;
}

class GetDetailProjectSuccess {
  GetDetailProjectSuccess(this.project);
  ProjectModel project;
}
