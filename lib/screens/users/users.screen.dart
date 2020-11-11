import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/users.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.users, this.user, this.isLoading});
  List<UserModel> users;
  bool isLoading;
  UserModel user;
}

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  SlidableController _slidableController;
  @override
  void initState() {
    _slidableController = SlidableController();
    if (store.state.users != null && store.state.users.isNotEmpty) {
      return;
    }
    store.dispatch(GetUsersPending(true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            users: store.state.users,
            user: store.state.user,
            isLoading: store.state.isLoading),
        builder: (BuildContext context, _ViewModel state) {
          return SmartRefresher(
            controller: refresh.refreshController,
            onRefresh: () => store.dispatch(GetUsersPending(true)),
            enablePullDown: true,
            child: ListView(
                children: state.users
                    .where((UserModel user) => user.id != state.user.id)
                    .map((UserModel user) {
              return Slidable(
                  controller: _slidableController,
                  enabled: state.user.position == Positions.Owner &&
                      user.endDate == null,
                  actionExtentRatio: 0.1,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        color: AppColors.bg,
                        icon: Icons.archive,
                        onTap: () {
                          store.dispatch(ArchiveUserPending(user.id));
                        })
                  ],
                  actionPane: const SlidableDrawerActionPane(),
                  child: AppListTile(
                    leading: AvatarWidget(avatar: user.avatar, sizes: 50),
                    onTap: () => store.dispatch(PushAction(
                        UserScreen(uid: user.id),
                        '${user.name} ${user.lastName}')),
                    textSpan: TextSpan(
                        text: '${user.name} ${user.lastName}',
                        style: TextStyle(
                            fontSize: 15,
                            color: user.endDate == null
                                ? Colors.white
                                : AppColors.semiGrey)),
                    trailing: Text(
                        AppConverting.getPositionFromString(user.position),
                        style: TextStyle(
                            color: user.endDate == null
                                ? Colors.white
                                : AppColors.semiGrey)),
                  ));
            }).toList()),
          );
        });
  }
}
