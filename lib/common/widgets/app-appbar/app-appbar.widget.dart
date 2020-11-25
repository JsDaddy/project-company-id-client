import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/common/widgets/confirm-dialog/confirm-dialog.widget.dart';
import 'package:company_id_new/screens/requests/requests.screen.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.user, this.titles, this.requests});
  List<String> titles;
  UserModel user;
  List<LogModel> requests;
}

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  AppBarWidget({this.avatar});
  final String avatar;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              user: store.state.user,
              titles: store.state.titles,
              requests: store.state.requests,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return AppBar(
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  final String fullName =
                      '${state.user.name} ${state.user.lastName}';
                  if (fullName == state.titles.last) {
                    return;
                  }

                  store.dispatch(
                      PushAction(UserScreen(uid: state.user.id), fullName));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarWidget(avatar: widget.avatar, sizes: 20),
                )),
            title: Text(state.titles.last),
            actions: <Widget>[
              state.requests.isEmpty ||
                      store.state.user.position != Positions.Owner
                  ? Container()
                  : Stack(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.notifications),
                            onPressed: () {
                              store.dispatch(
                                  PushAction(RequestsScreen(), 'Requests'));
                            }),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 22, left: 24.0),
                          child:
                              requestsBadge(state.requests.length.toString()),
                        )
                      ],
                    ),
              logout(context)
            ],
            automaticallyImplyLeading: false,
          );
        });
  }

  Widget requestsBadge(String text) {
    return Positioned(
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          constraints: const BoxConstraints(
            minWidth: 13,
            minHeight: 13,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
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
}
