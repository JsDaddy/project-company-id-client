import 'package:bot_toast/bot_toast.dart';
import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/screens/login/login.screen.dart';
import 'package:company_id_new/screens/splash/splash.screen.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp(
      store: store,
    ));

class MyApp extends StatefulWidget {
  const MyApp({this.store});
  final Store<AppState> store;
  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            initialRoute: '/',
            routes: {
              '/': (BuildContext context) => SplashScreen(),
              '/login': (BuildContext context) => LoginScreen(),
            },
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
            navigatorKey: navigatorKey,
            // home: SplashScreen(),
          ),
        ));
  }
}
