part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  HomeInitial();
}

class HomeLoading extends HomeState {
  HomeLoading();
}

class HomeDataLoaded extends HomeState {
  final HomeDataModel model;
  HomeDataLoaded(this.model);
}

class HomeError extends HomeState {
  final String errorMessage;
  HomeError(this.errorMessage);
}
