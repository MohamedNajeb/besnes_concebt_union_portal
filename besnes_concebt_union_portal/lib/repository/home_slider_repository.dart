import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

abstract class HomeSliderRepository {
  Future<HomeSliderModel> getSliderRequest(String lang);
  Future<SectionsModel> getSections(String lang);
}

class HomeSliderRepositoryImpl extends HomeSliderRepository {
  http.Response homesSliderResponse;
  http.Response sectionsResponse;

  @override
  Future<HomeSliderModel> getSliderRequest(String lang) async {
    homesSliderResponse = await http.get("$root/HomeSlider?lang=ar");

    if (homesSliderResponse.statusCode == 200) {
      print(homesSliderResponse.body);
      return homeSliderModelFromJson(homesSliderResponse.body);
    } else if (homesSliderResponse.statusCode == 404) {
      print(homesSliderResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<SectionsModel> getSections(String lang) async {
    sectionsResponse = await http.get("$root/mainMenu?lang=ar");

    if (sectionsResponse.statusCode == 200) {
      print(sectionsResponse.body);
      return sectionsModelFromJson(sectionsResponse.body);
    } else if (sectionsResponse.statusCode == 404) {
      print(sectionsResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class NetworkError extends Error {}
