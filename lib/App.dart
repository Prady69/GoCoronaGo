import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_corona_go/screens/Dashboard.dart';
import 'package:go_corona_go/screens/More.dart';
import 'package:go_corona_go/screens/NewsHeadlines.dart';

import 'screens/Stats.dart';
import 'themes/dark_color.dart';
import 'themes/theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController _controller;
  String _activeScreen = 'Dashboard';
  final _pageOptions = [Dashboard(), Stats(), ListPage(), More()];
  final _pageNames = ['Dashboard', 'Stats', 'Top Headlines', 'About Me'];

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
      _activeScreen = _pageNames[index].toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DarkColor.background,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: DarkColor.background,
          title: Text(_activeScreen, style: AppTheme.titleStyle),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          highlightElevation: 0,
          onPressed: () {},
          child: Center(
            child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Image.asset(
                  "images/corona_pink.png",
                  height: 200,
                  width: 200,
                )),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: _selectedIndex,
          onTap: changeScreen,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          elevation: 8,
          fabLocation: BubbleBottomBarFabLocation.end, //new
          hasNotch: true, //new
          hasInk: true, //new, gives a cute ink effect
          inkColor: DarkColor
              .background, //optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: DarkColor.navigationBarItem,
                icon: Icon(
                  Icons.dashboard,
                  color: DarkColor.navigationBarItem,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: DarkColor.navigationBarItem,
                ),
                title: Text("Dashboard")),
            BubbleBottomBarItem(
                backgroundColor: DarkColor.navigationBarItem,
                icon: Icon(
                  Icons.assessment,
                  color: DarkColor.navigationBarItem,
                ),
                activeIcon: Icon(
                  Icons.assessment,
                  color: DarkColor.navigationBarItem,
                ),
                title: Text("Stats")),
            BubbleBottomBarItem(
                backgroundColor: DarkColor.navigationBarItem,
                icon: Icon(
                  Icons.subtitles,
                  color: DarkColor.navigationBarItem,
                ),
                activeIcon: Icon(
                  Icons.subtitles,
                  color: DarkColor.navigationBarItem,
                ),
                title: Text("News")),
            BubbleBottomBarItem(
                backgroundColor: DarkColor.navigationBarItem,
                icon: Icon(
                  Icons.menu,
                  color: DarkColor.navigationBarItem,
                ),
                activeIcon: Icon(
                  Icons.menu,
                  color: DarkColor.navigationBarItem,
                ),
                title: Text("Menu"))
          ],
        ),
        body: SafeArea(child: _pageOptions[_selectedIndex]));
  }
}
