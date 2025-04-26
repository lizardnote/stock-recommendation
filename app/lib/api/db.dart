import 'package:app/data/recom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


List<Recom> get_recom_list(String source){
  List<String> dat = source.split("::");
  List<Recom> result = [];
  for (String data in dat){
    List<String> tmp = data.split("##");
    if (tmp[1]=="nan"){
      continue;
    } else{
      double pred = double.parse(tmp[1])*100;      
      result.add(Recom(tmp[0], "+"+pred.toStringAsFixed(0)+"%"));
    }    
  } 
  
  return result;
}

List<String> get_name_list(String source){
  List<String> dat = source.split("::");
  return dat;
}


Future<String> load_recom() async{
  Map<String, String> headers = {
    "Accept": 'text/plain',
    "Content-Type": 'text/plain',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Method": "*",
    'Access-Control-Allow-Headers': '*',
  };
  http.Response response = await http.get(Uri.parse("http://13.115.221.99:5000/recom"), headers: headers);
  return utf8.decode(response.bodyBytes);
}


Future<String> load_names() async{
  Map<String, String> headers = {
    "Accept": 'text/plain',
    "Content-Type": 'text/plain',
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Method": "*",
    'Access-Control-Allow-Headers': '*',
  };
  http.Response response = await http.get(Uri.parse("http://13.115.221.99:5000/name"), headers: headers);
  return utf8.decode(response.bodyBytes);
}


