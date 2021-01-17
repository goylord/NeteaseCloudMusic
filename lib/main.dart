import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/home_page.dart';
import 'package:netease_cloud_music/pages/player.dart';
import 'package:netease_cloud_music/pages/playlist.dart';
import 'package:netease_cloud_music/store/redux_store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterReduxApp(
        child: MaterialApp(
      title: '网二云音乐',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/": (context) => HomePage(),
        "/playlist": (context) => PlayListPage(),
        "/player": (context) => Player()
      },
      initialRoute: "/",
    ));
  }
}
