part of 'social_news_bloc.dart';

@immutable
abstract class SocialNewsState {}

class SocialNewsInitial extends SocialNewsState {
  SocialNewsInitial();
}

class SocialNewsLoading extends SocialNewsState {
  SocialNewsLoading();
}

class SocialNewsLoaded extends SocialNewsState {
  final CategoryModel model;

  SocialNewsLoaded(this.model);
}

class SocialNewsError extends SocialNewsState {
  final String errorMessage;

  SocialNewsError(this.errorMessage);
}
