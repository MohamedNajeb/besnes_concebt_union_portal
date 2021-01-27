import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:unionportal/models/models.dart';

import '../constants.dart';

abstract class StoryDetailsRepository {
  Future<StoryDetailsModel> getStoryDetails(String lang, int storyID);
  Future<void> shareStory(StoryDetailsModel detailsModel);
}

class StoryDetailsRepositoryImpl extends StoryDetailsRepository {
  http.Response storyDetailsResponse;

  @override
  Future<StoryDetailsModel> getStoryDetails(String lang, int storyID) async {
    storyDetailsResponse = await http.get("$root/story/$storyID?lang=ar");

    if (storyDetailsResponse.statusCode == 200) {
      print(storyDetailsResponse.body);
      return storyDetailsModelFromJson(storyDetailsResponse.body);
    } else if (storyDetailsResponse.statusCode == 404) {
      print(storyDetailsResponse.body);
    } else {
      throw Exception('Failed to load Details');
    }
  }

  @override
  Future<void> shareStory(StoryDetailsModel detailsModel) async {
    await Share.share(
        "https://www.cooopnet.com//Story/${detailsModel.results.newId}");
  }
}
