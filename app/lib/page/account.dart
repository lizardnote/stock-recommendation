import 'package:app/api/db.dart';
import 'package:app/data/recom.dart';
import 'package:app/stylle/font.dart';
import 'package:app/stylle/pallete.dart';
import 'package:app/widget/appBar.dart';
import 'package:flutter/material.dart';

FontDesign fontDesign = FontDesign();
Pallete pallete = Pallete();

EdgeInsets boxPadding = const EdgeInsets.all(5);
EdgeInsets textNoIndentPadding = const EdgeInsets.fromLTRB(30, 15, 15, 15);
EdgeInsets textIndentPadding = const EdgeInsets.fromLTRB(100, 15, 15, 15);

Widget asset = ListTile(
  visualDensity: const VisualDensity(vertical: 3),
  leading: const Icon(Icons.account_balance_outlined),
  title: Text(
    "총 보유 자산",
    overflow: TextOverflow.fade,
    style: TextStyle(
        fontSize: fontDesign.sizeSubTitle, fontWeight: FontWeight.bold),
  ),
  trailing: Text(
    "1,234,000원",
    overflow: TextOverflow.fade,
    style: TextStyle(fontSize: fontDesign.sizeSubTitle, color: pallete.accText),
  ),
  onTap: () {},
);

Widget performance = ListTile(
  visualDensity: const VisualDensity(vertical: 3),
  leading: const Icon(Icons.arrow_upward),
  title: Text(
    "수익률",
    overflow: TextOverflow.fade,
    style: TextStyle(
        fontSize: fontDesign.sizeSubTitle, fontWeight: FontWeight.bold),
  ),
  trailing: Text(
    "120%",
    overflow: TextOverflow.fade,
    style: TextStyle(fontSize: fontDesign.sizeSubTitle, color: pallete.accText),
  ),
  onTap: () {},
);

List<Widget> _buildAccountInfo() {
  List<Widget> result = [asset, performance];
  return result;
}

List<Widget> _buildRecomList(List<Recom> dat){
  List<Widget> result = [
    ListTile(title: Text("종목 명", 
      style: TextStyle(fontSize: fontDesign.sizeSubTitle, fontWeight: FontWeight.bold),),
     trailing: Text("예상 수익률",
     style: TextStyle(fontSize: fontDesign.sizeSubTitle, fontWeight: FontWeight.bold),
     ), tileColor: pallete.blue10
  ,)];
  for (Recom data in dat){
    Widget tmp = ListTile(title: Text(data.name), trailing: Text(data.pred),);
    result.add(tmp);
  }
  return result;
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<String> future = load_recom();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarTop(
        title: "account",
      ),
      body: FutureBuilder(future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }            
            else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }
            else{
              List<Recom> recoms = get_recom_list(snapshot.data);
              return Column(children: [
                Container(height: 200,
                child: ListView(children: _buildAccountInfo(),),),
                Flexible(child: ListView(children: _buildRecomList(recoms)))
                ],);
              
            }

          },
          )
      
    );
  }
}
