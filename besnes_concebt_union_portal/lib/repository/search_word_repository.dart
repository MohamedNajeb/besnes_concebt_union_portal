import 'dart:convert';

import 'package:unionportal/constants.dart';
import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

abstract class SearchWordRepository {
  Future<List<SearchWordModel>> searchByWord(String word);
}

class SearchWordRepositoryImpl extends SearchWordRepository {
  http.Response searchByWordResponse;
  List<SearchWordModel> _searchWordModelList = new List<SearchWordModel>();

  @override
  Future<List<SearchWordModel>> searchByWord(String word) async {
    searchByWordResponse =
        await http.get("$BASE_URL_TWO/CoopsPrices/search/$word");

    if (searchByWordResponse.statusCode == 200) {
      print(searchByWordResponse.body);
      List<dynamic> values = new List<dynamic>();
      values = json.decode(searchByWordResponse.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _searchWordModelList.add(SearchWordModel.fromJson(map));
            print(_searchWordModelList[0].barcode);
          }
        }
      }
      return _searchWordModelList;
    } else if (searchByWordResponse.statusCode == 404) {
      print(searchByWordResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
