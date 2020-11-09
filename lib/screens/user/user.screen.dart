import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/socials-rows/social-row-icon/social-row-icon.widget.dart';
import 'package:company_id_new/common/widgets/socials-rows/social-row.widget.dart';
import 'package:company_id_new/screens/project-details/project-details.screen.dart';
import 'package:company_id_new/screens/user/add-project/add-project.widget.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class _ViewModel {
  _ViewModel({this.user, this.authUser, this.isLoading});
  UserModel user;
  UserModel authUser;
  bool isLoading;
}

class UserScreen extends StatefulWidget {
  const UserScreen({this.uid});
  final String uid;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  SlidableController _slidableController;
  @override
  void initState() {
    _slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              user: store.state.currentUser,
              authUser: store.state.user,
              isLoading: store.state.isLoading,
            ),
        onInit: (Store<AppState> store) {
          store.dispatch(GetUserPending(widget.uid));
        },
        builder: (BuildContext context, _ViewModel state) {
          return Scaffold(
              floatingActionButton: state.authUser.position == Positions.Owner
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        showModalBottomSheet<dynamic>(
                            context: context,
                            useRootNavigator: true,
                            builder: (BuildContext context) {
                              return AddProjectWidget();
                            });
                      },
                    )
                  : Container(),
              body: state.isLoading
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ListView(
                        children: <Widget>[
                          state.authUser.position == Positions.Owner &&
                                  state.authUser.id != state.user.id
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SocialRowIconWidget(
                                            icon: Icons.pool,
                                            title:
                                                '${state.user.vacationAvailable}/18'),
                                        const SizedBox(height: 8),
                                        SocialRowIconWidget(
                                            icon: Icons.local_hospital,
                                            title:
                                                '${state.user.sickAvailable}/5'),
                                      ]))
                              : Container(),
                          const SizedBox(height: 16),
                          const Text(
                            'Personal details',
                            style: TextStyle(
                                color: AppColors.lightGrey, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: SocialRowIconWidget(
                                  icon: Icons.cake,
                                  title: DateFormat('dd/MM/yyyy')
                                      .format(state.user?.date),
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: SocialRowIconWidget(
                                  icon: Icons.supervised_user_circle,
                                  title: AppConverting.getPositionFromString(
                                      state.user.position),
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: SocialRowIconWidget(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      36,
                                  icon: Icons.language,
                                  title: state.user.englishLevel,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Contacts',
                            style: TextStyle(
                                color: AppColors.lightGrey, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: state.user.github != null
                                    ? GestureDetector(
                                        onTap: () => _openUrl(
                                              'https://github.com/${state.user.github}',
                                            ),
                                        child: SocialRowWidget(
                                            iconName: AppImages.github,
                                            title: state.user.github))
                                    : Container(),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: state.user.skype != null
                                    ? GestureDetector(
                                        onTap: () => _openUrl(
                                              'skype:${state.user.skype}',
                                            ),
                                        child: SocialRowWidget(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                36,
                                            iconName: AppImages.skype,
                                            title: state.user.skype))
                                    : Container(),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: state.user.email != null
                                    ? GestureDetector(
                                        onTap: () => _openUrl(
                                              'mailto:${state.user.email}',
                                            ),
                                        child: SocialRowIconWidget(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                36,
                                            icon: Icons.email,
                                            title: state.user.email))
                                    : Container(),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 12,
                                child: state.user.phone != null
                                    ? GestureDetector(
                                        onTap: () => _openUrl(
                                              'tel://:${state.user.phone}',
                                            ),
                                        child: SocialRowIconWidget(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                36,
                                            icon: Icons.phone,
                                            title: state.user.phone))
                                    : Container(),
                              ),
                            ],
                          ),
                          ..._projects(state.user, state.user.activeProjects,
                              state.authUser.position, true),
                          ..._projects(state.user, state.user.projects,
                              state.authUser.position, false),
                        ],
                      ),
                    ));
        });
  }

  List<Widget> _projects(UserModel user, List<ProjectModel> projects,
      Positions position, bool isActive) {
    return projects[0].id == null
        ? <Widget>[]
        : <Widget>[
            const SizedBox(height: 16),
            Text(
              isActive ? 'Active projects' : 'Projects',
              style: const TextStyle(color: AppColors.lightGrey, fontSize: 18),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  final ProjectModel project = projects[index];
                  return Opacity(
                    opacity: project.isInternal ? 0.6 : 1,
                    child: Slidable(
                      controller: _slidableController,
                      actionPane: const SlidableDrawerActionPane(),
                      enabled: position == Positions.Owner &&
                          project.endDate == null,
                      actionExtentRatio: 0.1,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            color: AppColors.bg,
                            icon: isActive ? Icons.history : Icons.person_add,
                            onTap: () {
                              if (isActive) {
                                store.dispatch(RemoveProjectFromUserPending(
                                    widget.uid, project));
                              } else {
                                final bool isUserOnBoard = user.activeProjects
                                    .any((ProjectModel selectedProject) =>
                                        selectedProject.id == project.id);
                                if (isUserOnBoard) {
                                  store.dispatch(Notify(NotifyModel(
                                      NotificationType.Error,
                                      'This project is already in the active projects')));
                                } else {
                                  store.dispatch(AddUserToProjectPending(
                                      user, project, true,
                                      isAddedUserToProject: false));
                                }
                              }
                            })
                      ],
                      child: AppListTile(
                        onTap: () => store.dispatch(PushAction(
                            ProjectDetailsScreen(projectId: project.id),
                            project.name)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ];
  }

  Future<dynamic> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      store.dispatch(
          Notify(NotifyModel(NotificationType.Error, 'Could not launch $url')));
    }
  }
}
