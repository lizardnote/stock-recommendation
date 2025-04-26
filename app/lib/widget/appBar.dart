import 'package:app/stylle/button.dart';
import 'package:app/stylle/pallete.dart';
import 'package:flutter/material.dart';

class AppbarTop extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size preferredSize = const Size.fromHeight(60.0);
  ButtonDesign buttonDesign = ButtonDesign();
  Pallete pallete = Pallete();
  final String title;

  AppbarTop({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Text(
          "HAN2M",
          style: TextStyle(
              color: pallete.blue10,
              // color: Color(0xffb3cde0),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      leading: title == "settings" || title == "searchResult"
          ? GestureDetector(
              child: Container(
                margin: buttonDesign.margin,
                width: 40,
                height: 40,
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: pallete.smallButton,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          : Container(),
      actions: <Widget>[
        InkWell(
          child: Container(
            margin: buttonDesign.margin,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.more_vert_rounded,
              size: 30,
              color: Colors.grey,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/settings',
            );
          },
        ),
      ],
    );
  }
}
