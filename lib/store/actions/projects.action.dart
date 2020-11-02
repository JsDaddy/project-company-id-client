import 'package:company_id_new/store/models/project.model.dart';

class GetProjectsPending {
  GetProjectsPending({this.isFilter = false});
  bool isFilter;
}

class GetProjectsSuccess {
  GetProjectsSuccess(this.projects);
  List<ProjectModel> projects;
}

class GetDetailProjectPending {
  GetDetailProjectPending(this.projectId);
  String projectId;
}

class ClearDetailProject {}

class GetDetailProjectSuccess {
  GetDetailProjectSuccess(this.project);
  ProjectModel project;
}

class GetProjectPrefPending {}

class GetProjectPrefSuccess {
  GetProjectPrefSuccess(this.lastProjectId);
  String lastProjectId;
}

class SetProjectPrefPending {
  SetProjectPrefPending(this.lastProjectId);
  String lastProjectId;
}

class SetProjectPrefSuccess {
  SetProjectPrefSuccess(this.lastProjectId);
  String lastProjectId;
}
