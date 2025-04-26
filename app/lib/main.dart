import 'package:app/page/account.dart';
import 'package:app/page/chart.dart';
import 'package:app/page/default.dart';
import 'package:app/page/home.dart';
import 'package:app/page/search.dart';
import 'package:app/page/settings.dart';
import 'package:flutter/material.dart';
import 'package:app/page/searchResult.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(),
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/default",
      routes: {
        '/default': (BuildContext context) => const DefaultPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/account': (BuildContext context) => const AccountPage(),
        '/chart': (BuildContext context) => const ChartPage(),
        '/search': (BuildContext context) => const SearchPage(),
        '/settings': (BuildContext context) => const SettingsPage(),
        '/searchResult': (BuildContext context) => const SearchResult()
      },
    );
  }
}
