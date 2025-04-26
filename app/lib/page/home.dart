import 'package:app/stylle/font.dart';
import 'package:app/stylle/pallete.dart';
import 'package:app/widget/appBar.dart';
import 'package:flutter/material.dart';

FontDesign fontDesign = FontDesign();
Pallete pallete = Pallete();

EdgeInsets boxPadding = const EdgeInsets.all(5);
EdgeInsets textNoIndentPadding = const EdgeInsets.fromLTRB(30, 15, 15, 15);
EdgeInsets textIndentPadding = const EdgeInsets.fromLTRB(100, 15, 15, 15);

List<Widget> assetBox = <Widget>[
  Container(
    padding: textNoIndentPadding,
    child: Text(
      "총 보유 자산",
      overflow: TextOverflow.fade,
      style: TextStyle(
          fontSize: fontDesign.sizeSubTitle, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    padding: textIndentPadding,
    child: Text(
      "1,234,000원",
      overflow: TextOverflow.fade,
      style: TextStyle(
          fontSize: fontDesign.sizeTitle,
          fontWeight: FontWeight.w900,
          color: pallete.accText),
    ),
  )
];

List<Widget> chartBox = <Widget>[
  Container(
      padding: textNoIndentPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("포트폴리오",
              style: TextStyle(
                  fontSize: fontDesign.sizeTitle, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "수익률",
                    style: TextStyle(
                        color: Colors.red, fontSize: fontDesign.sizeBody),
                  ),
                  Text(
                    "120%",
                    style: TextStyle(
                        color: Colors.red, fontSize: fontDesign.sizeBody),
                  ),
                ]),
          )
        ],
      )),
  Center(
    child: Container(
      child: Image(image: AssetImage('asset/img/pie_chart.PNG')),
      height: 500,
    ),
  )
];

List<Widget> recomBox = <Widget>[
  Container(
      padding: textNoIndentPadding,
      child: Text("포트폴리오 종목 추천",
          style: TextStyle(
              color: Colors.white,
              fontSize: fontDesign.sizeTitle,
              fontWeight: FontWeight.bold))),
  Container(
    padding: textNoIndentPadding,
    child: Text("워렌 버핏과 같은 포트폴리오를 갖고 싶다면 ?",
        style: TextStyle(
          color: Colors.white,
          fontSize: fontDesign.sizeBody,
          fontWeight: FontWeight.bold,
        )),
  ),
  Container(
      padding: textNoIndentPadding,
      child: Text("주식 종목 추천받고 유명투자자 포트폴리오와!",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontDesign.sizeBody,
          ))),
  Padding(
    padding: textNoIndentPadding,
    child: InkWell(
        child: Container(
            padding: textNoIndentPadding,
            child: const Text("시작하기 >",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ))),
        onTap: () {}),
  ),
];

List<Widget> routeBox = <Widget>[
  Container(
    padding: const EdgeInsets.all(30),
    child: InkWell(
        child: Text("자산 연결하러 가기 >",
            style: TextStyle(
                fontSize: fontDesign.sizeSubTitle,
                fontWeight: FontWeight.bold)),
        onTap: () {}),
  ),
];

Widget _buildBox(List<Widget> children, int id) {
  Color bgColor = pallete.blue10;
  if (id % 2 == 0) {
    bgColor = Colors.white;
  }
  Widget result = Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Flexible(
        child: Container(
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )),
      ));
  return result;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarTop(title: "default"),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Padding(padding: boxPadding, child: _buildBox(assetBox, 1)),
          Padding(
              padding: boxPadding,
              child: Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: _buildBox(chartBox, 2))),
          Padding(padding: boxPadding, child: _buildBox(recomBox, 3)),
          Padding(padding: boxPadding, child: _buildBox(routeBox, 4)),
        ],
      )),
    );
  }
}
