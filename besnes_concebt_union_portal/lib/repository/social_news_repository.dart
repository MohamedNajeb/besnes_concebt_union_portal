import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

abstract class SocialNewsRepository {
  Future<CategoryModel> getSocialNews(String lang, int sectionId);
}

class SocialNewsRepositoryImpl extends SocialNewsRepository {
  http.Response socialNewsResponse;

  @override
  Future<CategoryModel> getSocialNews(String lang, int sectionId) async {
    socialNewsResponse = await http.get("$root/section/$sectionId?lang=ar");

    if (socialNewsResponse.statusCode == 200) {
      print(socialNewsResponse.body);
      return categoryModelFromJson(socialNewsResponse.body);
    } else if (socialNewsResponse.statusCode == 404) {
      print(socialNewsResponse.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}
