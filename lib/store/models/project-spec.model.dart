import 'package:company_id_new/common/helpers/app-enums.dart';

class ProjectSpecModel {
  ProjectSpecModel(this.title, this.spec);
  String title;
  ProjectSpec spec;
  String getSpecQuery() {
    const String queryStart = 'isInternal=';
    switch (spec) {
      case ProjectSpec.Internal:
        return '${queryStart}true';
      case ProjectSpec.Commercial:
        return '${queryStart}false';
      default:
        return '';
    }
  }
}
