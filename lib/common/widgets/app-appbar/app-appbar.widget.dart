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
  _ViewModel({this.user, this.titles});
  List<String> titles;
  UserModel user;
}

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({this.avatar, Key key}) : super(key: key);
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) =>
            _ViewModel(user: store.state.user, titles: store.state.titles),
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
                  child: AvatarWidget(avatar: avatar, sizes: 20),
                )),
            title: Text(state.titles.last),
            actions: <Widget>[logout(context)],
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
