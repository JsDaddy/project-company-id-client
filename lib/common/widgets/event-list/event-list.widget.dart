import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/app-vacation-tile/app-vacation.tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EventListWidget extends StatefulWidget {
  const EventListWidget(this.logs);
  final List<LogModel> logs;

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
    return ListView(
      children: <Widget>[
        const SizedBox(height: 16),
        widget.logs
                .where((LogModel log) => log.type == LogType.holiday)
                .toList()
                .isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Text(
                    widget.logs
                        .where((LogModel log) => log.type == LogType.holiday)
                        .toList()[0]
                        .name,
                    style: const TextStyle(fontSize: 24, color: AppColors.red),
                  ),
                ),
              )
            : Container(),
        ...widget.logs
            .where((LogModel log) => log.type == LogType.vacation)
            .map((LogModel log) =>
                AppVacationTileWidget(log, _slidableController))
            .toList(),
        ...widget.logs
            .where((LogModel log) => log.type == LogType.timelog)
            .map((LogModel log) => AppListTile(
                  leading: AvatarWidget(avatar: log.user.avatar, sizes: 50),
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
  }
}
