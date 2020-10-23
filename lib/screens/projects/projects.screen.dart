import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/screens/project-details/project-details.screen.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({
    this.projects,
  });
  List<ProjectModel> projects;
}

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    store.dispatch(GetProjectsPending());
    super.initState();
  }

  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              projects: store.state.projects,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return Scaffold(
            body: ListView(
              children: <Widget>[_projects(state)],
            ),
          );
        });
  }

  Widget _projects(_ViewModel state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.projects.length,
        itemBuilder: (BuildContext context, int index) {
          final ProjectModel project = state.projects[index];
          return Opacity(
            opacity: project.isInternal || project.endDate != null ? 0.6 : 1,
            child: Slidable(
              // enabled: state.user.role == 'admin' && project.endDate == null,
              enabled: false,
              controller: _slidableController,
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.1,
              secondaryActions: <Widget>[
                IconSlideAction(
                  color: AppColors.bg,
                  iconWidget: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.white,
                      onPressed: () {}),
                ),
              ],
              child: AppListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProjectDetailsScreen(
                              projectId: project.id,
                            ))),
                leading: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(project.name,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white)),
                ),
                title: Wrap(
                    children: project.stack
                        .map(
                          (StackModel stack) => Container(
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(stack.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        )
                        .toList()),
                trailing: Container(
                  width: MediaQuery.of(context).size.width / 5.2,
                  child: Text(
                    '${converter.dateFromString((project.startDate).toString())} - ${project.endDate != null ? converter.dateFromString((project.endDate).toString()) : 'now'}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
