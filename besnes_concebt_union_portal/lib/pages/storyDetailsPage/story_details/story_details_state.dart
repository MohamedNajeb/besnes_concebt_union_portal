part of 'story_details_bloc.dart';

@immutable
abstract class StoryDetailsState {}

class StoryDetailsInitial extends StoryDetailsState {
  StoryDetailsInitial();
}

class DetailsLoading extends StoryDetailsInitial {
  DetailsLoading();
}

class DetailsDataLoaded extends StoryDetailsInitial {
  final StoryDetailsModel model;
  DetailsDataLoaded(this.model);
}

class DetailsError extends StoryDetailsInitial {
  final String errorMessage;
  DetailsError(this.errorMessage);
}
