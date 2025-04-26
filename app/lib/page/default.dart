import 'package:app/page/account.dart';
import 'package:app/page/chart.dart';
import 'package:app/page/home.dart';
import 'package:app/page/search.dart';
import 'package:app/page/settings.dart';
import 'package:app/widget/bottom_tap.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            AccountPage(),
            // ChartPage(),
            SearchPage(),
            // SettingsPage()
          ],
        ),
        bottomNavigationBar: BottomTab(),
      ),
    );
  }
}
