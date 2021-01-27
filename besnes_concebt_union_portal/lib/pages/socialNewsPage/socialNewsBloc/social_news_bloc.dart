import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/social_news_repository.dart';

part 'social_news_event.dart';
part 'social_news_state.dart';

class SocialNewsBloc extends Bloc<SocialNewsEvent, SocialNewsState> {
  final SocialNewsRepository repository;

  SocialNewsBloc(this.repository) : super(SocialNewsInitial());

  @override
  Stream<SocialNewsState> mapEventToState(
    SocialNewsEvent event,
  ) async* {
    if (event is FetchSocialNews) {
      yield SocialNewsLoading();
      try {
        final CategoryModel detailsModel =
            await repository.getSocialNews(event.lang, event.sectionId);

        yield SocialNewsLoaded(detailsModel);
      } catch (error) {
        yield SocialNewsError(error.toString());
      }
    }
  }
}
