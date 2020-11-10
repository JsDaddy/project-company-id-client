import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';

class ConfirmDialogWidget extends StatelessWidget {
  const ConfirmDialogWidget({this.title, this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Builder(builder: (BuildContext context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ));
      }),
      actions: <Widget>[
        AppButtonWidget(
          color: AppColors.green,
          onClick: () => store.dispatch(PopAction(
              params: true, key: mainNavigatorKey, changeTitle: false)),
          title: 'Confirm',
        ),
        AppButtonWidget(
            title: 'Cancel',
            onClick: () => store.dispatch(PopAction(
                params: false, changeTitle: false, key: mainNavigatorKey)))
      ],
    );
  }
}
