import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/services/converters.service.dart';
import 'package:company_id_new/common/services/refresh.service.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/common/widgets/confirm-dialog/confirm-dialog.widget.dart';
import 'package:company_id_new/screens/user/user.screen.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/vacations.action.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.requests, this.isLoading});
  List<LogModel> requests;

  bool isLoading;
}

class RequestsScreen extends StatefulWidget {
  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final SlidableController _slidableController = SlidableController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    // store.dispatch(GetRequestsPending());
    super.initState();
  }

  void _onRefresh(bool isLoading) {
    // monitor network fetch
    store.dispatch(GetRequestsPending());
    // if (!isLoading) {
    //   _refreshController.refreshCompleted();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              isLoading: store.state.isLoading,
              requests: store.state.requests,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return SmartRefresher(
            controller: refresh.refreshController,
            onRefresh: () => _onRefresh(state.isLoading),
            enablePullDown: true,
            child: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return;
              },
              child: state.requests.isEmpty
                  ? const Center(
                      child:
                          Text('No requests', style: TextStyle(fontSize: 24)))
                  : _requests(state.requests),
            ),
          );
        });
  }

  Widget _requests(List<LogModel> requests) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: requests.length,
        itemBuilder: (BuildContext context, int index) {
          final LogModel request = requests[index];
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Slidable(
                  controller: _slidableController,
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.1,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        color: AppColors.bg,
                        iconWidget: IconButton(
                            icon: const Icon(Icons.check),
                            color: Colors.green,
                            onPressed: () => _changeStatus(request.id, context,
                                'approved', 'Are you sure about approving?'))),
                    IconSlideAction(
                        color: AppColors.bg,
                        iconWidget: IconButton(
                            icon: const Icon(Icons.close),
                            color: AppColors.red,
                            onPressed: () => _changeStatus(request.id, context,
                                'rejected', 'Are you sure about rejecting?'))),
                  ],
                  child: AppListTile(
                      onTap: () => store.dispatch(
                          PushAction(UserScreen(uid: request.user.id))),
                      leading:
                          AvatarWidget(avatar: request.user.avatar, sizes: 50),
                      textSpan: TextSpan(
                          text: converter
                                  .dateFromString(request.date.toString()) +
                              ' - ' +
                              request.desc,
                          style: const TextStyle(color: Colors.white)),
                      trailing: Text(
                        AppConverting.getVacationTypeString(
                            request.vacationType),
                      ))));
        });
  }

  Future<void> _changeStatus(
      String id, BuildContext context, String status, String titleText) async {
    final bool isConfirm = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogWidget(title: 'Request', text: titleText);
        });
    if (!isConfirm) {
      return;
    }
    store.dispatch(ChangeStatusVacationPending(id, status));
    _slidableController.activeState?.close();
  }
}
