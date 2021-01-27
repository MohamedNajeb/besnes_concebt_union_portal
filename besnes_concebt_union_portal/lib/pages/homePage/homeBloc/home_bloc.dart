import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/home_slider_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeSliderRepository repository;

  HomeBloc(this.repository) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    yield HomeLoading();
    if (event is FetchHomeData) {
      try {
        final HomeSliderModel homeSlider =
            await repository.getSliderRequest(event.lang);

        final SectionsModel sections = await repository.getSections(event.lang);

        yield HomeDataLoaded(
            HomeDataModel(sections: sections, sliderNews: homeSlider));
      } catch (error) {
        yield HomeError(error.toString());
      }
    }
  }
}
