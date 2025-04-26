import 'package:app/stylle/pallete.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatelessWidget {
  BottomTab({Key? key}) : super(key: key);
  final Pallete pallete = Pallete();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const TabBar(
          labelColor: Color(0xff222222),
          unselectedLabelColor: Color(0xff444444),
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home, size: 18),
            ),
            Tab(
              child: Text('MY'),
            ),
            // Tab(
            //   child: Text("Chart"),
            // ),
            Tab(
              icon: Icon(Icons.search),
            ),
          ]),
    );
  }
}
