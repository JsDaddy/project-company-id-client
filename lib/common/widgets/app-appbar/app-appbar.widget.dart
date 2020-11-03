import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/common/widgets/confirm-dialog/confirm-dialog.widget.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.user, this.title});
  // List<VacationModel> requests;
  String title;
  UserModel user;
}

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({this.avatar, Key key}) : super(key: key);
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) =>
            _ViewModel(user: store.state.user, title: store.state.title),
        builder: (BuildContext context, _ViewModel state) {
          return AppBar(
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  if ('${state.user.name} ${state.user.lastName}' ==
                      state.title) {
                    return;
                  }
                  store.dispatch(
                      SetTitle('${state.user.name} ${state.user.lastName}'));
                  store.dispatch(PushAction(UserScreen(uid: state.user.id)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarWidget(avatar: avatar, sizes: 20),
                )),
            title: Text(state.title),
            actions: <Widget>[
              // notificationBadge(state),
              logout(context)
            ],
            automaticallyImplyLeading: false,
          );
        });
  }

  Widget logout(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final bool isConfirm = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const ConfirmDialogWidget(
                        title: 'Logout', text: 'Are you sure to logout');
                  });
              if (!isConfirm) {
                return;
              }
              store.dispatch(LogoutPending());
            }),
      ],
    );
  }

  // Widget notificationBadge(_ViewModel state) {
  //   return Stack(
  //     children: <Widget>[
  //       IconButton(
  //         icon: Icon(Icons.notifications),
  //         onPressed: () {
  //           if ('Notifications' == state.title) {
  //             return;
  //           }
  //           store.dispatch(SetTitle('Notifications'));
  //           navigatorKey.currentState.push(MaterialPageRoute<void>(
  //               builder: (BuildContext context) => NotificationsScreen()));
  //         },
  //       ),
  //       Positioned(
  //         right: 8,
  //         top: 8,
  //         child: state.notifications.length > 0
  //             ? Container(
  //                 padding: EdgeInsets.all(1),
  //                 decoration: BoxDecoration(
  //                   color: bgColor,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 constraints: BoxConstraints(
  //                   minWidth: 17,
  //                   minHeight: 17,
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                     state.notifications.length.toString(),
  //                     style: TextStyle(
  //                       fontSize: 10,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               )
  //             : Container(),
  //       )
  //     ],
  //   );
  // }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
