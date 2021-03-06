import 'package:company_id_new/common/services/loader.service.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.isLoading});
  final bool isLoading;
}

class LoaderWrapper extends StatelessWidget {
  const LoaderWrapper({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ViewModel(
              isLoading: store.state.isLoading,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return child;
        },
        onWillChange: (_ViewModel prev, _ViewModel curr) {
          if (prev.isLoading != curr.isLoading) {
            if (curr.isLoading) {
              loader.showLoading();
            } else {
              loader.hideLoading();
            }
          }
        });
  }
}
