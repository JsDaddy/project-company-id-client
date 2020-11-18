import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/vacations.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({
    this.authUser,
  });

  UserModel authUser;
}

class AppVacationTileWidget extends StatefulWidget {
  const AppVacationTileWidget(this.log, this.slidableController);
  final LogModel log;
  final SlidableController slidableController;

  @override
  _AppVacationTileWidgetState createState() => _AppVacationTileWidgetState();
}

class _AppVacationTileWidgetState extends State<AppVacationTileWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              authUser: store.state.user,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: Slidable(
              controller: widget.slidableController,
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.1,
              enabled: state.authUser.position == Positions.Owner &&
                  widget.log.status == RequestStatus.Pending,
              secondaryActions: <Widget>[
                IconSlideAction(
                  color: AppColors.bg,
                  iconWidget: IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                      onPressed: () {
                        store.dispatch(ChangeStatusVacationPending(
                          widget.log.id,
                          RequestStatus.Approved,
                        ));
                        widget.slidableController.activeState?.close();
                      }),
                ),
                IconSlideAction(
                  color: AppColors.bg,
                  iconWidget: IconButton(
                      icon: const Icon(Icons.close),
                      color: AppColors.red,
                      onPressed: () {
                        store.dispatch(ChangeStatusVacationPending(
                          widget.log.id,
                          RequestStatus.Rejected,
                        ));
                        widget.slidableController.activeState?.close();
                      }),
                ),
              ],
              child: AppListTile(
                  onTap: () => store.dispatch(PushAction(
                      UserScreen(uid: widget.log.user.id),
                      '${widget.log.user.name} ${widget.log.user.lastName}')),
                  leading: state.authUser.position == Positions.Owner
                      ? AvatarWidget(avatar: widget.log.user.avatar, sizes: 50)
                      : null,
                  textSpan: TextSpan(
                      text: AppConverting.getVacationTypeString(
                          widget.log.vacationType),
                      style: TextStyle(
                          color: AppColors.getColorTextVacation(
                              AppConverting.getStringFromRequestStatus(
                                  widget.log.status)),
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  textSpan2: TextSpan(
                    text: ' - ${widget.log.desc}',
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
          );
        });
  }
}
