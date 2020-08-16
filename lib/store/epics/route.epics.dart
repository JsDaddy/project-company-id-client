import 'package:company_id_new/main.dart';
import 'package:company_id_new/screens/home/home.screen.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';

Stream<void> routeEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PushAction;
  }).map((dynamic action) {
    if (action.key != null) {
      action.key.currentState.push<dynamic>(MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => action.destination as Widget));
    } else {
      navigatorKey.currentState.push<dynamic>(MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => action.destination as Widget));
    }
  });
}

Stream<void> routePopEpic(Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PopAction;
  }).map((dynamic action) {
    if (action.key != null) {
      if (action.params != null) {
        action.key.currentState.pop<dynamic>(action.params);
      } else {
        action.key.currentState.pop<dynamic>();
      }
    } else {
      if (action.params != null) {
        navigatorKey.currentState.pop<dynamic>(action.params);
      } else {
        navigatorKey.currentState.pop<dynamic>();
      }
      navigatorKey.currentState.push<dynamic>(MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => action.destination as Widget));
    }
  });
}

Stream<void> routePushReplacmentEpic(
    Stream<dynamic> actions, EpicStore<dynamic> store) {
  return actions.where((dynamic action) {
    return action is PushReplacementAction;
  }).map((dynamic action) {
    if (action.key != null) {
      action.key.currentState.pushReplacement<dynamic, dynamic>(
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => action.destination as Widget));
    } else {
      navigatorKey.currentState.pushReplacement<dynamic, dynamic>(
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => action.destination as Widget));
    }
  });
}
