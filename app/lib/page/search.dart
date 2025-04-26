import 'package:app/api/db.dart';
import 'package:app/data/corp.dart';
import 'package:app/stylle/pallete.dart';
import 'package:app/widget/appBar.dart';
import 'package:flutter/material.dart';

Pallete pallete = Pallete();
CorpList corpList = CorpList();

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = new TextEditingController();
  Future<String> future = load_names();
  List<Widget> _buildName(List<String> src){
    List<Widget> result  = [];
    for (String data in src){
      if (data.contains(_textController.text)){
        Widget tile = InkWell(child: ListTile(title: Text(data),),
        onTap: (){
          
        },
        );
        result.add(tile);
      }      
    } 
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarTop(
        title: "search",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[      
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _textController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Search',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.search),
                              width: 18,
                            )),
                        onChanged: ((value) {
                          setState(() {
                            
                          });
                        }),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("검색어");
                        print(_textController.text);
                        Navigator.pushNamed(context, '/searchResult',
                            arguments: {"searchKey": _textController.text});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: pallete.blue50,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        width: 50,
                      ),
                    )
                  ],
                ),
                Flexible(child: FutureBuilder(future: future, builder: ((BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }            
                      else if (snapshot.hasError) {
                              print(snapshot.data);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Error: ${snapshot.error}',                                  
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }
                      else {
                        List<String> names = get_name_list(snapshot.data);

                        return ListView(children: _buildName(names),);
                      }
                }),))
              ],
      ),
    );
  }
}
