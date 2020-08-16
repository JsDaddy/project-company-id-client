import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/widgets/app-appbar/app-appbar.widget.dart';
import 'package:company_id_new/common/widgets/notifier/notifier.widget.dart';
import 'package:company_id_new/main.dart';
import 'package:company_id_new/screens/statistics/statisctis.screen.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({
    this.user,
  });
  UserModel user;
  // DateTime currentDay;
  // List<VacationModel> requests;
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _children = store.state.user.role == 'admin'
      ? <Widget>[
          StatisticsScreen(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container()
        ]
      : <Widget>[Container(), Container(), Container(), Container()];
  // ? <Widget>[
  //     StatisticsScreen(),
  //     UsersScreen(),
  //     ProjectsScreen(),
  //     TimeLogScreen(),
  //     InfoScreen(),
  //     RequestsScreen(),
  //   ]
  // : <Widget>[
  //     TimeLogScreen(),
  //     UsersScreen(),
  //     ProjectsScreen(),
  //     InfoScreen()
  //   ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
              user: store.state.user,
              // requests: store.state.requests,
            ),
        builder: (BuildContext context, _ViewModel state) {
          return Notifier(
            child: Scaffold(
              appBar: AppBarWidget(avatar: state.user.avatar),
              body: CustomNavigator(
                navigatorKey: navigatorKey,
                home: IndexedStack(
                  children: _children,
                  index: _currentIndex,
                ),
                pageRoute: PageRoutes.materialPageRoute,
              ),
              bottomNavigationBar: _bottomNavigation(state),
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
        items: state.user.role == 'admin'
            // ? _adminBottomNav(state.requests)
            ? _adminBottomNav()
            : _userBottomNav());
  }

  // List<BottomNavigationBarItem> _adminBottomNav(List<VacationModel> requests) {
  //TODO do it
  List<BottomNavigationBarItem> _adminBottomNav() {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.history),
        title: Text('Statistics'),
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account), title: Text('Employees')),
      const BottomNavigationBarItem(
        icon: Icon(Icons.desktop_mac),
        title: Text('Projects'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.access_alarms),
        title: Text('Timelog'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        title: Text('Info'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.mail_outline),
        //  requests.isEmpty
        //     ? const Icon(Icons.mail_outline)
        //     : Stack(
        //         children: <Widget>[
        //           const Icon(Icons.mail_outline),
        //           requestsBadge(requests.length.toString())
        //         ],
        //       ),
        title: Text('Requests'),
      ),
    ];
  }

  Widget requestsBadge(String text) {
    return Positioned(
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: AppColors.red,
            shape: BoxShape.circle,
          ),
          constraints: const BoxConstraints(
            minWidth: 13,
            minHeight: 13,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  List<BottomNavigationBarItem> _userBottomNav() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.access_alarms), title: Text('Timelog')),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account), title: Text('Employees')),
      BottomNavigationBarItem(
        icon: Icon(Icons.desktop_mac),
        title: Text('Projects'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        title: Text('Info'),
      ),
    ];
  }

  String _getTitleAppBar(int index) {
    switch (index) {
      case 0:
        return 'Timelog';
      case 1:
        return 'Employees';
      case 2:
        return 'Projects';
      case 3:
        return 'Info';
      default:
        return '';
    }
  }

  String _getAdminTitleAppBar(int index) {
    switch (index) {
      case 0:
        return 'Statistics';
      case 1:
        return 'Employees';
      case 2:
        return 'Projects';
      case 3:
        return 'Timelog';
      case 4:
        return 'Info';
      case 5:
        return 'Requests';
      default:
        return '';
    }
  }

  void _onTabTapped(int index) {
    navigatorKey.currentState.popUntil((Route<dynamic> route) => route.isFirst);
    store.dispatch(SetTitle(store.state.user.role == 'admin'
        ? _getAdminTitleAppBar(index)
        : _getTitleAppBar(index)));

    setState(() {
      _currentIndex = index;
    });
  }
}
