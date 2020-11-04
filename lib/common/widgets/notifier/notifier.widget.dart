import 'package:bot_toast/bot_toast.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/screens/home/home.screen.dart';
import 'package:company_id_new/store/actions/notifier.action.dart';
import 'package:company_id_new/store/models/notify.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.markAsHandled, this.notify, this.isLoading});
  final bool isLoading;
  final Function markAsHandled;
  final NotifyModel notify;
}

class Notifier extends StatelessWidget {
  const Notifier({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel(
          notify: store.state.notify,
          isLoading: store.state.isLoading,
          markAsHandled: () => store.dispatch(NotifyHandled())),
      builder: (BuildContext context, _ViewModel state) => child,
      onWillChange: (_ViewModel state, _ViewModel a) {
        if (a.notify != null && !state.isLoading) {
          a.markAsHandled();
          BotToast.showAttachedWidget(
              attachedBuilder: (_) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.secondary,
                        border: Border.all(
                            width: 1, color: _getColor(a.notify.type))),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          color: _getColor(a.notify.type),
                          child: _getIcon(a.notify.type),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Text(
                            a.notify.notificationMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
              enableSafeArea: false,
              duration: const Duration(seconds: 3),
              target: const Offset(100, 170));
        }
      },
      distinct: true,
    );
  }

  Icon _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return const Icon(
          Icons.warning,
          color: Colors.white,
          size: 24,
        );
      case NotificationType.success:
        return const Icon(
          Icons.check,
          color: Colors.white,
          size: 24,
        );
      case NotificationType.warning:
        return const Icon(
          Icons.warning,
          color: Colors.white,
          size: 24,
        );
      default:
        return const Icon(
          Icons.warning,
          color: Colors.white,
          size: 24,
        );
    }
  }

  Color _getColor(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return AppColors.darkRed;
      case NotificationType.success:
        return AppColors.green;
      case NotificationType.warning:
        return AppColors.yellow;
      default:
        return AppColors.yellow;
    }
  }
}
