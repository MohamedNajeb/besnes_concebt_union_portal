part of 'story_details_bloc.dart';

@immutable
abstract class StoryDetailsEvent {
  StoryDetailsEvent();
}

class FetchStoryDetails extends StoryDetailsEvent {
  final String lang;
  final int storyID;

  FetchStoryDetails(this.lang, this.storyID);
}

class ShareStory extends StoryDetailsEvent {
  final StoryDetailsModel detailsModel;

  ShareStory(this.detailsModel);
}
