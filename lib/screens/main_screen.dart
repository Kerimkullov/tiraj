import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:tiraj/components/navbar.dart';
import 'package:tiraj/const/constants.dart';
import 'package:tiraj/screens/webview_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TirajColors.iconInActive,
      ),
      drawerEnableOpenDragGesture: false,
      drawer: NavBar(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            WebviewScreen(url: 'https://tiraj.kg/'),
            WebviewScreen(url: 'https://tiraj.kg/'),
            WebviewScreen(url: 'https://tiraj.kg/novosti/'),
            WebviewScreen(url: 'https://tiraj.kg/populyarnoe-za-mesyacz/'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController?.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: TirajColors.iconActive,
              inactiveColor: TirajColors.iconInActive,
              title: Text('Главная'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: TirajColors.iconActive,
              inactiveColor: TirajColors.iconInActive,
              title: Text('Свежее'),
              icon: Icon(Icons.new_releases)),
          BottomNavyBarItem(
              activeColor: TirajColors.iconActive,
              inactiveColor: TirajColors.iconInActive,
              title: Text('Все'),
              icon: Icon(Icons.apps)),
          BottomNavyBarItem(
              activeColor: TirajColors.iconActive,
              inactiveColor: TirajColors.iconInActive,
              title: Text('Популярное'),
              icon: Icon(Icons.favorite)),
        ],
      ),
    );
  }
}
