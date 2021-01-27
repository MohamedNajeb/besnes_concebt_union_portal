part of 'social_news_bloc.dart';

@immutable
abstract class SocialNewsEvent {}

class FetchSocialNews extends SocialNewsEvent {
  final String lang;
  final int sectionId;

  FetchSocialNews(this.lang, this.sectionId);
}
