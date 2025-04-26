import 'package:app/widget/appBar.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarTop(
        title: "chart",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("증권시장 차트")],
      ),
    );
  }
}
