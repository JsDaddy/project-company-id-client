import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/projects.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/project.model.dart';
import 'package:company_id_new/store/models/stack.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';

import '../../common/widgets/notifier/notifier.widget.dart';
import '../../store/actions/users.action.dart';
import '../../store/models/project.model.dart';
import '../../store/models/project.model.dart';
import '../../store/models/project.model.dart';
import '../../store/models/project.model.dart';
import '../../store/models/user.model.dart';

class _ViewModel {
  _ViewModel({this.project, this.user});
  ProjectModel project;
  UserModel user;
}

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({this.projectId});
  final String projectId;

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  SlidableController _slidableController;
  @override
  void initState() {
    _slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) =>
            _ViewModel(project: store.state.project, user: store.state.user),
        onInit: (Store<AppState> store) {
          store.dispatch(GetDetailProjectPending(widget.projectId));
        },
        builder: (BuildContext context, _ViewModel state) {
          return Notifier(
            child: Scaffold(
              floatingActionButton: state.user.position == Positions.OWNER &&
                      state.project.endDate == null
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        // showModalBottomSheet(
                        //     context: context,
                        //     useRootNavigator: true,
                        //     builder: (BuildContext context) {
                        //       return BottomAddUserWidget(project: project);
                        //     });
                      },
                    )
                  : Container(),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: ListView(
                  children: <Widget>[
                    Text('General info',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18)),
                    const SizedBox(height: 12),
                    _projectInfo('Industry: ', state.project.industry),
                    _projectInfo('Duration: ',
                        '${converter.dateFromString((state.project.startDate).toString())} - ${state.project.endDate != null ? converter.dateFromString((state.project.endDate).toString()) : 'now'}'),
                    _projectInfo('Customer: ', state.project.customer),
                    const SizedBox(height: 12),
                    Text('Stack',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18)),
                    const SizedBox(height: 12),
                    _stack(state.project.stack),
                    const SizedBox(height: 12),
                    Text('Onboard',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18)),
                    const SizedBox(height: 12),
                    _projectsList(state.project, state.project.onboard,
                        state.user.position),
                    const SizedBox(height: 12),
                    Text('History',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18)),
                    const SizedBox(height: 12),
                    _projectsList(state.project, state.project.history,
                        state.user.position)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _stack(List<StackModel> stack) {
    return Wrap(
        children: stack
            .map<Container>(
              (StackModel stack) => Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(stack.name,
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
            )
            .toList());
  }

  Widget _projectsList(
      ProjectModel project, List<UserModel> users, Positions position) {
    return Column(
        children: users
            .map(
              (UserModel user) => Slidable(
                controller:
                    position == Positions.OWNER ? _slidableController : null,
                actionPane: const SlidableDrawerActionPane(),
                enabled: position == Positions.OWNER,
                actionExtentRatio: 0.1,
                secondaryActions: <Widget>[
                  IconSlideAction(
                      color: AppColors.bg,
                      icon: Icons.history,
                      onTap: () {
                        final bool isUserOnboard = project.onboard.any(
                            (UserModel userOnBoard) =>
                                userOnBoard.id ==
                                project.history
                                    .firstWhere(
                                        (UserModel userHis) =>
                                            userHis.id == user.id,
                                        orElse: () => null)
                                    ?.id);

                        // store.dispatch(AddUserToProjectPending(
                        //     user, store.state.project.id));
                      })
                ],
                child: AppListTile(
                  onTap: () => _pushToUser(user),
                  leading: AvatarWidget(avatar: user.avatar, sizes: 50),
                  trailing:
                      Text(AppConverting.getPositionFromString(user.position)),
                  textSpan: TextSpan(
                    text: '${user.name} ${user.lastName}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
            .toList());
  }

  void _pushToUser(UserModel user) {
    store.dispatch(SetTitle('${user.name} ${user.lastName}'));
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => UserScreen(uid: user.id)));
  }

  Widget _projectInfo(String title, String desc) {
    return RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            children: <TextSpan>[
          TextSpan(
            text: desc,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          )
        ]));
  }
}
