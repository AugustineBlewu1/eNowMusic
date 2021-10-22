import 'package:e_now_music/src/otherScreens/profileScreen.dart';
import 'package:e_now_music/src/otherScreens/searchScreen.dart';
import 'package:e_now_music/src/otherScreens/uploadScreen.dart';
import 'package:e_now_music/src/startScreens/homepage.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:ionicons/ionicons.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with RouteAware {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  int indexSelected = 0;
  bool isLoggin = false;
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
  List<Widget> options = [
    MyHomePage(),
    UpLoadScreen(),
    SearchScreen(),
    ProfileScreen()
  ];
  // final navigatorKey = GlobalKey<NavigatorState>();
  // myFunvtion() {
  //   return options.toList();
  // }

  void _selectTab(int index) {
    if (index == indexSelected) {
      // pop to first route
      // if the user taps on the active tab
      _navigatorKeys[indexSelected]
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => indexSelected = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[indexSelected].currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (indexSelected != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
          // let system handle back button if we're on the first route
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 45.0,
          width: 45.0,
          child: TextButton(
            style: buttonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(eNowColor)),
            child: Image.asset('assets/Plus.png', fit: BoxFit.fill,),
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: eNowColor,
          selectedItemColor: eNowColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: '',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.heart_outline),
                label: '',
                activeIcon: Icon(Ionicons.heart)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
                activeIcon: Icon(Ionicons.search)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: '',
                activeIcon: Icon(Icons.person)),
          ],
          currentIndex: indexSelected,
          onTap: (index) {
            setState(() {
              indexSelected = index;
            });
          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return options.elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);
    return Offstage(
        offstage: indexSelected != index,
        child: Navigator(
          key: _navigatorKeys[index],
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
                builder: (context) =>
                    routeBuilders[routeSettings.name]!(context),
                settings: routeSettings,
                maintainState: true);
          },
        ));
  }
}
