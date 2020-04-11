import 'package:flutter/material.dart';
import 'placeholder.dart';
import 'information.dart';
import 'mapview.dart';
import 'newsWebView.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(),
    Information(),
    NewsWebView(),
    MapView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19'),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTapTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: new Text('Overview')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.info_outline),
                title: new Text('Information')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.rss_feed),
                title: Text('Covid in News')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.map),
                title: new Text('Use by Map')
            ),
          ]
      ),
    );
  }

  void onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}