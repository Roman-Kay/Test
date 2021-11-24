import 'package:flutter/material.dart';
import 'package:test/calendar_page.dart';
import 'package:test/home_page.dart';
import 'package:test/profile.dart';
import 'package:test/screen_2.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState.maybePop();

        print(
            'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.red,
              ),
              title: Text('HOME'),
              activeIcon: Icon(
                Icons.ac_unit,
                color: Colors.red,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.red,
              ),
              title: Text('CALENDAR'),
              activeIcon: Icon(
                Icons.ac_unit,
                color: Colors.red,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.red,
                size: 36,
              ),
              title: Text('PROFILE'),
              activeIcon: Icon(
                Icons.ac_unit,
                color: Colors.red,
                size: 36,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
      ),
    );
  }

  void _next() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Screen2()));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomePage(),
          CalendarPage(
            onNext: _next,
          ),
          ProfilePage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
