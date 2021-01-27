import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

abstract class SearchRepository {
  Future<AdvancedSearchModel> getBySearchWordRequest(
    String lang,
    String searchWord,
    int sectionId,
    String fromDate,
    String toDate,
    int lastId,
  );
}

class SearchRepositoryImpl extends SearchRepository {
  http.Response advancedSearchResponse;

  @override
  Future<AdvancedSearchModel> getBySearchWordRequest(
    String lang,
    String searchWord,
    int sectionId,
    String fromDate,
    String toDate,
    int lastId,
  ) async {
    advancedSearchResponse = await http.get(
        "$root/AdvancedSearch?keyWord=$searchWord&sectionID=$sectionId&fromDate=$fromDate&toDate=$toDate&lastId=$lastId&lang=ar");

    if (advancedSearchResponse.statusCode == 200) {
      print(advancedSearchResponse.body);
      return advancedSearchModelFromJson(advancedSearchResponse.body);
    } else if (advancedSearchResponse.statusCode == 404) {
      print(advancedSearchResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
    //throw UnimplementedError();
  }
}
