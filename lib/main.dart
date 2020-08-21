import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/screens/home/home.screen.dart';
import 'package:company_id_new/screens/splash/splash.screen.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sentry/sentry.dart';

final SentryClient sentry = SentryClient(
    dsn:
        'https://256bcf25fabc47748e8d93fa08439c18@o436633.ingest.sentry.io/5398070');

Future<void> main() async {
  runZonedGuarded(
      () => runApp(MyApp(
            store: store,
          )), (Object error, StackTrace stackTrace) async {
    if (kReleaseMode) {
      try {
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      } catch (e) {
        print(e);
      }
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({this.store});
  final Store<AppState> store;
  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider<AppState>(
        store: widget.store,
        child: BotToastInit(
          child: MaterialApp(
            navigatorObservers: <NavigatorObserver>[
              BotToastNavigatorObserver()
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              dialogTheme: const DialogTheme(
                backgroundColor: AppColors.bg,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: AppColors.red),
              unselectedWidgetColor: Colors.white,
              primaryColor: AppColors.red,
              textTheme: const TextTheme(
                  bodyText1: TextStyle(color: Colors.white),
                  bodyText2: TextStyle(color: Colors.white)),
              canvasColor: AppColors.bg,
              fontFamily: 'Helvetica',
            ),
            navigatorKey: mainNavigatorKey,
            home: SplashScreen(),
          ),
        ));
  }
}
