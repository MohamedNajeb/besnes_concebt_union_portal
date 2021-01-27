import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/story_details_repository.dart';

part 'story_details_event.dart';
part 'story_details_state.dart';

class StoryDetailsBloc extends Bloc<StoryDetailsEvent, StoryDetailsState> {
  final StoryDetailsRepository repository;

  StoryDetailsBloc(this.repository) : super(StoryDetailsInitial());

  @override
  Stream<StoryDetailsState> mapEventToState(
    StoryDetailsEvent event,
  ) async* {
    if (event is FetchStoryDetails) {
      yield DetailsLoading();
      try {
        final StoryDetailsModel detailsModel =
            await repository.getStoryDetails(event.lang, event.storyID);

        yield DetailsDataLoaded(detailsModel);
      } catch (error) {
        yield DetailsError(error.toString());
      }
    }

    if (event is ShareStory) {
      try {
        await repository.shareStory(event.detailsModel);
      } catch (error) {
        print(error.toString());
      }
    }
  }
}
