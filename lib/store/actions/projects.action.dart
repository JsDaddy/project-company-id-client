import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/user.model.dart';

class GetProjectsPending {
  GetProjectsPending({this.projectTypes = ProjectsType.Default, this.userId});
  ProjectsType projectTypes;
  String userId;
}

class GetProjectsSuccess {
  GetProjectsSuccess(this.projects);
  List<ProjectModel> projects;
}

class GetProjectsError {}

class GetDetailProjectPending {
  GetDetailProjectPending(this.projectId);
  String projectId;
}

class ClearDetailProject {}

class GetDetailProjectSuccess {
  GetDetailProjectSuccess(this.project);
  ProjectModel project;
}

class GetDetailProjectError {}

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

class AddUserToProjectPending {
  AddUserToProjectPending(this.user, this.project, this.isActive,
      {this.isAddedUserToProject = true});
  UserModel user;
  bool isActive;
  bool isAddedUserToProject;
  ProjectModel project;
}

class AddUserToProjectSuccess {
  AddUserToProjectSuccess(this.user, this.isActive);
  bool isActive;
  UserModel user;
}

class AddProjectToUserSuccess {
  AddProjectToUserSuccess(this.project);
  ProjectModel project;
}

class AddUserToProjectError {}

class RemoveUserFromProjectPending {
  RemoveUserFromProjectPending(this.user, this.projectId);
  UserModel user;
  String projectId;
}

class RemoveUserFromProjectSuccess {
  RemoveUserFromProjectSuccess(this.user);
  UserModel user;
}

class RemoveUserFromProjectError {}

enum ProjectsType { Default, Filter, Absent }

class GetAbsentProjectsSuccess {
  GetAbsentProjectsSuccess(this.absentProjects, this.projectTypes);
  List<ProjectModel> absentProjects;
  ProjectsType projectTypes;
}

class GetAbsentProjectsError {}
