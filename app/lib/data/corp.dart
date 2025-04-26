// import 'dart:convert';
// import 'dart:io';
// import 'package:csv/csv.dart';

// import 'package:path_provider/path_provider.dart';

class Corp {
  final String _name;
  final String _code;
  final String _category;
  Corp(this._name, this._code, this._category);

  String get name => _name;
  String get code => _code;
  String get category => _category;
}

class CorpList {
  // Future<List<List<dynamic>>> file = CSVReader("CJ")._localFile;
  List<Corp> corpList = <Corp>[
    Corp("CJ", "001040", "금융업"),
    Corp("CJ CGV", "079160", "영화, 비디오물, 방송프로그램 제작 및 배급"),
    Corp("CJ대한통운", "000120", "도로 화물 운송업"),
    Corp("CJ씨푸드", "011150", "기타 식품 제조업"),
    Corp("삼성SDI", "097950", "일차전지 및 축전지 제조업"),
    Corp("삼성전자", "005930", "통신 및 방송 장비 제조업"),
    Corp("삼성증권", "016360", "금융 지원 서비스업"),
    Corp("CJ제일제당", "097950", "기타 식품 제조업"),
  ];

  List<Corp> searchCorp(String searchKey) {
    List<Corp> result = [];
    for (Corp corp in this.corpList) {
      if (corp.name.contains(searchKey)) {
        result.add(corp);
      }
    }
    return result;
  }
}

// class CSVReader {
//   final String corpName;

//   CSVReader(this.corpName);

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<List<List<dynamic>>> get _localFile async {
//     print(corpName);
//     final path = await _localPath;
//     final input = File("$path/asset/data/$corpName.csv").openRead();
//     return await input
//         .transform(utf8.decoder)
//         .transform(new CsvToListConverter())
//         .toList();
//   }
// }
