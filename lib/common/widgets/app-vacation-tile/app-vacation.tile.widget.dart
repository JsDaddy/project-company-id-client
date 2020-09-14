import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/widgets/app-list-tile/app-list-tile.widget.dart';
import 'package:company_id_new/common/widgets/avatar/avatar.widget.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AppVacationTileWidget extends StatelessWidget {
  const AppVacationTileWidget(this.log, this.slidableController);
  final LogModel log;
  final SlidableController slidableController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Slidable(
        controller: slidableController,
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.1,
        secondaryActions: <Widget>[
          IconSlideAction(
            color: AppColors.bg,
            iconWidget: IconButton(
                icon: const Icon(Icons.check),
                color: Colors.green,
                onPressed: () {}
                // _approve(event)
                ),
          ),
          IconSlideAction(
            color: AppColors.bg,
            iconWidget: IconButton(
                icon: const Icon(Icons.close),
                color: AppColors.red,
                onPressed: () {}
                //  _reject(event)
                ),
          ),
        ],
        child: AppListTile(
          // onTap: () => _pushToUserScreen(users, event),
          leading: AvatarWidget(avatar: log.user.avatar, sizes: 50),
          textSpan: TextSpan(
              text: AppConverting.getVacationTypeString(log.vacationType),
              style: TextStyle(
                  color: AppColors.getColorTextVacation(log.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
          textSpan2: TextSpan(
            text: ' - ${log.desc}',
          ),
          trailing: Text(log.status.toString()),
        ),
      ),
    );
  }
}
