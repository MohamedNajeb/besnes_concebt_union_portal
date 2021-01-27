part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  HomeEvent();
}

class FetchHomeData extends HomeEvent {
  final String lang;

  FetchHomeData(this.lang);
}
