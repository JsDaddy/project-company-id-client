import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/app-vacation-tile/app-vacation.tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/common/widgets/filter-item/filter-item.widget.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:company_id_new/store/models/filter.model.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/store.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/store/models/current-day.model.dart';
import 'package:company_id_new/store/actions/filter.action.dart';

class _ViewModel {
  _ViewModel({this.filter, this.logs, this.currentDate});
  FilterModel filter;
  CurrentDateModel currentDate;
  List<LogModel> logs;
}

class EventListWidget extends StatefulWidget {
  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  SlidableController _slidableController;
  LogModel holiday;
  @override
  void initState() {
    _slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            filter: store.state.filter,
            currentDate: store.state.currentDate,
            logs: store.state.logsByDate),
        builder: (BuildContext context, _ViewModel state) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              state.filter != null
                  ? Wrap(children: <Widget>[
                      state.filter?.logType?.logType != LogType.all
                          ? FilterItemWidget(
                              title: state.filter.logType?.title,
                              icon: Icons.history,
                            )
                          : Container(),
                      state.filter?.logType?.logType != null &&
                              state.filter?.logType?.logType == LogType.vacation
                          ? FilterItemWidget(
                              title: AppConverting.getVacationTypeString(
                                  state.filter.logType.vacationType),
                              icon: Icons.history,
                            )
                          : Container(),
                      state.filter?.user != null
                          ? FilterItemWidget(
                              title:
                                  '${state.filter.user.name} ${state.filter.user.lastName}',
                              icon: Icons.person,
                            )
                          : Container(),
                      state.filter?.project != null
                          ? FilterItemWidget(
                              title: state.filter.project.name,
                              icon: Icons.desktop_mac,
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          store.dispatch(ClearFilter());
                          store.dispatch(GetLogsPending(
                              '${state.currentDate.currentMohth}/all'));
                          store.dispatch(GetLogByDatePending(
                              '${state.currentDate.currentDay}/all'));
                        },
                        child: const FilterItemWidget(
                          title: 'Clear',
                          icon: Icons.close,
                        ),
                      )
                    ])
                  : Container(),
              const SizedBox(height: 16),
              state.logs
                      .where((LogModel log) => log.type == LogType.holiday)
                      .toList()
                      .isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Center(
                        child: Text(
                          state.logs
                              .where(
                                  (LogModel log) => log.type == LogType.holiday)
                              .toList()[0]
                              .name,
                          style: const TextStyle(
                              fontSize: 24, color: AppColors.red),
                        ),
                      ),
                    )
                  : Container(),
              ...state.logs
                  .where((LogModel log) => log.type == LogType.vacation)
                  .map((LogModel log) =>
                      AppVacationTileWidget(log, _slidableController))
                  .toList(),
              ...state.logs
                  .where((LogModel log) => log.type == LogType.timelog)
                  .map((LogModel log) => AppListTile(
                        leading:
                            AvatarWidget(avatar: log.user.avatar, sizes: 50),
                        textSpan: TextSpan(
                            text: log.project.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        textSpan2: TextSpan(
                          text: ' - ${log.desc}',
                        ),
                        // onTap: () => _pushToUserScreen(event, context),
                        trailing: Text(log.time),
                      ))
                  .toList()
            ],
          );
        });
  }
}
