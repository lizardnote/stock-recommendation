import 'package:app/data/corp.dart';
import 'package:app/stylle/font.dart';
import 'package:app/stylle/pallete.dart';
import 'package:app/widget/appBar.dart';
import 'package:flutter/material.dart';

CorpList corpList = CorpList();
FontDesign fontDesign = FontDesign();
Pallete pallete = Pallete();

EdgeInsets boxPadding = const EdgeInsets.all(5);
EdgeInsets textNoIndentPadding = const EdgeInsets.fromLTRB(30, 15, 15, 15);
EdgeInsets textIndentPadding = const EdgeInsets.fromLTRB(100, 15, 15, 15);

List<Widget> _buildBody(String searchKey) {
  List<Widget> result = [];
  List<Corp> search = corpList.searchCorp(searchKey);
  for (Corp corp in search) {
    result.add(ListTile(
      title: Text(
        corp.name,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: fontDesign.sizeSubTitle, color: pallete.accText),
      ),
      trailing: Text(
        corp.category,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: fontDesign.sizeSubTitle, color: pallete.accText),
      ),
    ));
  }
  return result;
}

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    print("여기");
    Map<String, dynamic>? info =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String searchKey = info!['searchKey'] ?? "";
    return Scaffold(
      appBar: AppbarTop(
        title: "searchResult",
      ),
      body: SafeArea(
          child: ListView(
        children: _buildBody(searchKey),
      )),
    );
  }
}
