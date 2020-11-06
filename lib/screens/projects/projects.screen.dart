import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/confirm-dialog/confirm-dialog.widget.dart';
import 'package:company_id_new/common/widgets/filter-item/filter-item.widget.dart';
import 'package:company_id_new/screens/create-project/create-project.screen.dart';
import 'package:company_id_new/screens/project-details/project-details.screen.dart';
import 'package:company_id_new/screens/projects/filter/filter.widget.dart';
import 'package:company_id_new/store/actions/filter.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/stack.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/common/helpers/enums.dart';
import 'package:company_id_new/store/models/project-spec.model.dart';
import 'package:company_id_new/store/models/project-status.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/projects-filter.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.projects, this.isLoading, this.filter, this.user});
  List<ProjectModel> projects;
  UserModel user;
  bool isLoading;
  ProjectsFilterModel filter;
}

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<SpeedDialChild> speedDials = <SpeedDialChild>[];
  @override
  void initState() {
    speedDials = <SpeedDialChild>[
      speedDialChild(
          () => showModalBottomSheet<dynamic>(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (BuildContext context) => FilterProjectsWidget()),
          const Icon(Icons.search)),
      speedDialChild(
          () => store
              .dispatch(PushAction(CreateProjectScreen(), 'Create project')),
          const Icon(Icons.add))
    ];
    if (store.state.projects != null && store.state.projects.isNotEmpty) {
      return;
    }
    store.dispatch(GetProjectsPending());
    store.dispatch(GetStackPending());
    super.initState();
  }

  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            projects: store.state.projects,
            isLoading: store.state.isLoading,
            user: store.state.user,
            filter: store.state.projectsFilter),
        onWillChange: (_ViewModel prev, _ViewModel curr) {
          if (prev.filter != curr.filter) {
            store.dispatch(GetProjectsPending());
          }
        },
        builder: (BuildContext context, _ViewModel state) {
          return Scaffold(
            floatingActionButton: SpeedDial(
              child: const Icon(Icons.menu),
              elevation: 8.0,
              shape: const CircleBorder(),
              curve: Curves.bounceIn,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: const IconThemeData(size: 22.0),
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              children: speedDials,
            ),
            body: ListView(
              children: <Widget>[
                const SizedBox(height: 0.1),
                state.filter != null
                    ? Wrap(children: <Widget>[
                        state.filter?.user?.id != null
                            ? InkWell(
                                onTap: () {
                                  store.dispatch(SaveProjectsFilter(state.filter
                                      .copyWith(user: UserModel())));
                                },
                                child: FilterItemWidget(
                                  title:
                                      '${state.filter.user.name} ${state.filter.user.lastName}',
                                  icon: Icons.person,
                                ),
                              )
                            : Container(),
                        state.filter?.stack?.id != null
                            ? InkWell(
                                onTap: () {
                                  store.dispatch(SaveProjectsFilter(state.filter
                                      .copyWith(stack: StackModel())));
                                },
                                child: FilterItemWidget(
                                  title: state.filter.stack.name,
                                  icon: Icons.menu,
                                ),
                              )
                            : Container(),
                        state.filter?.spec?.title != null &&
                                state.filter.spec.spec != ProjectSpec.All
                            ? InkWell(
                                onTap: () {
                                  store.dispatch(SaveProjectsFilter(state.filter
                                      .copyWith(
                                          spec: ProjectSpecModel(
                                              'All', ProjectSpec.All))));
                                },
                                child: FilterItemWidget(
                                  title: state.filter.spec?.title,
                                  icon: Icons.menu,
                                ),
                              )
                            : Container(),
                        state.filter?.status?.title != null &&
                                state.filter.status.status != ProjectStatus.All
                            ? InkWell(
                                onTap: () {
                                  store.dispatch(SaveProjectsFilter(state.filter
                                      .copyWith(
                                          status: ProjectStatusModel(
                                              'All', ProjectStatus.All))));
                                },
                                child: FilterItemWidget(
                                  title: state.filter.status?.title,
                                  icon: Icons.menu,
                                ),
                              )
                            : Container(),
                      ])
                    : Container(),
                _projects(state)
              ],
            ),
          );
        });
  }

  Widget _projects(_ViewModel state) {
    return state.isLoading
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.projects.length,
            itemBuilder: (BuildContext context, int index) {
              final ProjectModel project = state.projects[index];
              return Opacity(
                opacity:
                    project.isInternal || project.endDate != null ? 0.6 : 1,
                child: Slidable(
                  enabled: state.user.position == Positions.OWNER &&
                      project.endDate == null,
                  controller: _slidableController,
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.1,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      color: AppColors.bg,
                      iconWidget: IconButton(
                          icon: const Icon(Icons.archive),
                          color: Colors.white,
                          onPressed: () async {
                            final bool isConfirm = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const ConfirmDialogWidget(
                                      title: 'Project',
                                      text:
                                          'Are you sure to finish the project?');
                                });
                            store.dispatch(SetTitle('Projects'));
                            if (!isConfirm) {
                              return;
                            }
                            store.dispatch(ArchiveProjectPending(
                                project.id, ProjectStatus.Finished));
                          }),
                    ),
                    IconSlideAction(
                      color: AppColors.bg,
                      iconWidget: IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Colors.white,
                          onPressed: () async {
                            final bool isConfirm = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const ConfirmDialogWidget(
                                      title: 'Project',
                                      text:
                                          'Are you sure to reject the project?');
                                });
                            store.dispatch(SetTitle('Projects'));
                            if (!isConfirm) {
                              return;
                            }
                            store.dispatch(ArchiveProjectPending(
                                project.id, ProjectStatus.Rejected));
                          }),
                    ),
                  ],
                  child: AppListTile(
                    onTap: () {
                      store.dispatch(SetTitle(project.name));
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  ProjectDetailsScreen(
                                    projectId: project.id,
                                  )));
                    },
                    leading: Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Text(project.name,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white)),
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

  SpeedDialChild speedDialChild(Function func, Widget icon) {
    return SpeedDialChild(
        child: icon, backgroundColor: AppColors.red, onTap: () => func());
  }
}
