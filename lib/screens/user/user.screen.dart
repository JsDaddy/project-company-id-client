import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-images.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/socials-rows/social-row-icon/social-row-icon.widget.dart';
import 'package:company_id_new/common/widgets/socials-rows/social-row.widget.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
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
  _ViewModel({this.user, this.authUser});
  UserModel user;
  UserModel authUser;
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
            ),
        onInit: (Store<AppState> store) {
          print(widget.uid);
          store.dispatch(GetUserPending(widget.uid));
        },
        builder: (BuildContext context, _ViewModel state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 16),
                const Text(
                  'Personal details',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: SocialRowIconWidget(
                        icon: Icons.cake,
                        title: DateFormat('dd/MM/yyyy').format(state.user.date),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: SocialRowIconWidget(
                        icon: Icons.supervised_user_circle,
                        title: AppConverting.getPositionFromString(
                            state.user.position),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: SocialRowIconWidget(
                        icon: Icons.language,
                        title: state.user.englishLevel,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Contacts',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
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
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: state.user.skype != null
                          ? GestureDetector(
                              onTap: () => _openUrl(
                                    'skype:${state.user.skype}',
                                  ),
                              child: SocialRowWidget(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      36,
                                  iconName: AppImages.skype,
                                  title: state.user.skype))
                          : Container(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: state.user.email != null
                          ? GestureDetector(
                              onTap: () => _openUrl(
                                    'mailto:${state.user.email}',
                                  ),
                              child: SocialRowIconWidget(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      36,
                                  icon: Icons.email,
                                  title: state.user.email))
                          : Container(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: state.user.phone != null
                          ? GestureDetector(
                              onTap: () => _openUrl(
                                    'tel://:${state.user.phone}',
                                  ),
                              child: SocialRowIconWidget(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      36,
                                  icon: Icons.phone,
                                  title: state.user.phone))
                          : Container(),
                    ),
                  ],
                ),
                state.authUser.position == Positions.OWNER
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  'Vacations available: ${state.user.vacationAvailable} of 18'),
                              Text(
                                  'Sick available: ${state.user.sickAvailable} of 5'),
                            ]))
                    : Container(),
                const SizedBox(height: 16),
                const Text(
                  'Active Projects ',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 18),
                ),
                const SizedBox(height: 8),
                _projects(
                    state.user.activeProjects, state.authUser.position, true),
                const SizedBox(height: 16),
                const Text(
                  'Projects ',
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 18),
                ),
                _projects(state.user.projects, state.authUser.position, false),
              ],
            ),
          );
        });
  }

  Widget _projects(
      List<ProjectModel> projects, Positions position, bool isActive) {
    return ListView.builder(
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
              // enabled: position == Positions.OWNER && isActive,
              enabled: false,
              actionExtentRatio: 0.1,
              secondaryActions: <Widget>[
                IconSlideAction(
                    color: AppColors.bg, icon: Icons.history, onTap: () {})
              ],
              child: AppListTile(
                onTap: () {},
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
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      store.dispatch(
          Notify(NotifyModel(NotificationType.error, 'Could not launch $url')));
    }
  }
}
