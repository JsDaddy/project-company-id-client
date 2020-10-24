import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/store/actions/auth.action.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:company_id_new/store/actions/projects.action.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: StoreConnector<AppState, dynamic>(
          converter: (Store<AppState> store) {},
          onInit: (Store<AppState> store) {
            store.dispatch(CheckTokenPending());
            store.dispatch(GetProjectPrefPending());
          },
          builder: (BuildContext context, dynamic state) {
            return const Center(
              child: Text('Company ID', style: TextStyle(fontSize: 32)),
            );
          }),
    );
  }
}
