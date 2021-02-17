// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './page1.dart';
import './page2.dart';
import './page3.dart';
import './page4.dart';
import './page5.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.white
    ),
    home: MyApp(),
    onGenerateRoute: (settings) {
      if (settings.name == '/') {
        return MaterialPageRoute(builder: (context) => Page1());
      }
      var uri = Uri.parse(settings.name);
      if (uri.pathSegments.length == 2 &&
          uri.pathSegments.first == 'test') {
        var id = uri.pathSegments[1];
        return MaterialPageRoute(builder: (context) => NavigatorTest(id: id));
      }
      return MaterialPageRoute(builder: (context) => UnknownScreen());
    },
  ),
);

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class MyApp extends StatelessWidget {

  final List<TabInfo> _tabs = [
    TabInfo('page1', Page1()),
    TabInfo('page2', Page2()),
    TabInfo('page3', Page3()),
    TabInfo('page4', Page4()),
    TabInfo('page5', Page5())
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: ChangeNotifierProvider(
        create: (context) => CartModel(),
        child:  Scaffold(
          appBar: AppBar(
            title: Text('Flutter layout demo'),
            bottom: PreferredSize(
              child: TabBar(
                isScrollable: true,
                tabs: _tabs.map((TabInfo tab) {
                  return Tab(text: tab.label);
                }).toList(),
              ),
              preferredSize: Size.fromHeight(30.0),
            ),
          ),
          body: TabBarView(
            children: _tabs.map(
              (tab) => tab.widget
            ).toList()
          ),
        )
      )
    );
  }
}
