import 'package:company_id_new/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

_LoaderWidget loader = _LoaderWidget();

class _LoaderWidget {
  BuildContext _dialogContext;
  bool requestClose = false;

  void showLoading() {
    hideLoading(isClean: true);
    showDialog<dynamic>(
      context: mainNavigatorKey.currentContext,
      builder: (BuildContext dialogContext) {
        _dialogContext = dialogContext;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (requestClose) {
            hideLoading();
          }
        });
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: const SpinKitDoubleBounce(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void hideLoading({bool isClean = false}) {
    if (_dialogContext != null) {
      if (Navigator.canPop(_dialogContext)) {
        Navigator.pop(_dialogContext);
      }
      _dialogContext = null;
    }
    requestClose = !isClean;
  }
}
