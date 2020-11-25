import 'dart:io';

import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/common/widgets/app-appbar/app-appbar.widget.dart';
import 'package:company_id_new/common/widgets/confirm-dialog/confirm-dialog.widget.dart';
import 'package:company_id_new/common/widgets/loader/loader.widget.dart';
import 'package:company_id_new/common/widgets/notifier/notifier.widget.dart';
import 'package:company_id_new/screens/projects/projects.screen.dart';
import 'package:company_id_new/screens/rules/rules.screen.dart';
import 'package:company_id_new/screens/statistics/statisctis.screen.dart';
import 'package:company_id_new/screens/users/users.screen.dart';
import 'package:company_id_new/store/actions/route.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.user, this.requests});
  UserModel user;
  List<LogModel> requests;
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _children = <Widget>[
    StatisticsScreen(),
    UsersScreen(),
    ProjectsScreen(),
    const RulesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              user: store.state.user,
              requests: store.state.requests,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return WillPopScope(
            onWillPop: () async {
              if (navigatorKey.currentState.canPop()) {
                store.dispatch(PopAction());
              } else {
                final bool isConfirm = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const ConfirmDialogWidget(
                          title: 'Exit',
                          text: 'Are you sure to exit from application?');
                    });
                if (isConfirm) {
                  exit(0);
                }
              }
              return false;
            },
            child: Notifier(
              child: LoaderWrapper(
                child: MediaQuery.of(context).size.width <
                        MediaQuery.of(context).size.height
                    ? Scaffold(
                        appBar: AppBarWidget(avatar: state.user?.avatar ?? ''),
                        body: CustomNavigator(
                          navigatorKey: navigatorKey,
                          home: _children[_currentIndex],
                          pageRoute: PageRoutes.materialPageRoute,
                        ),
                        bottomNavigationBar: _bottomNavigation(state),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _leftNavigation(state),
                          const VerticalDivider(
                              width: 1, thickness: 1, color: Colors.black87),
                          Container(
                            width: MediaQuery.of(context).size.width - 103,
                            child: Scaffold(
                              appBar: AppBarWidget(
                                  avatar: state.user?.avatar ?? ''),
                              body: CustomNavigator(
                                navigatorKey: navigatorKey,
                                home: _children[_currentIndex],
                                pageRoute: PageRoutes.materialPageRoute,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        });
  }

  Widget _bottomNavigation(
    _ViewModel state,
  ) {
    return BottomNavigationBar(
        unselectedItemColor: Colors.white,
        onTap: (int index) => _onTabTapped(index),
        currentIndex: _currentIndex,
        items: _userBottomNav());
  }

  Widget _leftNavigation(
    _ViewModel state,
  ) {
    return Container(
        width: 100,
        child: NavigationRail(
            backgroundColor: AppColors.bg,
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) => _onTabTapped(index),
            labelType: NavigationRailLabelType.selected,
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 30),
            unselectedIconTheme:
                const IconThemeData(color: AppColors.semiGrey, size: 20),
            selectedLabelTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            unselectedLabelTextStyle: const TextStyle(
                color: AppColors.semiGrey, fontWeight: FontWeight.normal),
            destinations: _userBottomNav()
                .map((BottomNavigationBarItem item) =>
                    NavigationRailDestination(
                        icon: item.icon, label: Text(item.label)))
                .toList()));
  }

  List<BottomNavigationBarItem> _userBottomNav() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(Icons.access_alarms),
          label: store.state.user.position == Positions.Owner
              ? 'Statistics'
              : 'Timelog'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account), label: 'Employees'),
      const BottomNavigationBarItem(
        icon: Icon(Icons.desktop_mac),
        label: 'Projects',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'Info',
      ),
    ];
  }

  String _getTitleAppBar(int index) {
    switch (index) {
      case 0:
        return store.state.user.position == Positions.Owner
            ? 'Statistics'
            : 'Timelog';
      case 1:
        return 'Employees';
      case 2:
        return 'Projects';
      case 3:
        return 'Rules';
      default:
        return '';
    }
  }

  void _onTabTapped(int index) {
    navigatorKey.currentState.popUntil((Route<dynamic> route) => route.isFirst);
    store.dispatch(SetClearTitle(_getTitleAppBar(index)));

    setState(() {
      _currentIndex = index;
    });
  }
}
